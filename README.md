# DriftDiffusion

Drift Diffusion decision accumulator class for Matlab.
Models accumulation of uni or bi-directional sensory information and integration across modalities.

## Accumulation models
- **ARGuass** - Auto regressive model
- **Delta1D** - Stimulus in one direction with accumulator noise
- **Delta2D**- Stimulus in two directions with accumulator noise
- **BB1D** - Basic implementation of [Brunton et.al, 2013](http://science.sciencemag.org/content/340/6128/95) Stimulus in one direction with accumulator and sensory noise. No adaptation.
- **BB2D** - Basic implementation of [Brunton et.al, 2013](http://science.sciencemag.org/content/340/6128/95) Stimulus in two directions with accumulator and sensory noise. No adaptation.
- **BruntonFull** - Not implemented yet


## Decision bound models 
- **Static**
- **LinearDecay**
- **ExpDecay**
- **SE**
- **Custom**

## Classes

- **DD.m** - Creates an object that can be used to run and plot a drift diffusion model over a specified number of iterations. 

- **DDp.m** - (Not yet implemented fully)
Creates a 'perpetual' DD model that can generate additional iterations as needed. No preallocation, all calculations done on each iteration so slower.

## Usage

See **dualAcc2.m** for examples.
