import Lake
open Lake DSL

package «levm» {
  -- add any package configuration options here
}

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «Levm» {
  -- add any library configuration options here
}
