```
namespace KZG

module EnvSettings
module TrustedSetupPoints

/-- Import -/
import CKzg.KzgSettings

/-- Public imports -/
public import EnvSettings.EnvKzgSettings
public import TrustedSetupPoints (
  parse_kzg_trusted_setup,
  G1Points, G2Points, KzgErrors,
  BYTES_PER_G1_POINT, BYTES_PER_G2_POINT,
  G1_POINTS, G2_POINTS, NUM_G1_POINTS, NUM_G2_POINTS
)
```