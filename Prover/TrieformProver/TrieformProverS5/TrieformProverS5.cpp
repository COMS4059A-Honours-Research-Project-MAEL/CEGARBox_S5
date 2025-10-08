#include "TrieformProverS5.h"

shared_ptr<Cache> TrieformProverS5::persistentCache = make_shared<PrefixCache>("P");

unsigned int TrieformProverS5::assumptionsSize = 0;
GlobalSolutionMemo TrieformProverS5::globalMemo = GlobalSolutionMemo();
unordered_map<string, unsigned int> TrieformProverS5::idMap = unordered_map<string, unsigned int>();
KripkeModelS5 TrieformProverS5::model = KripkeModelS5();

shared_ptr<Trieform>
TrieformFactory::makeTrieS5(const shared_ptr<Formula> &formula,
          shared_ptr<Trieform> trieParent) {
  shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverS5());
  trie->initialise(formula, trieParent);
  return trie;
}
shared_ptr<Trieform>
TrieformFactory::makeTrieS5(const shared_ptr<Formula> &formula,
                            const vector<int> &newModality,
                            shared_ptr<Trieform> trieParent) {
  shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverS5());
  trie->initialise(formula, newModality, trieParent);
  return trie;
}
shared_ptr<Trieform>
TrieformFactory::makeTrieS5(const vector<int> &newModality,
                            shared_ptr<Trieform> trieParent) {
  shared_ptr<Trieform> trie = shared_ptr<Trieform>(new TrieformProverS5());
  trie->initialise(newModality, trieParent);
  return trie;
}

TrieformProverS5::TrieformProverS5() {}
TrieformProverS5::~TrieformProverS5() {}

shared_ptr<Trieform>
TrieformProverS5::create(const shared_ptr<Formula> &formula) {
  return TrieformFactory::makeTrieS5(formula, shared_from_this());
}
shared_ptr<Trieform>
TrieformProverS5::create(const shared_ptr<Formula> &formula,
                         const vector<int> &newModality) {
  return TrieformFactory::makeTrieS5(formula, newModality, shared_from_this());
}
shared_ptr<Trieform> TrieformProverS5::create(const vector<int> &newModality) {
  return TrieformFactory::makeTrieS5(newModality, shared_from_this());
}


shared_ptr<Bitset>
TrieformProverS5::convertAssumptionsToBitset(literal_set literals) {
  shared_ptr<Bitset> bitset =
      shared_ptr<Bitset>(new Bitset(2 * assumptionsSize));
  for (Literal literal : literals) {
    bitset->set(2 * idMap[literal.getName()] + literal.getPolarity());
  }
  return bitset;
}


void TrieformProverS5::updateSolutionMemo(const shared_ptr<Bitset> &assumptions,
                                          Solution solution) {
  if (solution.satisfiable) {
    globalMemo.insertSat(assumptions, modality);
  } else {
    globalMemo.insertUnsat(assumptions, solution.conflict, modality);
  }
}


bool TrieformProverS5::isInHistory(vector<shared_ptr<Bitset>> history,
                                   shared_ptr<Bitset> bitset) {
  for (shared_ptr<Bitset> assump : history) {
    if (assump->contains(*bitset)) {
      return true;
    }
  }
  return false;
}


void TrieformProverS5::prepareSAT(name_set extra) {
  // Shortcut only do this for level 1 as reflexivity guarantees every possible
  // assumption is here. Renaming could stuff this up
  for (string name : extra) {
    idMap[name] = assumptionsSize++;
  }

  for (ModalClause clause : clauses.getDiamondClauses()) {
    extra.insert(prover->getPrimitiveName(clause.right));
  }
  
  modal_names_map modalExtras = prover->prepareSAT(clauses, extra);
  for (auto modalSubtrie : subtrieMap) {
    modalSubtrie.second->prepareSAT(modalExtras[modalSubtrie.first]);
  }
}


Solution TrieformProverS5::prove(literal_set assumptions = literal_set()) {

  shared_ptr<TraceNode> root = make_shared<TraceNode>();
  root->parent = nullptr;
  
  Solution solution = prove(root, vector<shared_ptr<Bitset>>(), assumptions);

  if (!solution.satisfiable) return solution;

  buildKripkeFromTrace(root);

  return solution;
}


inline bool isAuxiliaryLiteral(const string& name) {
    return name.empty() || name[0] == 'P' || name[0] == 'x' || name[0] == '$';
}


