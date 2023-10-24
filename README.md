# Pseudomonas_AgarPads_fliC

Code used for analyzing the data described in the following publication: [coming soon]

Code developed by:

Julien Luneau
Department of Fundamental Microbiology, University of Lausanne
julien.luneau@unil.ch
&
Simon van Vliet  
Biozentrum, University Basel  
simon.vanvliet@unibas.ch

## Requirements

- create a conda environment using the specified `environment.yml` file
- install Delta 2.0 and add it to your search path following [these instructions](https://delta.readthedocs.io/en/latest/usage/installation.html)

## Contents

### Jupyter Notebooks

Jupyter notebooks are provided to recreate the data analysis, from running the Delta 2.0 pipeline to data analysis and figure generation

To replicate the results follow the following steps:

1. Run the `0_Run_delta_pipeline_Psy` to run Delta 2.0 on a time-lapse experiment
2. Run the `1_postprocess_delta_Psy` to process Delta 2.0 output
3. Run the `2_filter_data_and_plot_Psy` to filter out tracking errors, analyze the data and make figures

### Additional Code

- `delta_postprocess.py`: helper functions to convert Delta lineage object into Panda date frame with lineages separated into separate tracks

### Data Files

The data_files folder contains data frames of the filtered cell lineages.
