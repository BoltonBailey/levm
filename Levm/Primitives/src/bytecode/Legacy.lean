Here is the translated Lean4 code:
```
namespace JumpMap
variable {α} [JumpTable α]

structure LegacyAnalyzedBytecode where
  bytecode : Bytes
  original_len : Nat
  jump_table : JumpTable α

instance : Coe LegacyAnalyzedBytecode → Clone where
  clone x := { bytecode := x.bytecode.clone, original_len := x.original_len, jump_table := x.jump_table.clone }

instance : Debug LegacyAnalyzedBytecode where
  debug x := s!"{{ bytecode = {x.bytecode}, original_len = {x.original_len}, jump_table = {x.jump_table} }}"

instance : PartialEq LegacyAnalyzedBytecode where
  eq x y := x.bytecode = y.bytecode ∧ x.original_len = y.original_len ∧ x.jump_table = y.jump_table

instance : Eq LegacyAnalyzedBytecode where
  eq x y := x.bytecode = y.bytecode ∧ x.original_len = y.original_len ∧ x.jump_table = y.jump_table

instance : Hash LegacyAnalyzedBytecode where
  hash x h := h.combine (hash x.bytecode) (hash x.original_len) (hash x.jump_table)

def LegacyAnalyzedBytecode.default : LegacyAnalyzedBytecode :=
{ bytecode := Bytes.fromStatic #[0],
  original_len := 0,
  jump_table := JumpTable α.mk (Bitvec.bitvec ![u8, Lsb0; 0]) }

def LegacyAnalyzedBytecode.new (bytecode : Bytes) (original_len : Nat) (jump_table : JumpTable α) : LegacyAnalyzedBytecode :=
{ bytecode, original_len, jump_table }

def LegacyAnalyzedBytecode.bytes (self : LegacyAnalyzedBytecode) : Bytes := self.bytecode.clone

def LegacyAnalyzedBytecode.original_len (self : LegacyAnalyzedBytecode) : Nat := self.original_len

def LegacyAnalyzedBytecode.original_bytes (self : LegacyAnalyzedBytecode) : Bytes := self.bytecode.slice ..self.original_len

def LegacyAnalyzedBytecode.original_byte_slice (self : LegacyAnalyzedBytecode) : ByteArray := &self.bytecode[..self.original_len]

def LegacyAnalyzedBytecode.jump_table (self : LegacyAnalyzedBytecode) : JumpTable α := &self.jump_table