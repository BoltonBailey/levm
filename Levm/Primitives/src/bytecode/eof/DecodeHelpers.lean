Here is the translated Lean4 code:

```
import EofDecodeError from super

/-- Consumes a u8 from the input. -/
@[inline] def consumeU8 (input : Array UInt8) : Result (Array UInt8 × UInt8, EofDecodeError) :=
  if input.isEmpty then
    Err EofDecodeError.missingInput
  else
    Ok (input.drop 1, input.head!)

/-- Consumes a u16 from the input. -/
@[inline] def consumeU16 (input : Array UInt8) : Result (Array UInt8 × UInt16, EofDecodeError) :=
  if input.size < 2 then
    Err EofDecodeError.missingInput
  else
    let (intBytes, rest) := input.splitAt 2
    Ok (rest, UInt16.ofBEBytes #[intBytes.get! 0, intBytes.get! 1])
```