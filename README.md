# bactopia-baseline

A small vagrant VM to provide a baseline for running and testing the bactopia pipeline.

## Requirements

-   [Vagrant](https://www.vagrantup.com/) (with experimental [`disks`](https://developer.hashicorp.com/vagrant/docs/disks/usage) feature enabled)
-   75gb of available storage
-   8gb of available RAM
-   2 available CPU cores

## Running

1. Use the following command to start up the vagrant VM from the root of this repository. (_Note:_ The `VAGRANT_EXPERIMENTAL` environment variable must be set to `"disks"` to enable this experimental feature. This is described in the [Vagrant `disks` Documentation](https://developer.hashicorp.com/vagrant/docs/disks/usage))

    ```sh
    VAGRANT_EXPERIMENTAL="disks" vagrant up
    ```

2. `ssh` into the new VM and execute the `run-bactopia-local.sh` script as root inside of a login shell to load anaconda and the bactopia environment

    ```sh
    vagrant ssh
    sudo bash -l -c /home/vagrant/run-bactopia-local.sh
    ```

### Useful Vagrant Commands

#### Start the VM

```sh
vagrant up
```

#### Shutdown the VM

```sh
vagrant halt
```

#### Destroy the VM

```sh
vagrant destroy
```

#### VM Status

```sh
vagrant status
```
