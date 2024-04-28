Here is the translated code snippet from Rust to Lean4:

```lean
import core.hash
import Std.Trait.Default
import Std.Trait.Debug
import Std.Trait.Clone
import Std.Trait.Eq

inductive EnvKzgSettings
| Default : EnvKzgSettings
| Custom (settings : Std.Lib.Option (c_kzg.KzgSettings)) : EnvKzgSettings

@[derive dbg, clone, default, eq]
instance : Debug EnvKzgSettings := {}
instance : Clone EnvKzgSettings := {}
instance : Default EnvKzgSettings := {}
instance : Eq EnvKzgSettings := {}

def EnvKzgSettings.eq (self : EnvKzgSettings) (other : EnvKzgSettings) : Bool :=
  match self, other with
  | Default, Default => true
  | Custom a, Custom b => Std.Lib.Option.Ptr.eq a b
  | _, _ => false

instance : Hash EnvKzgSettings := {
  hash := fun ⟨self⟩ ⟨h : Hasher⟩ =>
    core.hash.discriminant self |>.hash h;
    match self with
    | Default => ()
    | Custom settings => Std.Lib.Option.as_ptr settings |>.hash h
}

def EnvKzgSettings.get (self : EnvKzgSettings) : Std.Lib.Option KzgSettings :=
  match self with
  | Default =>
    let default : Std.Lib.Option.OnceBox KzgSettings := Std.Lib.Option.OnceBox.new;
    default.get_or_init fun _ =>
      let settings : KzgSettings :=
        KzgSettings.load_trusted_setup G1_POINTS.as_ref G2_POINTS.as_ref |>.expect "failed to load default trusted setup";
      Std.Lib.Option.some (Std.Lib.Option.Box.box settings)
  | Custom settings => Std.Lib.Option.some settings
```