Solution TrieformProverS5::prove(const shared_ptr<TraceNode>& node, vector<shared_ptr<Bitset>> history, literal_set assumptions) {
  // Check solution memo
  shared_ptr<Bitset> assumptionsBitset = convertAssumptionsToBitset(assumptions);
  GlobalSolutionMemoResult memoResult = globalMemo.getFromMemo(assumptionsBitset, modality);
  
  if (memoResult.inSatMemo) {
    return memoResult.result;
  }
  // If the assumptions are in a higher valuation, connect back so it is
  // satisfiable
  if (isInHistory(history, assumptionsBitset)) {
    return {true, literal_set()};
  }
  // Solve locally
  Solution solution = prover->solve(assumptions);

  if (!solution.satisfiable) {
    updateSolutionMemo(assumptionsBitset, solution);
    return solution;
  }

  node->valuation = prover->getModel();

  prover->calculateTriggeredDiamondsClauses();
  modal_literal_map triggeredDiamonds = prover->getTriggeredDiamondClauses();

  // If there are no fired diamonds, it is satisfiable
  if (triggeredDiamonds.size() == 0) {
    updateSolutionMemo(assumptionsBitset, solution);
    return solution;
  }

  prover->calculateTriggeredBoxClauses();
  modal_literal_map triggeredBoxes = prover->getTriggeredBoxClauses();

  for (const auto& modalityDiamonds : triggeredDiamonds) {
    // Handle each modality
    if (modalityDiamonds.second.size() == 0) {
      // If there are no triggered diamonds of a certain modality we can skip it
      continue;
    }
    // Note in the cases diamonds are a subset of boxes then we don't need to
    // create any worlds (reflexivity satisfies this)
    diamond_queue diamondPriority = prover->getPrioritisedTriggeredDiamonds(modalityDiamonds.first);
    while (!diamondPriority.empty()) {
      // Create a world for each diamond if necessary
      Literal diamond = diamondPriority.top().literal;
      diamondPriority.pop();

      // If the diamond is already satisfied by reflexivity no need to create
      // a successor.
      if (prover->modelSatisfiesAssump(diamond)) {
        continue;
      }

      literal_set childAssumptions = literal_set(triggeredBoxes[modalityDiamonds.first]);
      childAssumptions.insert(diamond);

      shared_ptr<TraceNode> child = make_shared<TraceNode>();
      child->parent = node;
      node->children.push_back(child);
      node->causeDiamonds.push_back(diamond);


      // Run the solver on current level
      history.push_back(assumptionsBitset);
      Solution childSolution = prove(child, history, childAssumptions);
      history.pop_back();

      if (childSolution.satisfiable) {
        continue;
      }

      // Remove all worlds created from the current world
      node->children.pop_back();
      node->causeDiamonds.pop_back();

      // Otherwise there must have been a conflict
      vector<literal_set> badImplications = prover->getNotProblemBoxClauses(modalityDiamonds.first, childSolution.conflict);

      if (childSolution.conflict.find(diamond) != childSolution.conflict.end()) {
        // The diamond clause, either on its own or together with box clauses,
        // caused a conflict. We must add diamond implies OR NOT problem box
        // clauses.
        prover->updateLastFail(diamond);
        badImplications.push_back(prover->getNotDiamondLeft(modalityDiamonds.first, diamond));
      } else {
        // Should be able to remove this (boxes must be able to satisfied
        // because of reflexivity)
        // Only the box clauses caused a conflict, so
        // we must add each diamond clause implies OR NOT problem box lefts
        badImplications.push_back(prover->getNotAllDiamondLeft(modalityDiamonds.first));
      }

      // Add ~leftDiamond=>\/~leftProbemBox
      for (literal_set learnClause : generateClauses(badImplications)) {
          prover->addClause(learnClause);
      }

      // Find new result
      // goto restart;
      return prove(node, history, assumptions);
    }
  }


  // If we reached here the solution is satisfiable under all modalities  
  updateSolutionMemo(assumptionsBitset, solution);
  return solution;
}

void TrieformProverS5::buildKripkeFromTrace(const std::shared_ptr<TraceNode>& root) {
    if (!root) {
        return;
    }
    
    // 1. Reset the model and caches for a fresh build.
    nodeToWorldIdCache.clear();

    // Tracks unique valuations via their signatures to avoid creating duplicate worlds.
    std::unordered_map<std::string, unsigned int> signatureToWorldId;

    // 2. Start the recursive build process.
    buildModelRecursive(root, signatureToWorldId);

    // 3. Finalize the model by making accessibility an equivalence relation (S5).
    model.finalizeToS5();
}

// --- Private Helper Methods ---

std::string TrieformProverS5::getValuationSignature(const literal_set& valuation) const {
    std::vector<std::string> names;
    names.reserve(valuation.size()); // Pre-allocate memory to avoid reallocations.

    for (const auto& lit : valuation) {
        if (isAuxiliaryLiteral(lit.getName())) {
            continue; // Skip internal/auxiliary literals.
        }
        // Prepend "-" for negative literals to ensure uniqueness.
        names.push_back((lit.getPolarity() ? "" : "-") + lit.getName());
    }

    // Sorting ensures that valuations with the same literals in a different
    // order (e.g., {p, q} and {q, p}) produce the same signature.
    std::sort(names.begin(), names.end());

    // Use a stringstream for more efficient string concatenation.
    std::stringstream signatureStream;
    for (size_t i = 0; i < names.size(); ++i) {
        signatureStream << names[i] << (i < names.size() - 1 ? "|" : "");
    }
    return signatureStream.str();
}

