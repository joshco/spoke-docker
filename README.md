# Spoke Docker for development

`Josh Cohen` @joshco

This is a quick and dirty docker container for [MoveOn's spoke application](https://github.com/MoveOnOrg/Spoke)

It will automatically set up postgres, sshd, samba, tmux, vim and zile (emacs-mini).

When you launch the container, you'll have a running, browsable spoke server.  You can mount the source directly via SAMBA/Windows File Sharing.

## Instructions

1. Set up docker or docker-machine
2. Learn your docker IP address (local machine if docker is local)
2. `cp .env-docker .env`
3. Customize your env according to MoveOn instructions, using your docker host IP
4. run `./build-docker`
5. run `./launch-docker`
6. Mount the container's source directory back to your local machine for local editing
> Eg, in windows map `\\<dockerIP>\spoke` to S:

## Browsing

Point your favorite browser at `http://<dockerIP>:3400/`

> The container may take some time to start up, and for node to prepare itself.  So if you connect too early, you may see proxy errors.

## Connect via SSH

`ssh -p 222 node@<dockerIP>`

## Connect via Postgres PGadmin

connect to host `<dockerIP>` on port `55432`

## Data Persistence

When launching the container, two docker persistent volumes will be used.
1. spoke-src - Contains the entire Spoke directory (not just the src)
2. spoke-data - Contains Postgres data files

This allows your source and data to persist in between container starts and stops.  
If you want to start completely fresh, you can delete these containers.  When you next start the container, you'll have what the image was build with.  That's the github clone commit version, and postgres will be setup but without data.

## Notes

The container user account is `node` and the password is `node`



