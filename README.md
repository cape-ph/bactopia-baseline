# bactopia-baseline

A small vagrant VM to provide a baseline for running and testing the bactopia pipeline.

## Requirements

- [Vagrant](https://www.vagrantup.com/) (with experimental [`disks`](https://developer.hashicorp.com/vagrant/docs/disks/usage) feature enabled)
- 75gb of free storage

## Running

1. Use the following command to start up the vagrant VM from the root of this repository. (_Note:_ The `VAGRANT_EXPERIMENTAL` environment variable must be set to `"disks"` to enable this experimental feature. This is described in the [Vagrant `disks` Documentation](https://developer.hashicorp.com/vagrant/docs/disks/usage))

   ```sh
   VAGRANT_EXPERIMENTAL="disks" vagrant up
   ```

2. `ssh` into the new VM and execute the `run-bactopia-local.sh` script as root

   ```sh
   vagrant ssh
   sudo ./run-backtopia.sh
   ```
