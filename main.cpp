#include <argp.h>
#include <minisat/core/Solver.h>

#include <chrono>
#include <fstream>
#include <functional>
#include <iostream>
#include <memory>
#include <string>
#include <unordered_set>

#include "Bitset/Bitset.h"
#include "Clausifier/Trieform/Trieform.h"
#include "Clausifier/TrieformFactory/TrieformFactory.h"
#include "Formula/And/And.h"
#include "Formula/Atom/Atom.h"
#include "Formula/Box/Box.h"
#include "Formula/Diamond/Diamond.h"
#include "Formula/FEnum/FEnum.h"
#include "Formula/False/False.h"
#include "Formula/Formula/Formula.h"
#include "Formula/Not/Not.h"
#include "Formula/Or/Or.h"
#include "Formula/True/True.h"
#include "ParseFormula/Parser.h"
#include "Prover/TrieformProver/TrieformProverS5/TrieformProverS5.h"

using namespace std;

const char *argp_program_version = "CEGARBox S5 0.1.0";
const char *argp_program_bug_address = "2584925@students.wits.ac.za";
static char doc[] = "An efficient theorem prover for the S5 modal logic based on CEGARBox.";
static char args_doc[] = "";
static struct argp_option options[] = {
    {"file", 'f', "FILE", 0, "File containing input formula."},
    {"valid", 'a', 0, 0, "Prove validity."},
    {"onesat", '1', 0, 0, "Use 1 SAT Solver."},
    {"verbose", 'v', 0, 0, "Verbosity."},
    {0, 0, 0, 0, 0, 0}
};

struct arguments_struct {
    string filename = "file.p";
    SolverConstraints settings;
    bool valid = false;
    bool verbose = false;
};

static error_t parse_opt(int key, char *arg, struct argp_state *state) {
    arguments_struct *arguments = static_cast<arguments_struct *>(state->input);
    switch (key) {
        case 'f': {
            arguments->filename = arg;
        } break;
        case 'a':
            arguments->valid = true;
            break;
        case 'v':
            arguments->verbose = true;
            break;
        case '1':
            arguments->settings.oneSat = true;
            break;
        case ARGP_KEY_ARG:
            return 0;
        default:
            return ARGP_ERR_UNKNOWN;
    }
    return 0;
}

static struct argp argp = {options, parse_opt, args_doc, doc, 0, 0, 0};

void solve(arguments_struct &args);

int main(int argc, char *argv[]) {
    arguments_struct arguments;

    argp_parse(&argp, argc, argv, 0, 0, &arguments);
    solve(arguments);
}

void solve(arguments_struct &args) {
#if DEBUG_TIME
    auto start = chrono::steady_clock::now();
#endif
    auto start = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Begin" << endl;
    }
    auto read = chrono::steady_clock::now();
#if DEBUG_PROGRESS
    cout << "Begin" << endl;
#endif

#if DEBUG_TIME
    auto read = chrono::steady_clock::now();
#endif

    shared_ptr<Formula> formula = Parser(args.filename).parseFormula();

    if (args.valid) {
        formula = Not::create(formula);
    }

#if DEBUG_TIME
    auto parse = chrono::steady_clock::now();
#endif
#if DEBUG_PROGRESS
    cout << "Parsed: " << formula->toString() << endl;
#endif
    auto parse = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Parsed: " << formula->toString() << endl;
    }

    formula = formula->negatedNormalForm();

#if DEBUG_TIME
    auto nnf = chrono::steady_clock::now();
#endif
#if DEBUG_PROGRESS
    cout << "Negated normal form: " << formula->toString() << endl;
#endif

    auto nnf = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Negated normal form: " << formula->toString() << endl;
    }

    formula = formula->simplify();

#if DEBUG_TIME
    auto simplify = chrono::steady_clock::now();
#endif
#if DEBUG_PROGRESS
    cout << "Simplified: " << formula->toString() << endl;
#endif

    auto simplify = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Simplified: " << formula->toString() << endl;
    }

    formula = formula->modalFlatten();

#if DEBUG_TIME
    auto flatten = chrono::steady_clock::now();
#endif
#if DEBUG_PROGRESS
    cout << "Flattenned: " << formula->toString() << endl;
#endif

    auto flatten = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Flattenned: " << formula->toString() << endl;
    }

    FormulaDetails formulaDetails;
    Trieform::calculateFormulaDetails(formulaDetails, formula);

    shared_ptr<Trieform> trie = TrieformFactory::makeTrie(formula, args.settings);

    if (args.verbose) {
        cout << "Constructed trie" << endl;
        cout << "Initial trie:" << endl << trie->toString() << endl;
        cout << "Normal cache:" << endl << trie->getCache().toString() << endl;
    }
    auto construct = chrono::steady_clock::now();
#if DEBUG_PROGRESS
    cout << "Constructed trie" << endl;
#endif
#if DEBUG_INITIAL_TRIE
    cout << "Initial trie:" << endl << trie->toString() << endl;
#endif
#if DEBUG_NORMAL_CACHE
    cout << "Normal cache:" << endl << trie->getCache().toString() << endl;
#endif
#if DEBUG_TIME
    auto construct = chrono::steady_clock::now();
#endif

#if DEBUG_TIME
    auto reduce = chrono::steady_clock::now();
