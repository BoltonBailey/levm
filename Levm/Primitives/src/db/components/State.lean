Here is the translated Lean4 code:

```
namespace StateDatabaseComponent

inductive Error [α] : Type
inductive AccountInfo : Type
inductive Address : Type
inductive Bytecode : Type
inductive B256 : Type
inductive U256 : Type

class State (α : Type) where
  /-- Get basic account information. -/
  basic : α → Address → IO (Result (Option AccountInfo) Error)
  
  /-- Get account code by its hash -/
  code_by_hash : α → B256 → IO (Result Bytecode Error)
  
  /-- Get storage value of address at index. -/
  storage : α → Address → U256 → IO (Result U256 Error)

class StateRef (α : Type) where
  /-- Get basic account information. -/
  basic : α → Address → IO (Result (Option AccountInfo) Error)
  
  /-- Get account code by its hash -/
  code_by_hash : α → B256 → IO (Result Bytecode Error)
  
  /-- Get storage value of address at index. -/
  storage : α → Address → U256 → IO (Result U256 Error)

instance [StateRef α] State (ref : α) where
  Error := α.Error
  basic := fun ref addr => StateRef.basic ref addr
  code_by_hash := fun ref hash => StateRef.code_by_hash ref hash
  storage := fun ref addr idx => StateRef.storage ref addr idx

instance [StateRef α] State (arc : Arc α) where
  Error := α.Error
  basic := fun arc addr => arc.deref.basic addr
  code_by_hash := fun arc hash => arc.deref.code_by_hash hash
  storage := fun arc addr idx => arc.deref.storage addr idx
```