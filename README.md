# DriftDiffusion
Drift Diffusion class for Matlab.
For now, see comments in DD.m for guidance and dualAccs2.m for usage examples.

DD.m
Creates an object that can be used to run and plot a drift diffusion model over a specified number of iterations. 

DDp.m (Not yet implemented fully)
Creates a 'perpetual' DD model that can generate additional iterations as needed. No preallocation, all calculations done on each iteration so slower.

Stimuli can be unidirectional or bidirectional, and can be generated or supplied. 
Model can be simple random autoregressive model, autoregressive with stimuli input, or full Brunton 2013 (http://science.sciencemag.org/content/340/6128/95.full ) including adaptation, and additive and multiplicitive noise (not yet implemented)
Descision boundaries can be non-existent, linear, exponential, confidence based, or defined as a custom function
Two objects can be combined to make a 'multisensory' decision

