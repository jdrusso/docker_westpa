# TODO: Just launch the NaCl_Tut notebook

# Pull a linux image with anconda
FROM continuumio/miniconda3

# Install WESTPA
COPY docker/jupyter_run/environment.yml .
# RUN conda env update --name docker_westpa_nacl --file environment.yml
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "--no-capture-output", "-n", "docker_westpa_nacl", "/bin/bash", "-c"]
# RUN conda install -c conda-forge jupyterlab

# Get the most bleeding-edge WESTPA from Jeremy's channel
# This is necessary for some compatibility patches between start-states and the HDF5 framework (I think)
# RUN conda install -c jeremyleung521 -c conda-forge westpa='1!1.99dev1' jupyterlab

COPY nacl_system nacl
WORKDIR /nacl

EXPOSE 8888
# CMD conda run -n docker_westpa jupyter lab --allow-root --ip=* --port=8888 --no-browser --notebook-dir=/odld/analysis
CMD ["conda", "run", "-n", "docker_westpa_nacl", "--no-capture-output", "jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/nacl", "--allow-root" ]