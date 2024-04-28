Here is the translated code snippet from Rust to Lean4:

```
namespace BlockHashDB

/-- BlockHash database component -/
structure BlockHash (α : Type) :=
  (Error : Type)
  /-- Get block hash by block number -/
  (blockHash : α → U256 → Result B256 α)

/-- BlockHashRef trait -/
structure BlockHashRef (α : Type) :=
  (Error : Type)
  /-- Get block hash by block number -/
  (blockHash : α → U256 → Result B256 α)

/-- Implementation of BlockHash for &T -/
instance [BlockHashRef T] : BlockHash (&T) where
  Error := (T : BlockHashRef).Error
  blockHash := fun (_ : &T) (number : U256) =>
    BlockHashRef.blockHash (*_ , number)

/-- Implementation of BlockHash for Arc<T> -/
instance [BlockHashRef T] : BlockHash (Arc T) where
  Error := (T : BlockHashRef).Error
  blockHash := fun (_ : Arc T) (number : U256) =>
    _.deref().blockHash(number)
```