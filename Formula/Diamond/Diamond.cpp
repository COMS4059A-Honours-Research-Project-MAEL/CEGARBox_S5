#include "Diamond.h"

Diamond::Diamond(int modality, int power, shared_ptr<Formula> subformula) {
  modality_ = modality;
  power_ = power;

  Diamond *diamondFormula = dynamic_cast<Diamond *>(subformula.get());
  if (diamondFormula) {
    if (diamondFormula->getModality() == modality_) {
      power_ += diamondFormula->getPower();
      subformula_ = diamondFormula->getSubformula();
    } else {
      subformula_ = subformula;
    }
  } else {
    subformula_ = subformula;
  }
  std::hash<FormulaType> ftype_hash;
  std::hash<int> int_hash;
  size_t totalHash = ftype_hash(getType());
  diaHash_ = totalHash + int_hash(modality_) + int_hash(power_) +
         subformula_->hash();
}

Diamond::~Diamond() {
#if DEBUG_DESTRUCT
  cout << "DESTRUCTING DIAMOND" << endl;
#endif
}

int Diamond::getModality() const { return modality_; }

int Diamond::getPower() const { return power_; }

shared_ptr<Formula> Diamond::getSubformula() const { return subformula_; }

void Diamond::incrementPower() { power_++; }

string Diamond::toString() const {
    string ret = "";
    for (int i = 0; i < power_; ++i) ret += "<r" + to_string(modality_) + ">";
    return ret + subformula_->toString();
}

FormulaType Diamond::getType() const { return FDiamond; }

shared_ptr<Formula> Diamond::negatedNormalForm() {
  subformula_ = subformula_->negatedNormalForm();
  return shared_from_this();
}

shared_ptr<Formula> Diamond::tailNormalForm() {
    assert (1 == 0);
}
shared_ptr<Formula> Diamond::negate() {
  return Box::create(modality_, power_, subformula_->negate());
}

shared_ptr<Formula> Diamond::simplify() {
  // 1. Recursively simplify the subformula first
  subformula_ = subformula_->simplify();

  // 2. Handle <r>False ≡ False
  if (subformula_->getType() == FFalse) {
    return False::create();
  }

  // 3. Handle <r>True ≡ True
  if (subformula_->getType() == FTrue) {
    return True::create();
  }

  // --- START S5 REDUCTION LOGIC ---

  // // Rule A: <r><r>φ ≡ <r>φ (Diamond-Diamond Idempotence)
  if (subformula_->getType() == FDiamond) {
    auto innerD = dynamic_pointer_cast<Diamond>(subformula_);

    if (innerD && innerD->getModality() == modality_) {
      power_ += innerD->getPower();
      subformula_ = innerD->getSubformula();
    }
  }

  // Rule C: <r>^n φ ≡ <r>φ for n > 1
  if (power_ > 1) {
    power_ = 1;
  }

  // Rule B: <r>[r]φ ≡ [r]φ (Diamond-Box Interaction)
  if (subformula_->getType() == FBox) {
    auto innerB = dynamic_pointer_cast<Box>(subformula_);
    if (innerB && innerB->getModality() == modality_) {
      // Returns the inner Box
      return innerB; 
    }
  }

  return shared_from_this();
}


