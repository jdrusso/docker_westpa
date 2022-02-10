# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA

# RUN conda install -c conda-forge "westpa==2.0dev1"
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "docker_westpa", "/bin/bash", "-c"]
RUN conda install -c conda-forge jupyterlab

COPY analysis/analysis.ipynb analysis/analysis.ipynb
WORKDIR analysis

EXPOSE 8888
CMD conda run -n docker_westpa jupyter lab --allow-root --ip=* --port=8888 --no-browser --notebook-dir=/odld
