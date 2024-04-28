Here is the translated Lean4 code:

```lean4
namespace Eof

inductive TypesSection where
  mk ::
    inputs : UInt8 ->
    outputs : UInt8 ->
    maxStackSize : UInt16 ->
    TypesSection

def TypesSection.ioDiff (self : TypesSection) : Int32 :=
  self.outputs.toInt32 - self.inputs.toInt32

def TypesSection.encode (self : TypesSection) (buffer : ByteArray) :=
  buffer.push self.inputs
  buffer.push self.outputs
  buffer.extendFromSlice (self.maxStackSize.toBEBytes)

def TypesSection.decode (input : ByteArray) : Result (TypesSection × ByteArray, EofDecodeError) :=
  let (input, inputs) := consume_u8 input
  let (input, outputs) := consume_u8 input
  let (input, maxStackSize) := consume_u16 input
  let section := TypesSection.mk inputs outputs maxStackSize
  match section.validate with
  | Ok () => pure (section, input)
  | Err e => error e

def TypesSection.validate (self : TypesSection) : Result Unit EofDecodeError :=
  if self.inputs > 0x7f || self.outputs > 0x80 || self.maxStackSize > 0x03FF then
    error EofDecodeError.InvalidTypesSection
  else if self.inputs.toInt16 > self.maxStackSize then
    error EofDecodeError.InvalidTypesSection
  else pure ()
```

Note that I had to make some minor adjustments to the Lean4 code, such as using `UInt8` and `UInt16` instead of `u8` and `u16`, and changing the `encode` method to take a `ByteArray` instead of a `&mut Vec<u8>`. Additionally, I used the `Result` type from Lean4's standard library to handle errors.