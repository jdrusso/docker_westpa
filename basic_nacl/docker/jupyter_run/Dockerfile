# TODO: Just launch the NaCl_Tut notebook

# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA

COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "docker_westpa", "/bin/bash", "-c"]
RUN conda install -c conda-forge jupyterlab

WORKDIR /odld

EXPOSE 8888
# CMD conda run -n docker_westpa jupyter lab --allow-root --ip=* --port=8888 --no-browser --notebook-dir=/odld/analysis
CMD ["conda", "run", "-n", "docker_westpa", "--no-capture-output", "jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/odld", "--allow-root" ]