Here is the translated code snippet from Rust to Lean4:

```
namespace EVM

constant MAX_CODE_SIZE : Nat := 0x6_000

constant BLOCK_HASH_HISTORY : Nat := 256

constant MAX_INITCODE_SIZE : Nat := 2 * MAX_CODE_SIZE

constant PRECOMPILE3 : Address := Address.mk #[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]

-- EIP-4844 constants
constant GAS_PER_BLOB : UInt64 := 1 ⇑ 17

constant TARGET_BLOB_NUMBER_PER_BLOCK : UInt64 := 3

constant MAX_BLOB_NUMBER_PER_BLOCK : UInt64 := 2 * TARGET_BLOB_NUMBER_PER_BLOCK

constant MAX_BLOB_GAS_PER_BLOCK : UInt64 := MAX_BLOB_NUMBER_PER_BLOCK * GAS_PER_BLOB

constant TARGET_BLOB_GAS_PER_BLOCK : UInt64 := TARGET_BLOB_NUMBER_PER_BLOCK * GAS_PER_BLOB

constant MIN_BLOB_GASPRICE : UInt64 := 1

constant BLOB_GASPRICE_UPDATE_FRACTION : UInt64 := 33_38_477

constant VERSIONED_HASH_VERSION_KZG : UInt8 := 0x01
```