# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA

COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "docker_westpa", "/bin/bash", "-c"]


# Install MD engine 
#   (None for this example, I wrote a custom propagator)


# Make a copy of the odld folder
# COPY odld odld
WORKDIR /odld

CMD [ "bash", "run.sh" ]