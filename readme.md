# WESTPA-Docker proof of concept

I'm interested in whether I can store an entire simulation as a Docker image, to make a fully self-contained runnable WESTPA simulation.

As a very first proof of concept, I want to package just a simple overdamped Langevin dynamics propagator I wrote.

# Manually with Docker
## Building the image

```
cd docker_westpa
docker build -f Dockerfile.init     . -t westpa_odld_init
docker build -f Dockerfile.run      . -t westpa_odld_run
docker build -f Dockerfile.analysis . -t westpa_odld_analysis
```

## Running the simulation 

First, create a volume to store persistent data with
```
docker volume create data
```

Then run the simulation attached to the volume with
```
docker run -v data:/odld westpa_odld 
```

(Can you run multiple replicates by running the container on a few different volumes?)

At this point, you can do
```
docker run -v data:/odld westpa_odld ls
```
and see the `west.h5` generated.

## TODO

What's the appropriate set of containers to run a simulation? Is it a single one? 

Or one for w_init, one for w_run, and one for some analysis stuff? 

Or maybe a container for w_init/w_run, but you connect it to a volume containing the prepared simulation?
- I think this could be a container I import, but I need to prepare the simulation in a container.

## Notes

- Conda appeared to hang on installing the environment when building the image. 

    -  Attempting to fix this by increasing RAM available to Docker, per [this issue on conda's Github.](https://github.com/conda/conda/issues/8051#issuecomment-890493039) 

    - Apparently this can also be caused [by having conda-forge in your channels](https://github.com/ageron/handson-ml2/issues/24#issuecomment-524052579). Trying to remove that.

        - This was the culprit. The solution was removing the `defaults` channel and explicitly providing both `conda-forge` and `conda-forge/label/dev`