shared_ptr<Formula> Diamond::S5NormalForm() {
  // 1. Recursively S5-normalise the subformula first
  subformula_ = subformula_->S5NormalForm();

  // --------------------------------------------------
  // 2. Distribution: <r>(A ∨ B) ≡ <r>A ∨ <r>B
  // --------------------------------------------------
  if (subformula_->getType() == FOr) {
    auto innerOr = dynamic_pointer_cast<Or>(subformula_);

    formula_set newOrSet;
    const formula_set *subformulas = innerOr->getSubformulasReference();

    for (const shared_ptr<Formula> &component : *subformulas) {
      shared_ptr<Formula> newDiamond =
          Diamond::create(modality_, power_, component)->S5NormalForm();
      newOrSet.insert(newDiamond);
    }

    return Or::create(newOrSet);
  }

  // --------------------------------------------------
  // Rule (6): <r>(ψ₁ ∧ … ∧ ψₘ ∧ ⊙φ₁ ∧ … ∧ ⊙φₙ) => <r>(ψ₁ ∧ … ∧ ψₘ) ∧ ⊙φ₁ ∧ … ∧ ⊙φₙ
  // where ⊙ ∈ {Box, Diamond} and has the same modality as this Diamond.
  // --------------------------------------------------
  if (subformula_->getType() == FAnd) {
    auto innerAnd = dynamic_pointer_cast<And>(subformula_);
    const formula_set *subformulas = innerAnd->getSubformulasReference();

    formula_set propositionalPart;  // the ψ_i
    formula_set modalPart;          // the ⊙φ_i (Box or Diamond with same modality)
    bool hasMatchingModal = false;

    for (const shared_ptr<Formula> &conjunct : *subformulas) {
      FormulaType t = conjunct->getType();

      bool capturedAsModal = false;

      if (t == FBox) {
        auto b = dynamic_pointer_cast<Box>(conjunct);
        if (b && b->getModality() == modality_) {
          modalPart.insert(conjunct);
          hasMatchingModal = true;
          capturedAsModal = true;
        }
      } else if (t == FDiamond) {
        auto d = dynamic_pointer_cast<Diamond>(conjunct);
        if (d && d->getModality() == modality_) {
          modalPart.insert(conjunct);
          hasMatchingModal = true;
          capturedAsModal = true;
        }
      }

      // Anything not treated as a same-modality modal conjunctunct stays under the diamond
      if (!capturedAsModal) {
        propositionalPart.insert(conjunct);
      }
    }

    if (hasMatchingModal) {
      formula_set topAnd;

      // Build <r>(ψ₁ ∧ … ∧ ψₘ) if there is any propositional part
      if (!propositionalPart.empty()) {
        shared_ptr<Formula> inner;
        if (propositionalPart.size() == 1) {
          inner = *propositionalPart.begin();
        } else {
          inner = And::create(propositionalPart);
        }

        shared_ptr<Formula> diaPsi =
            Diamond::create(modality_, power_, inner)->S5NormalForm();
        topAnd.insert(diaPsi);
      }

      // Add all ⊙φᵢ outside
      for (const shared_ptr<Formula> &m : modalPart) {
        topAnd.insert(m);
      }

      if (topAnd.size() == 1) {
        return *topAnd.begin();
      }
      return And::create(topAnd);
    }
  }

  // No extra S5-specific transformation applicable
  return shared_from_this();
}


shared_ptr<Formula> Diamond::modalFlatten() {
  subformula_ = subformula_->modalFlatten();
  if (subformula_->getType() == FDiamond) {
    Diamond *d = dynamic_cast<Diamond *>(subformula_.get());
    if (d->getModality() == modality_) {
      power_ += d->getPower();
      subformula_ = d->getSubformula();
    }
  }
  return shared_from_this();
}


shared_ptr<Formula> Diamond::axiomSimplify(int axiom, int depth) { 
    if (axiom == 2 && depth >= 1) {
        if (subformula_->getType() == FBox) {
            Box *b = dynamic_cast<Box *>(subformula_.get());
            return b->getSubformula()->axiomSimplify(axiom, depth);
        }
        return shared_from_this();
    } else {
        subformula_ = subformula_->axiomSimplify(axiom, depth+power_);
        if (depth > 0)
            power_ = 1;
        else
            power_ = min(power_, 2);
        return shared_from_this(); 
    }
}

shared_ptr<Formula> Diamond::create(int modality, int power,
                                    shared_ptr<Formula> subformula) {
  if (power == 0) {
    return subformula;
  }
  return shared_ptr<Formula>(new Diamond(modality, power, subformula));
}

shared_ptr<Formula> Diamond::create(vector<int> modality,
                                    const shared_ptr<Formula> &subformula) {
  if (modality.size() == 0) {
    return subformula;
  }
  shared_ptr<Formula> formula =
      Diamond::create(modality[modality.size() - 1], 1, subformula);
  for (size_t i = modality.size() - 1; i > 0; i--) {
    formula = Diamond::create(modality[i - 1], 1, formula);
  }
  return formula;
}

shared_ptr<Formula> Diamond::constructDiamondReduced() const {
  return Diamond::create(modality_, power_ - 1, subformula_);
}

shared_ptr<Formula> Diamond::clone() const {
  return create(modality_, power_, subformula_->clone());
}

bool Diamond::operator==(const Formula &other) const {
  if (other.getType() != getType()) {
    return false;
  }
  const Diamond *otherDiamond = dynamic_cast<const Diamond *>(&other);
  return modality_ == otherDiamond->modality_ &&
         power_ == otherDiamond->power_ &&
         *subformula_ == *(otherDiamond->subformula_);
}

bool Diamond::operator!=(const Formula &other) const {
  return !(operator==(other));
}

size_t Diamond::hash() const {
  return diaHash_;
}