#endif
#if DEBUG_PROGRESS
    cout << "Reduced trie" << endl;
#endif
#if DEBUG_REDUCED_TRIE
    cout << "Reduced trie:" << endl << trie->toString() << endl;
#endif
#if DEBUG_REDUCED_CACHE
    cout << "Reduced cache:" << endl << trie->getCache().toString() << endl;
#endif

    auto reduce = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Reduced trie" << endl;
        cout << "Reduced trie:" << endl << trie->toString() << endl;
        cout << "Reduced cache:" << endl << trie->getCache().toString() << endl;
    }

    trie->reduceClauses();
    trie->preprocess();

#if DEBUG_PROGRESS
    cout << "Preprocessed trie" << endl;
#endif
#if DEBUG_PROCESSED_TRIE
    cout << "Processed trie:" << endl << trie->toString() << endl;
#endif

    if (args.verbose) {
        cout << "Preprocessed trie" << endl;
        cout << "Processed trie:" << endl << trie->toString() << endl;
    }


    trie->removeTrueAndFalse();

    if (Trieform::stringModalContexts)
        trie->prepareSAT(name_set{"$root"});
    else
        trie->prepareSAT();

#if DEBUG_TIME
    auto prepare = chrono::steady_clock::now();
#endif
#if DEBUG_PROGRESS
    cout << "Prepared SAT" << endl;
#endif

    auto prepare = chrono::steady_clock::now();
    if (args.verbose) {
        cout << "Prepared SAT" << endl;
    }
   
    bool satisfiable = trie->isSatisfiable(Trieform::stringModalContexts);

    if (args.valid) {
        cout << (satisfiable ? "Invalid" : "Valid") << endl;
    } else {
        if (satisfiable) {
            cout << "s SATISFIABLE" << endl;
            dynamic_cast<TrieformProverS5* >(trie.get())->printKripkeModel();
        }
        else {
            cout << "s UNSATISFIABLE" << endl;
        }
    }

#if DEBUG_TIME
    auto solve = chrono::steady_clock::now();
#endif
#if DEBUG_PROGESS
    cout << "Solved" << endl;
#endif

#if DEBUG_TIME
    auto readTime = read - start;
    auto parseTime = parse - start;
    auto nnfTime = nnf - start;
    auto simplifyTime = simplify - start;
    auto flattenTime = flatten - start;
    auto constructTime = construct - start;
    auto reduceTime = reduce - start;
    auto prepareTime = prepare - start;
    auto solveTime = solve - start;
    cout << "READ TIME: " << chrono::duration<double, milli>(readTime).count()
         << " ms" << endl;
    cout << "PARSE TIME: " << chrono::duration<double, milli>(parseTime).count()
         << " ms" << endl;
    cout << "NNF TIME: " << chrono::duration<double, milli>(nnfTime).count()
         << " ms" << endl;
    cout << "SIMPLIFY TIME: "
         << chrono::duration<double, milli>(simplifyTime).count() << " ms"
         << endl;
    cout << "FLATTEN TIME: "
         << chrono::duration<double, milli>(flattenTime).count() << " ms"
         << endl;
    cout << "CONSTRUCT TIME: "
         << chrono::duration<double, milli>(constructTime).count() << " ms"
         << endl;
    cout << "REDUCE TIME: "
         << chrono::duration<double, milli>(reduceTime).count() << " ms"
         << endl;
    cout << "PREPARE TIME: "
         << chrono::duration<double, milli>(prepareTime).count() << " ms"
         << endl;
    cout << "SOLVE TIME: " << chrono::duration<double, milli>(solveTime).count()
         << " ms" << endl;
#endif

    if (args.verbose) {
        auto solve = chrono::steady_clock::now();
        cout << "Solved" << endl;

        auto readTime = read - start;
        auto parseTime = parse - start;
        auto nnfTime = nnf - start;
        auto simplifyTime = simplify - start;
        auto flattenTime = flatten - start;
        auto constructTime = construct - start;
        auto reduceTime = reduce - start;
        auto prepareTime = prepare - start;
        auto solveTime = solve - start;
        cout << "READ TIME: "
             << chrono::duration<double, milli>(readTime).count() << " ms"
             << endl;
        cout << "PARSE TIME: "
             << chrono::duration<double, milli>(parseTime).count() << " ms"
             << endl;
        cout << "NNF TIME: " << chrono::duration<double, milli>(nnfTime).count()
             << " ms" << endl;
        cout << "SIMPLIFY TIME: "
             << chrono::duration<double, milli>(simplifyTime).count() << " ms"
             << endl;
        cout << "FLATTEN TIME: "
             << chrono::duration<double, milli>(flattenTime).count() << " ms"
             << endl;
        cout << "CONSTRUCT TIME: "
             << chrono::duration<double, milli>(constructTime).count() << " ms"
             << endl;
        cout << "REDUCE TIME: "
             << chrono::duration<double, milli>(reduceTime).count() << " ms"
             << endl;
        cout << "PREPARE TIME: "
             << chrono::duration<double, milli>(prepareTime).count() << " ms"
             << endl;
        cout << "SOLVE TIME: "
             << chrono::duration<double, milli>(solveTime).count() << " ms"
             << endl;
    }
}
