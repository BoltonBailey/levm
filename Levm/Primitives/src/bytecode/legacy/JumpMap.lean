Here is the translated code snippet from Rust to Lean4:
```
import Hex
import BitVec
import Debug

/-- A map of valid `jump` destinations. -/
structure JumpTable where
  table : Arc (BitVec UInt8)

instance : Clone JumpTable where
  clone x := { table := clone x.table }

instance : Default JumpTable where
  default := { table := default }

instance : PartialEq JumpTable where
  [Self] (a b : JumpTable) → a = b ↔ a.table = b.table

instance : Eq JumpTable where
  [Self] (a : JumpTable) → a == a

instance : Hashable JumpTable where
  hash x := hash x.table

instance : Debug JumpTable where
  debug x := 
    let hex_encoded := Hex.encode x.table.toRawSlice in
    debug_struct "JumpTable" ["map" ↦ hex_encoded]

/-- Get the raw bytes of the jump map -/
def JumpTable.asList (self : JumpTable) : Array UInt8 :=
  self.table.toRawSlice

/-- Construct a jump map from raw bytes -/
def JumpTable.fromList (slice : Array UInt8) : JumpTable :=
  { table := Arc.new (BitVec.fromList slice) }

/-- Check if `pc` is a valid jump destination. -/
def JumpTable.isValid (self : JumpTable) (pc : Nat) : Bool :=
  pc < self.table.length ∧ self.table.get? pc.toUInt8
```