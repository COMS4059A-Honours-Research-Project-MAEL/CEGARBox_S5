#include "Box.h"

Box::Box(int modality, int power, shared_ptr<Formula> subformula) {
  modality_ = modality;
  power_ = power;

  Box *boxFormula = dynamic_cast<Box *>(subformula.get());
  if (boxFormula) {
    if (boxFormula->getModality() == modality_) {
      power_ += boxFormula->getPower();
      subformula_ = boxFormula->getSubformula();
    } else {
      subformula_ = subformula;
    }
  } else {
    subformula_ = subformula;
  }
  std::hash<FormulaType> ftype_hash;
  std::hash<int> int_hash;
  size_t totalHash = ftype_hash(getType());
  boxHash_ = totalHash + int_hash(modality_) + int_hash(power_) + subformula_->hash();
}

Box::~Box() {
#if DEBUG_DESTRUCT
  cout << "DESTRUCTING BOX" << endl;
#endif
}

int Box::getModality() const { return modality_; }

int Box::getPower() const { return power_; }

shared_ptr<Formula> Box::getSubformula() const { return subformula_; }

void Box::incrementPower() { power_++; }

string Box::toString() const {
    string ret = "";
    for (int i = 0; i < power_; ++i) ret += "[r" + to_string(modality_) + "]";
    return ret + subformula_->toString();
         
}

FormulaType Box::getType() const { return FBox; }

shared_ptr<Formula> Box::negatedNormalForm() {
  subformula_ = subformula_->negatedNormalForm();
  return shared_from_this();
}


shared_ptr<Formula> Box::tailNormalForm() {
    assert (1 == 0);
}

shared_ptr<Formula> Box::negate() {
  return Diamond::create(modality_, power_, subformula_->negate());
}


shared_ptr<Formula> Box::simplify() {
  // 1. Recursively simplify the subformula first (crucial first step)
  subformula_ = subformula_->simplify();

  // 2. Handle [r]True ≡ True
  if (subformula_->getType() == FTrue) {
    return True::create();
  }

  // 3. Handle [r]False ≡ False
  if (subformula_->getType() == FFalse) {
    return False::create();
  }

  // --- START S5 REDUCTION LOGIC ---

  // Rule A: [r][r]φ ≡ [r]φ (Box-Box Idempotence)
  if (subformula_->getType() == FBox) {
    auto innerB = dynamic_pointer_cast<Box>(subformula_);
    
    if (innerB->getModality() == modality_) {
      power_ += innerB->getPower();
      subformula_ = innerB->getSubformula();
    }
  }

  // Rule C [r]^n φ ≡ [r]φ for n > 1
  if (power_ > 1) {
    power_ = 1;
  }
  
  // Rule B: [r]<r>φ ≡ <r>φ (Box-Diamond Interaction)
  if (subformula_->getType() == FDiamond) {
    auto innerD = dynamic_pointer_cast<Diamond>(subformula_);
    if (innerD && innerD->getModality() == modality_) {
      // Return the inner Diamond
      return innerD; 
    }
  }
  // --- END REDUCTION LOGIC ---
  
  return shared_from_this();
}


