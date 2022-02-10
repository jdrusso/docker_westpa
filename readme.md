# WESTPA-Docker proof of concept

I'm interested in whether I can store an entire simulation as a Docker image, to make a fully self-contained runnable WESTPA simulation.

# Doublewell potential, simple ODLD propagator

As a very first proof of concept, I want to package just a simple overdamped Langevin dynamics propagator I wrote.
The potential is just a simple 1D double-well.

First, 
```
cd odld_doublewell
```

## Running the simulation

Build the images:

    docker-compose build


There *should* be a way to do the whole flow in one command here. However, I'm having some issues with getting them sequential, and I'm not convinced
a bunch of sequential containers is how this command is intended to be used. It seems to pretty much work if you do both `w_init w_run`, but maybe luck.

Initialize the system:

    docker-compose up w_init

Run the simulations:

    docker-compose up w_run


(NB: Something is not quite right about enforcing the order of w_init first, and then w_run, if you try to combine these two. 
This will look like w_run throwing a `Resource temporarily unavailable` error, as `w_init` hasn't finished preparing the sim yet.
I could fold them into one container, but I liked having w_run as its own thing you can easily re-run if it chokes and crashes.
You could of course just manually issue `w_run` to the container, but it seemed more elegant to just be able to rerun the container.)

Start the analysis notebook

    docker-compose up analysis

This will launch a Jupyter notebook in the container. Pay attention to the output -- you can copy the URL it spits out, and replace port 8888 with 1337
to connect to it from a browser on your computer.

### Data persistence

When running this, a directory `/odld` is created within the Docker container, and simulations are run within that.

To enable analysis after the run, a Docker volume is created and mounted at `/odld` when launched. 
A volume provides a persistent store of data that can be mounted in the container, or additionally, mounted on your local filesystem for further analysis.

Between calls to `docker-compose up`, though, the volume will be reused. 
To wipe out the old volume and use a new one, do `docker-compose down -v`.


# Basic Na/Cl association 

## Normal command-line operation

As before, start with 

    cd basic_nacl
    docker-compose build w_init w_run

If you've run this before, to ensure you have a fresh run you may need to wipe out the old volumes with

    docker-compose down -v

Then initialize the system with

    docker-compose up w_init

and launch the simulation with

    docker-compose up w_run

## Running in Jupyter

As a simple demonstration, it's also possible to initialize and run the simulation from within a Jupyter notebook.

To do this, again start with

    cd basic_nacl
    docker-compose build jupyter_run

and then launch the container with

    docker-compose up jupyter_run

As before, look at the output to get the token for the notebook. Navigate to localhost:1336 and enter that token to open the notebook.

From inside the notebook, you should be able to run the first few cells to initialize and run the simulation.

# TODO

- What's the appropriate set of containers to run a simulation? Is it a single one? 

- Or one for w_init, one for w_run, and one for some analysis stuff? 

- Or maybe a container for w_init/w_run, but you connect it to a volume containing the prepared simulation?
    - I think this could be a container I import, but I need to prepare the simulation in a container.

- I can probably move init.sh and run.sh into the respective subfolders, but I want to keep it as close to a normal WESTPA run structure-wise

- I have a lot of duplicated stuff in my dockerfiles I can just put in one base image

- How do I properly make init -> run -> analysis sequential when `docker-compose up` is called? Or should I just avoid that command?

- Move the analysis into a separate repo

# Notes

- Conda appeared to hang on installing the environment when building the image. 

    -  Attempting to fix this by increasing RAM available to Docker, per [this issue on conda's Github.](https://github.com/conda/conda/issues/8051#issuecomment-890493039) 

    - Apparently this can also be caused [by having conda-forge in your channels](https://github.com/ageron/handson-ml2/issues/24#issuecomment-524052579). Trying to remove that.

        - This was the culprit, it was some weird conflict resolution issue combined w/ Conda being a little slow in the container. The solution was removing the `defaults` channel and explicitly providing both `conda-forge` and `conda-forge/label/dev`

- I need to think more carefully about how to manage volumes. I'm pretty sure what I'm doing now is not "the right way".