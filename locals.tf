locals {
  users = [
    "eric.yu@fmg.co.nz",
    "markus.peter@fmg.co.nz",
    "Shumin.Zhou@fmg.co.nz",
    "kyle.burmeister@fmg.co.nz",
    "wiremu.winitana@fmg.co.nz",
    "daniel.sutton-claridge@fmg.co.nz",
    "james.gorman@fmg.co.nz"
  ]
}

locals {
  default_common_tags = {
    workload   = "FMG BIS Legacy Sandbox"
    costCentre = "LegacySandbox"
    deployType = "Terraform"
    source     = "https://github.com/fmgey2/AILearning"
    owner      = "Eric Yu"
  }
  common_tags = merge(local.default_common_tags, var.common_tags)
}