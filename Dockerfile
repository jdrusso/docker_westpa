# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA


# Install MD engine 
#   (None for this example, I wrote a custom propagator)


# Make a copy of the odld folder

RUN conda install -c conda-forge "westpa==2.0dev1"
