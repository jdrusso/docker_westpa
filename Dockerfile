# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA

# RUN conda install -c conda-forge "westpa==2.0dev1"
COPY environment.yml .
RUN conda env create -f environment.yml


# Install MD engine 
#   (None for this example, I wrote a custom propagator)


# Make a copy of the odld folder
COPY odld odld_simulation