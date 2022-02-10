# WESTPA-Docker proof of concept

I'm interested in whether I can store an entire simulation as a Docker image, to make a fully self-contained runnable WESTPA simulation.

As a very first proof of concept, I want to package just a simple overdamped Langevin dynamics propagator I wrote.

## Building the image

```
cd docker_westpa
docker build .
```

## Running the simulation 


## Notes

- Conda appeared to hang on installing the environment when building the image. 

    -  Attempting to fix this by increasing RAM available to Docker, per [this issue on conda's Github.](https://github.com/conda/conda/issues/8051#issuecomment-890493039) 