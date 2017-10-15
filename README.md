# Spoke Docker for development

This is a quick and dirty docker container for [MoveOn's spoke application](https://github.com/MoveOnOrg/Spoke)

It will automatically set up postgres, sshd, samba, tmux, vim and zile (emacs-mini).

## Instructions

1. Set up docker or docker-machine
2. Learn your docker IP address (local machine if docker is local)
2. cp .env-docker .env
3. Customize your env according to MoveOn instructions, using your docker host IP
4. run `./build-docker`
5. run `./launch-docker`
6. Mount the container's source directory back to your local machine for local editing
> Eg, in windows map `\\<dockerIP>\spokesrc` to S:

## Browsing

Point your favorite browser at `http://<dockerIP>:3400/`

## Connect via SSH

`ssh -p 222 node@<dockerIP>`

## Connect via Postgres PGadmin

connect to host `<dockerIP>` on port `55432`

## Notes

The container user account is `node` and the password is `node`



