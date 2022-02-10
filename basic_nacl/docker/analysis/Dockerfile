# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA

COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "docker_westpa_nacl", "/bin/bash", "-c"]
RUN conda install -c conda-forge jupyterlab

WORKDIR /nacl

EXPOSE 8888
# CMD conda run -n docker_westpa jupyter lab --allow-root --ip=* --port=8888 --no-browser --notebook-dir=/odld/analysis
CMD ["conda", "run", "-n", "docker_westpa_nacl", "--no-capture-output", "jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/nacl", "--allow-root" ]