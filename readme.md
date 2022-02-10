# WESTPA-Docker proof of concept

I'm interested in whether I can store an entire simulation as a Docker image, to make a fully self-contained runnable WESTPA simulation.

# `odld_doublewell`

As a very first proof of concept, I want to package just a simple overdamped Langevin dynamics propagator I wrote.
The potential is just a simple 1D double-well.

## With `docker-compose`

Build the images:
```
docker-compose build
```

Launch the containers / run the simulation"
```
docker-compose up w_init w_run
```

(NB: Something is not quite right about enforcing the order of w_init first, and then w_run. 
I could fold them into one container, but I liked having w_run as its own thing you can easily re-run if it chokes and crashes.
You could of course just manually issue `w_run` to the container, but it seemed more elegant to just be able to rerun the container.)

Start the analysis notebook (completely broken at the moment!)
```
docker-compose up analysis
```

## TODO

What's the appropriate set of containers to run a simulation? Is it a single one? 

Or one for w_init, one for w_run, and one for some analysis stuff? 

Or maybe a container for w_init/w_run, but you connect it to a volume containing the prepared simulation?
- I think this could be a container I import, but I need to prepare the simulation in a container.

I can probably move init.sh and run.sh into the respective subfolders, but I want to keep it as close to a normal WESTPA run structure-wise

I have a lot of duplicated stuff in my dockerfiles I can just put in one base image

How do I properly make init -> run -> analysis sequential when `docker-compose up` is called? Or should I just avoid that command?

Move the analysis into a separate repo

## Notes

- Conda appeared to hang on installing the environment when building the image. 

    -  Attempting to fix this by increasing RAM available to Docker, per [this issue on conda's Github.](https://github.com/conda/conda/issues/8051#issuecomment-890493039) 

    - Apparently this can also be caused [by having conda-forge in your channels](https://github.com/ageron/handson-ml2/issues/24#issuecomment-524052579). Trying to remove that.

        - This was the culprit. The solution was removing the `defaults` channel and explicitly providing both `conda-forge` and `conda-forge/label/dev`