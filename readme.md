# WESTPA-Docker proof of concept

I'm interested in whether I can store an entire simulation as a Docker image, to make a fully self-contained runnable WESTPA simulation.

As a very first proof of concept, I want to package just a simple overdamped Langevin dynamics propagator I wrote.

# With `docker-compose`

```
docker-compose build
```

Run the simulation
```
docker-compose up
```

This will run `w_init`, `w_run`, and launch a Jupyter notebook in the simulation directory.

## TODO

What's the appropriate set of containers to run a simulation? Is it a single one? 

Or one for w_init, one for w_run, and one for some analysis stuff? 

Or maybe a container for w_init/w_run, but you connect it to a volume containing the prepared simulation?
- I think this could be a container I import, but I need to prepare the simulation in a container.

I can probably move init.sh and run.sh into the respective subfolders, but I want to keep it as close to a normal WESTPA run structure-wise

I have a lot of duplicated stuff in my dockerfiles I can just put in one base image

How do I properly make init -> run -> analysis sequential when `docker-compose up` is called? Or should I just avoid that command?

## Notes

- Conda appeared to hang on installing the environment when building the image. 

    -  Attempting to fix this by increasing RAM available to Docker, per [this issue on conda's Github.](https://github.com/conda/conda/issues/8051#issuecomment-890493039) 

    - Apparently this can also be caused [by having conda-forge in your channels](https://github.com/ageron/handson-ml2/issues/24#issuecomment-524052579). Trying to remove that.

        - This was the culprit. The solution was removing the `defaults` channel and explicitly providing both `conda-forge` and `conda-forge/label/dev`