unsigned int TrieformProverS5::buildModelRecursive(
    const std::shared_ptr<TraceNode>& currentNode,
    std::unordered_map<std::string, unsigned int>& signatureToWorldId
) {
    // Use the cache to avoid re-processing an already-visited node.
    if (auto it = nodeToWorldIdCache.find(currentNode); it != nodeToWorldIdCache.end()) {
        return it->second;
    }

    // === Step A: Get or create the world for the current node ===
    const std::string signature = getValuationSignature(currentNode->valuation);
    
    unsigned int sourceWorldId;

    // Use try_emplace (C++17) to efficiently find a key or insert it if absent.
    // This avoids doing a separate find() and then insert().
    auto [iterator, inserted] = signatureToWorldId.try_emplace(signature, 0);

    if (inserted) {
        // First time seeing this valuation: create a new world.
        int newWorldId = model.createWorld(currentNode->valuation);
        sourceWorldId = static_cast<unsigned int>(newWorldId);
        iterator->second = sourceWorldId; // Store the new ID in the map.
    } else {
        // A world for this valuation already exists; reuse its ID.
        sourceWorldId = iterator->second;
    }
    
    // Cache the resulting world ID for this specific trace node.
    nodeToWorldIdCache[currentNode] = sourceWorldId;

    // === Step B: Recurse on children and add accessibility edges ===
    for (const auto& childNode : currentNode->children) {
        // The recursive call ensures the child's world is created and returns its ID.
        unsigned int targetWorldId = buildModelRecursive(childNode, signatureToWorldId);
        model.addEdge(sourceWorldId, targetWorldId);
    }
    
    return sourceWorldId;
}


void TrieformProverS5::preprocess() {
  reflexiveHandleBoxClauses();
  reflexivepropagateLevels();
  
  pruneTrie();
  
  makePersistence();

  propagateSymmetricBoxes();
}


void TrieformProverS5::reflexiveHandleBoxClauses() {
  for (ModalClause modalClause : clauses.getBoxClauses()) {
    formula_set newOr;
    newOr.insert(Not::create(modalClause.left)->negatedNormalForm());
    newOr.insert(modalClause.right);
    clauses.addClause(Or::create(newOr));
  }
  for (auto modalSubtrie : subtrieMap) {
    dynamic_cast<TrieformProverS5 *>(modalSubtrie.second.get())
        ->reflexiveHandleBoxClauses();
  }
}

void TrieformProverS5::reflexivepropagateLevels() {
  for (auto modalSubtrie : subtrieMap) {
    dynamic_cast<TrieformProverS5 *>(modalSubtrie.second.get())
        ->reflexivepropagateLevels();
    overShadow(modalSubtrie.second, modalSubtrie.first);
  }
}

void TrieformProverS5::pruneTrie() {
  for (auto modalSubtrie : subtrieMap) {
    if (modalSubtrie.second->hasSubtrie(modalSubtrie.first)) {
      modalSubtrie.second->removeSubtrie(modalSubtrie.first);
    }
    dynamic_cast<TrieformProverS5 *>(modalSubtrie.second.get())->pruneTrie();
  }
}

void TrieformProverS5::makePersistence() {
  for (auto modalSubtrie : subtrieMap) {
    dynamic_cast<TrieformProverS5 *>(modalSubtrie.second.get())
        ->makePersistence();
  }

  modal_clause_set persistentBoxes;
  for (ModalClause boxClause : clauses.getBoxClauses()) {
    // For a=>[]b in our box clauses replace with.
    // a=>Pb
    // Pb=>[]Pb
    // [](Pb=>b)

    // Make persistence (Pb=>[]Pb). Don't need to add Pb=>Pb
    shared_ptr<Formula> persistent =
        persistentCache->getVariableOrCreate(boxClause.right);
    persistentBoxes.insert({boxClause.modality, persistent, persistent});

    // Add a=>Pb
    formula_set leftSet;
    leftSet.insert(Not::create(boxClause.left)->negatedNormalForm());
    leftSet.insert(persistent);
    clauses.addClause(Or::create(leftSet));

    // Add b=>Pb and [](b=>Pb) where appropriate
    formula_set rightSet;
    rightSet.insert(Not::create(persistent)->negatedNormalForm());
    rightSet.insert(boxClause.right);
    shared_ptr<Formula> rightOr = Or::create(rightSet);
    
    propagateClauses(rightOr);
    if (hasSubtrie(boxClause.modality)) {
      subtrieMap[boxClause.modality]->propagateClauses(rightOr);
    }
  }
  clauses.setBoxClauses(persistentBoxes);

  for (ModalClause persistentBox : persistentBoxes) {
    if (hasSubtrie(persistentBox.modality)) {
      subtrieMap[persistentBox.modality]->clauses.addBoxClause(persistentBox);
    }
  }
}


void TrieformProverS5::propagateSymmetricBoxes() {
  for (auto const& [modality, child_trie] : subtrieMap) {
      for (const ModalClause &boxClause : child_trie->getClauses().getBoxClauses()) {
          // A clause a -> []b in the cluster (child) implies ~b -> []~a in the parent.
          clauses.addBoxClause(boxClause.modality, boxClause.right->negate(), boxClause.left->negate());
      }
  }
}


void TrieformProverS5::printKripkeModel(){
  model.print();
}