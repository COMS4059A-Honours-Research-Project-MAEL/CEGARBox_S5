#include "TrieformProverS5.h"

shared_ptr<Cache> TrieformProverS5::persistentCache = make_shared<PrefixCache>("P");

unsigned int TrieformProverS5::assumptionsSize = 0;
GlobalSolutionMemo TrieformProverS5::globalMemo = GlobalSolutionMemo();
unordered_map<string, unsigned int> TrieformProverS5::idMap = unordered_map<string, unsigned int>();
KripkeModelS5 TrieformProverS5::model = KripkeModelS5();
shared_ptr<Node> TrieformProverS5::root = make_shared<Node>();

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
  if (this->constructModel){
    root->parent = nullptr;
    return prove(root, vector<shared_ptr<Bitset>>(), assumptions);
  }

  return prove(vector<shared_ptr<Bitset>>(), assumptions);
}


void TrieformProverS5::printModel() {
  model.build(root);
  model.print();
}


Solution TrieformProverS5::prove(vector<shared_ptr<Bitset>> history, literal_set assumptions) {
  // Check solution memo
  shared_ptr<Bitset> assumptionsBitset = convertAssumptionsToBitset(assumptions);
  GlobalSolutionMemoResult memoResult = globalMemo.getFromMemo(assumptionsBitset, modality);
  literal_set currentModel;

  if (memoResult.inSatMemo) {
    return memoResult.result;
  }

  // If the assumptions are in a higher valuation, connect back so it is
  // satisfiable
  if (isInHistory(history, assumptionsBitset)) {
    return {true, literal_set()};
  }

  // Solve locally
  restart:
  Solution solution = prover->solve(assumptions);
  currentModel = prover -> getModel();

  if (!solution.satisfiable) {
    globalMemo.insertUnsat(assumptionsBitset, solution.conflict, modality);
    return solution;
  }

  prover->calculateTriggeredDiamondsClauses();
  modal_literal_map triggeredDiamonds = prover->getTriggeredDiamondClauses();

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

      // Run the solver on current level
      history.push_back(assumptionsBitset);
      Solution childSolution = prove(history, childAssumptions);
      history.pop_back();

      if (childSolution.satisfiable) {
        continue;
      }

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
      goto restart;
    }
  }

  globalMemo.insertSat(assumptionsBitset, currentModel, modality);
  return solution;
}


Solution TrieformProverS5::prove(shared_ptr<Node> node, vector<shared_ptr<Bitset>> history, literal_set assumptions) {
  // Check solution memo
  shared_ptr<Bitset> assumptionsBitset = convertAssumptionsToBitset(assumptions);
  GlobalSolutionMemoResult memoResult = globalMemo.getFromMemo(assumptionsBitset, modality);
  literal_set currentModel;

  if (memoResult.inSatMemo) {
      // --- Restore cached model into the node ---
      node->valuation = memoResult.witness;
      // --- Validate cached model against current solver ---
      bool valid = true;
      for (const Literal &lit : node->valuation) {
          // modelSatisfiesAssump checks literal truth under current solver's assignment
          if (!prover->modelSatisfiesAssump(lit)) {
              valid = false;
              break;
          }
      }

      if (valid) {
          // Model still valid under current clauses
          return memoResult.result;
      } else {
          // Cached model is stale, recompute this node
          node->valuation.clear();
          // (fall through to normal solving)
      }
  }

  // If the assumptions are in a higher valuation, connect back so it is
  // satisfiable
  if (isInHistory(history, assumptionsBitset)) {
    // node->valuation = memoResult.witness; 
    return {true, literal_set()};
  }

  // Solve locally
  restart:
  Solution solution = prover->solve(assumptions);

  if (!solution.satisfiable) {
    globalMemo.insertUnsat(assumptionsBitset, solution.conflict, modality);
    return solution;
  }

  node -> valuation = currentModel = prover->getModel();
  node -> children.clear();

  prover->calculateTriggeredDiamondsClauses();
  modal_literal_map triggeredDiamonds = prover->getTriggeredDiamondClauses();

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

      shared_ptr<Node> child = make_shared<Node>();

      // Run the solver on current level
      history.push_back(assumptionsBitset);
      Solution childSolution = prove(child, history, childAssumptions);
      history.pop_back();

      if (childSolution.satisfiable) {
        if (child -> valuation.size() != 0) {
          child -> parent = node;
          node -> children.push_back(child);
        }
        continue;
      }

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
      goto restart;
    }
  }

  globalMemo.insertSat(assumptionsBitset, currentModel, modality);
  return solution;
}


void TrieformProverS5::preprocess() {
  reflexiveHandleBoxClauses();
  reflexivepropagateLevels();
  
  pruneTrie();
  
  makePersistence();

  // 
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
  for (auto modalitySubtrie : subtrieMap) {
    dynamic_cast<TrieformProverS5 *>(modalitySubtrie.second.get())
        ->propagateSymmetricBoxes();
  }
  for (auto const& [modality, child_trie] : subtrieMap) {
      for (const ModalClause &boxClause : child_trie->getClauses().getBoxClauses()) {
          // A clause a -> []b in child implies ~b -> []~a in the parent.
          if (modality == boxClause.modality) {
            clauses.addBoxClause(boxClause.modality, boxClause.right->negate(), boxClause.left->negate());
          }
      }
  }
}
