# bactopia-baseline

A small vagrant VM to provide a baseline for running and testing the bactopia pipeline.

## Requirements

-   [Vagrant](https://www.vagrantup.com/)
-   [Virtual Box](https://www.virtualbox.org/)
-   50gb of available storage
-   8gb of available RAM
-   2 available CPU cores

## Running

1. Use the following command to start up the vagrant VM from the root of this repository.

    ```sh
    vagrant up
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
