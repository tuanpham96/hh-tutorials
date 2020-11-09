# HH simulation using neuron via python 

## Descriptions 

- HH `mod` files copied from [modeldb-link](https://senselab.med.yale.edu/modeldb/ShowModel?model=3434&file=/cdlab/#tabs-1). Note: look at [ModelDB](https://senselab.med.yale.edu/modeldb/) for neuron simulation database, as well as essential `mod` files for `neuron`
- Some parameters taken from [pdf-link](https://www.math.mcgill.ca/gantumur/docs/reps/RyanSicilianoHH.pdf) page 23
- Parts are taken from [neuron-tutorial](https://neuron.yale.edu/neuron/docs/scripting-neuron-basics)
- For installation and further instructions/tutorials, please follow [neuron-yale](https://neuron.yale.edu/neuron/). Additionally, it's prefered to install in an virtual environment (like using `conda`). If you have trouble, email me. 
- Remember to compile the `mod` files before importing `neuron` into notebook, use `nrnivmodl` for `linux`. For other OSes, please refer to [neuron-faq](https://neuron.yale.edu/neuron/faq)