# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA

COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "docker_westpa_nacl", "/bin/bash", "-c"]

WORKDIR /nacl

CMD [ "./run.sh" ]