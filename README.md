# CEGARBox_S5

## Overview

**CEGARBox_S5** is a CEGAR-Tablueax based decision procedure for the modal logic S5. It is built upon - and adapted extensively from - the original **CEGARBoxCPP** framework created by Kikkert & McArthur.

CEGARBox_S5 supports:
- Decision procedures for S5 satisfiability and validity  
- Construction of **finite S5 Kripke models**  
- Full S5 normal form rewrites, including modal-distributive reductions  
- A refined S5-aware trie-based clausifier

This tool was developed as part of my **Computer Science Honours Research Project (2025)**.

---

## Authorship

**Original CEGARBoxCPP authors:** Robert McArthur and Cormac Kikkert, for contact email cormac.kikkert@anu.edu.au

**CEGARBox_S5 modifications and extensions:** Ntando O. Raji, for contact email 2584925@students.wits.ac.za

---

## Program

This repository provides one main executable, `CEGARBox_S5`: A solver specialised for S5 modal logic featuring:

- S5-normalisation and modal reductions  
- Optional S5 Kripke model extraction

---

## Compilation

Statically compiled file of CEGARBox_S5 is already available on this repo - compiled on Ubuntu 22.04.5.

However, if you want to recreate our results, you will need to compile CEGARBox_S5 for your machine. To do this, follow the instructions but note that the following will be installed:
- [Minisat](#installing-minisat), a SAT-solver. This is a fork, as the original is outdated and no longer works.
--

## Prerequisites

```bash
sudo apt-get update && sudo apt-get install -y build-essential wget unzip tar cmake sudo libz-dev libgoogle-glog-dev
```

---

## Installing Minisat

```bash
(
git clone https://github.com/agurfinkel/minisat.git && cd minisat && make config prefix=/usr && sudo make install
)
```

---

## Installing CEGARBox_S5

Run `make` to compile CEGARBox_S5.

Test via:

```
cd Examples && ./tests.sh
```

---

# Input Formula (InToHyLo)

CEGARBox_S5 accepts formulas in the **InToHyLo** format, as defined in *Lagniez et al. (2016)*.

## Grammar

```
<fml> ::=  (<fml>)
        | true
        | false
        | p<id>
        | ~(fml)
        | <r<id>><fml>
        | [r<id>]<fml>
        | <fml> & <fml>
        | <fml> | <fml>
        | <fml> -> <fml>
        | <fml> <-> <fml>
```

Where:

- `id` is a numerical sequence: `1`, `2`, `35`, …
- `p1`, `p2`, `p10` are propositional variables  
- `<r1> φ` and `[r1] φ` denote diamond and box modalities  
- Parentheses are used for grouping  
- Negation is written as `~φ`

## File structure

Every input file must follow:

```
begin
    <formula>
end
```

Example:

```
begin
    [r1](p1 | <r1>p2)
end
```

Whitespace and newlines are ignored.

**Note:** CEGARBox_S5 handles mono-modal S5 so multiple modalities (e.g., `r1`, `r2`, …) are not allowed.

---

## Running CEGARBox_S5

```
./main -f <input_file> [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-a`, `--valid` | Check validity instead of satisfiability |
| `-v`, `--verbose` | Verbose diagnostic output |
| `-1`, `--onesat` | Use a single SAT instance |
| `-m`, `--model` | Construct and print an S5 Kripke model |

Examples:

```
./main -f Examples/test1.p
./main -f formula.p --valid
./main -f formula.p --model
```

---

## Features

### Full S5 Normal Form

Includes:
- Idempotence (`[r1][r1]φ ≡ [r1]φ`, `<r1><r1>φ ≡ <r1>φ`)
- Interaction reductions (`[r1]<r1>φ ≡ <r1>φ`, `<r1>[r1]φ ≡ [r1]φ`)
- Distribution:
  - `[r1](A & B) → [r1]A & [r1]B`
  - `<r>(A | B) → <r>A | <r>B`
- Higher-level S5 reductions, where `⊙ ∈ {[r1], <r1>}`:
  - `[r1](ψ ∨ ⊙φ) → [r1](ψ) ∨ ⊙φ`
  - `<r1>(ψ ∧ ⊙φ) → <r1>(ψ) ∧ ⊙φ`

### Kripke Model Construction for S5
- Extracts worlds from tableau nodes  
- Enforces equivalence closure of the accessibility relation  
- Produces small finite models
---

---

## Attribution

This project, **CEGARBox_S5**, is based on the repository  
[**cormackikkert/CEGARBoxCPP**](https://github.com/cormackikkert/CEGARBoxCPP).

Much of the original structure and modal reasoning machinery originates from that work.