shared_ptr<Formula> Box::S5NormalForm() {
  // 1. Compute S5 normal form of the inner formula without mutating this
  shared_ptr<Formula> innerNF = subformula_->S5NormalForm();

  // --------------------------------------------------
  // 2. Distribution: [r](A & B) ≡ [r]A & [r]B
  // --------------------------------------------------
  if (innerNF->getType() == FAnd) {
    auto innerAnd = dynamic_pointer_cast<And>(innerNF);
    const formula_set *subs = innerAnd->getSubformulasReference();

    formula_set newAndSet;
    for (const shared_ptr<Formula> &component : *subs) {
      // Build [r]component (NO extra S5NormalForm here)
      shared_ptr<Formula> newBox = Box::create(modality_, power_, component);
      newAndSet.insert(newBox);
    }
    return And::create(newAndSet);
  }

  // --------------------------------------------------
  // 3. Rule (5): [r](ψ₁ ∨ … ∨ ψₘ ∨ ⊙φ₁ ∨ … ∨ ⊙φₙ) ⇒ [r](ψ₁ ∨ … ∨ ψₘ) ∨ ⊙φ₁ ∨ … ∨ ⊙φₙ
  //    where ⊙ ∈ {Box, Diamond} with same modality.
  // --------------------------------------------------
  if (innerNF->getType() == FOr) {
    auto innerOr = dynamic_pointer_cast<Or>(innerNF);
    const formula_set *subs = innerOr->getSubformulasReference();

    formula_set propositionalPart;
    formula_set modalPart;
    bool hasMatchingModal = false;

    for (const shared_ptr<Formula> &d : *subs) {
      FormulaType t = d->getType();
      bool captured = false;

      if (t == FBox) {
        auto b = dynamic_pointer_cast<Box>(d);
        if (b && b->getModality() == modality_) {
          modalPart.insert(d);
          hasMatchingModal = true;
          captured = true;
        }
      } else if (t == FDiamond) {
        auto di = dynamic_pointer_cast<Diamond>(d);
        if (di && di->getModality() == modality_) {
          modalPart.insert(d);
          hasMatchingModal = true;
          captured = true;
        }
      }

      if (!captured) {
        propositionalPart.insert(d);
      }
    }

    if (hasMatchingModal) {
      formula_set topOr;

      // Build [r](ψ-part) if any ψ’s exist
      if (!propositionalPart.empty()) {
        shared_ptr<Formula> innerPsi;
        if (propositionalPart.size() == 1) {
          innerPsi = *propositionalPart.begin();
        } else {
          innerPsi = Or::create(propositionalPart);
        }
        shared_ptr<Formula> boxedPsi =
            Box::create(modality_, power_, innerPsi);
        topOr.insert(boxedPsi);
      }

      // Add all ⊙φᵢ
      for (const shared_ptr<Formula> &m : modalPart) {
        topOr.insert(m);
      }

      if (topOr.size() == 1) {
        return *topOr.begin();
      }
      return Or::create(topOr);
    }
  }

  // No extra S5-specific transformation applicable
  return Box::create(modality_, power_, innerNF);
}



shared_ptr<Formula> Box::modalFlatten() {
  subformula_ = subformula_->modalFlatten();
  if (subformula_->getType() == FBox) {
    Box *b = dynamic_cast<Box *>(subformula_.get());
    if (b->getModality() == modality_) {
      power_ += b->getPower();
      subformula_ = b->getSubformula();
    }
  }
  return shared_from_this();
}

shared_ptr<Formula> Box::axiomSimplify(int axiom, int depth) { 
    subformula_ = subformula_->axiomSimplify(axiom, depth+power_);
    if (depth > 0)
        power_ = 1;
    else
        power_ = min(power_, 2);
    return shared_from_this(); 
}

shared_ptr<Formula> Box::create(int modality, int power,
                                const shared_ptr<Formula> &subformula) {
  if (power == 0) {
    return subformula;
  }
  return shared_ptr<Formula>(new Box(modality, power, subformula));
}

shared_ptr<Formula> Box::create(vector<int> modality,
                                const shared_ptr<Formula> &subformula) {
  if (modality.size() == 0) {
    return subformula;
  }
  shared_ptr<Formula> formula =
      Box::create(modality[modality.size() - 1], 1, subformula);
  for (size_t i = modality.size() - 1; i > 0; i--) {
    formula = Box::create(modality[i - 1], 1, formula);
  }
  return formula;
}

shared_ptr<Formula> Box::constructBoxReduced() const {
  return Box::create(modality_, power_ - 1, subformula_);
}

shared_ptr<Formula> Box::clone() const {
  return create(modality_, power_, subformula_->clone());
}

bool Box::operator==(const Formula &other) const {
  if (other.getType() != getType()) {
    return false;
  }
  const Box *otherBox = dynamic_cast<const Box *>(&other);
  return modality_ == otherBox->modality_ && power_ == otherBox->power_ &&
         *subformula_ == *(otherBox->subformula_);
}

bool Box::operator!=(const Formula &other) const {
  return !(operator==(other));
}

size_t Box::hash() const {
  return boxHash_;
}
