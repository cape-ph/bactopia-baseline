# Development Dependencies for FracturedLIMS Server

Items under this directory are used in the development of this server repo
itself (they do not change the functionality of the repo's contents).

The sections below will describe the files included in this directory. This
`README` will be updated as new items are added or as things change.

## dev-requirements.txt

This file specifies the python packages that would be used to run ansible
commands (for deployment) use ansible vault (for actions like encrypting
values/files to be stored in the ansible inventory), lint ansible files, etc.

The `requirements.txt` file has been tested in a `conda` environment running
`python=3.11`. We expect that this should work in any other python virtual
environment scheme (`venv`, `virtualenv`, etc) with this python version, though
to date we have not attempted that setup. YMMV
