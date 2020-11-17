# HH simulation using neuron via python

## Descriptions

- HH `mod` files copied from [modeldb-link](https://senselab.med.yale.edu/modeldb/ShowModel?model=3434&file=/cdlab/#tabs-1). Note: look at [ModelDB](https://senselab.med.yale.edu/modeldb/) for neuron simulation database, as well as essential `mod` files for `neuron`
- Some parameters taken from [pdf-link](https://www.math.mcgill.ca/gantumur/docs/reps/RyanSicilianoHH.pdf) page 23
- Parts are taken from [neuron-tutorial](https://neuron.yale.edu/neuron/docs/scripting-neuron-basics)
- For installation and further instructions/tutorials, please follow [neuron-yale](https://neuron.yale.edu/neuron/). Additionally, it's prefered to install in an virtual environment (like using `conda`). If you have trouble, email me.
- By the way, you can easily use `google-colab` to run `neuron` with quite a simple installation line `!pip3 install neuron` in a `colab` notebook. This would remove the OSes specific hassle and dependencies. However, as far as I know, the `gui` would not be loaded (like using `from neuron import gui`), possibly because `colab` doesn't come with a GUI - one remedy might be to use `VNC` or something like that.
- Remember to compile the `mod` files before importing `neuron` into notebook, use `nrnivmodl` for `linux`. For other OSes, please refer to [neuron-faq](https://neuron.yale.edu/neuron/faq)
