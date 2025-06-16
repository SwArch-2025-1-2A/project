# MeetUN

![Logo MeetUN](docs/meetUN.svg "MeetUN")

---

## Table of contents

- [MeetUN](#meetun)
  - [Table of contents](#table-of-contents)
  - [Setup](#setup)
    - [Git submodules](#git-submodules)
      - [Updating submodules](#updating-submodules)
  - [Running the project](#running-the-project)
    - [Running with Docker Compose](#running-with-docker-compose)
      - [Build the project and run it](#build-the-project-and-run-it)
      - [Run the project without building](#run-the-project-without-building)
      - [Partially clean the environment](#partially-clean-enviroment)
      - [Fully clean environment](#fully-clean-environment)

---

## Setup

Clone this repository adding the `--recurse-submodules` flag, e.g:

```sh
git clone --recurse-submodules git@github.com:SwArch-2025-1-2A/project.git
```

This should also pull the changes within each [submodule](#git-submodules).

If you forgot the `--recurse-submodules` or need to update the submodules themselves
you can just go [here](#updating-submodules)

### Git submodules

We are using [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
to manage each service.

> [!TIP]
> In order to have an easier time with git submodules, run the following
> commands. This will allow you to use these seamlessly (`--global` is completely
> optional).

```sh
git config --global push.recurseSubmodules on-demand
git config --global submodule.recurse true
```

> [!NOTE]
> Once you have excecuted these commands every time you `pull`/`fetch` changes
your modules will get updated. So if you move between branches you can just
`git pull` and you're good to go.

In case you want to manually update your submodules. Please refer to
[updating submodules](#updating-submodules).

#### Updating submodules

Once you have read about [git submodules](#git-submodules), you can understand
that these hold a SHA to a commit. So we have two ways of updating them if you
cannot configure the recommended configs.

1. Initialize, fetch and checkout any nested submodule with the _local status_
reference:

    ```sh
    git submodule update --init --recursive
    ```

1. Initialize, fetch and checkout any nested submodule with the status of their
remote-tracking branch:

    ```sh
    git submodule update --init --recursive --remote
    ```

## Running the project

### Running with Docker Compose

Make sure the submodules are [up-to-date](#updating-submodules) to avoid
possible issues with stale state.

#### Setting up the needed environment variables

In order for you to run the project, you need a .env file with various variables.
You can find a good and functional example of a .env file in .env.example, and you
can run the following command to get the environment variables needed:

```sh
cp .env.example .env
```

#### Build the project and run it

```sh
docker compose up --build
```

#### Run the project without building

```sh
docker compose up
```

#### Partially clean enviroment

> [!TIP]
> If you want to have a _almost_ clean build you need to stop
> and remove containers, networks by running:

```sh
docker compose down --remove-orphans
```

#### Fully clean environment

> [!WARNING]
> The following command gives you a clean slate to start from, but it
> remove the volumes too. So any data that you may have, it will be
> removed as well.

```sh
docker compose down --remove-orphans --volumes
