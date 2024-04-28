import Mathlib

inductive Bytecode where
| LegacyRaw (bytes : ByteArray)
| LegacyAnalyzed (analyzed : LegacyAnalyzedBytecode)
| Eof (eof : Eof)

#check Bytecode.LegacyRaw

def main : IO Unit := do
  let x := 5
  let y := do
    let x := 3
    return x + 1
  IO.println s!"The value of y is: {y}";
  pure ()
