[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 50
  ny = 50
[]

[Variables]
  [./p]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./diffusion]
    type = Diffusion
    variable = p
    D = 'k_over_mu'
  [../]
  [./source]
    type = FunctionKernel
    variable = p
    function = injection_rate
  [../]
[]

[Materials]
  [./diffusion_coefficient]
    type = GenericConstantMaterial
    prop_names = 'k_over_mu'
    prop_values = 1e-12
  [../]
[]

[BCs]
  [./injection_pressure]
    type = DirichletBC
    variable = p
    boundary = left
    value = 1.0e6
  [../]
  [./production_pressure]
    type = DirichletBC
    variable = p
    boundary = right
    value = 1.0e5
  [../]
[]

[Functions]
  [./injection_rate]
    type = ParsedFunction
    value = '1e-6'
  [../]
[]

[Executioner]
  type = Transient
  scheme = bdf2
  dt = 0.1
  end_time = 10.0
[]

[Outputs]
  exodus = true
  file_base = 'pressure_diffusion'
[]