import re
import sys
import os

# Reserved words, operators, punctuation
RESERVED = {
    'VAR','BEGIN','END','IF','THEN','ELSE','WHILE','DO','READ','WRITE',
    'BOOLEAN','CHAR','INTEGER','REAL','int','float','string','char','ARRAY','OF',
    'AND','OR','NOT'
}

OPERATORS = { '+','-','*','/','%',':=' }
PUNCTUATION = { '(',')','[',']',';',':',',','<','<=','=','<>','>=','>','.' }

IDENTIFIER_RE = re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')
INT_RE = re.compile(r'^[+-]?[0-9]+$')
FLOAT_RE = re.compile(r'^[+-]?[0-9]+\.[0-9]+$')
CHAR_RE = re.compile(r"^'[^']'$")
STRING_RE = re.compile(r'^"[^"\r\n]*"$')


class SymbolTable:
    def __init__(self, path='ST.txt'):
        self.path = path
        self.table = {}
        self.next_index = 0
        if os.path.exists(path):
            with open(path) as f:
                for line in f:
                    idx, tok = line.strip().split(' ',1)
                    idx = int(idx)
                    self.table[tok] = idx
                    self.next_index = max(self.next_index, idx+1)

    def insert(self, tok):
        if tok in self.table:
            return self.table[tok]
        idx = self.next_index
        self.table[tok] = idx
        self.next_index += 1
        return idx

    def dump(self):
        with open(self.path,'w') as f:
            for tok, idx in sorted(self.table.items(), key=lambda kv: kv[1]):
                f.write(f"{idx} {tok}\n")


def detect_illegal_joins(tokens):
    merged = []
    i = 0
    while i < len(tokens):
        t = tokens[i]

        # number immediately followed by identifier => illegal token
        if INT_RE.match(t) and i+1 < len(tokens) and IDENTIFIER_RE.match(tokens[i+1]):
            merged.append(t + tokens[i+1])
            i += 2
        else:
            merged.append(t)
            i += 1
    return merged


def tokenize_line(line):
    line = re.split(r'//', line)[0]

    token_re = re.compile(
        r'("[^"]*"|\'[^\']\'|:=|<=|>=|<>|[A-Za-z_][A-Za-z0-9_]*|\d+\.\d+|\d+|.)'
    )

    return [t for t in token_re.findall(line) if t.strip() != '']


def main(program='program.txt', pif='PIF.out', stfile='ST.txt', errors='errors.txt'):
    st = SymbolTable(stfile)
    pif_lines = []
    errs = []

    with open(program) as f:
        for lineno, line in enumerate(f, start=1):
            # Step 1: naive tokenization
            tokens = tokenize_line(line)

            # Step 2: detect illegal number+identifier merges
            tokens = detect_illegal_joins(tokens)

            # Step 3: classify tokens
            for t in tokens:
                if t in RESERVED or t in OPERATORS or t in PUNCTUATION:
                    pif_lines.append((t, -1))
                elif STRING_RE.match(t) or CHAR_RE.match(t) or FLOAT_RE.match(t) or INT_RE.match(t):
                    idx = st.insert(t)
                    pif_lines.append((t, idx))
                elif IDENTIFIER_RE.match(t):
                    idx = st.insert(t)
                    pif_lines.append((t, idx))
                else:
                    errs.append(f"Lexical error line {lineno}: {t}")

    # Write PIF
    with open(pif, 'w') as f:
        for tok, idx in pif_lines:
            f.write(f"{tok} {idx}\n")

    # Write symbol table
    st.dump()

    # Write errors
    with open(errors,'w') as f:
        for e in errs:
            f.write(e + '\n')

    print(f"[LEXER] wrote {pif}, symbol table {stfile}, errors {errors}")


if __name__=='__main__':
    program = sys.argv[1] if len(sys.argv) > 1 else 'program.txt'
    main(program)
