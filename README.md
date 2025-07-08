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
      - [Setting up the needed environment variables](#setting-up-the-needed-environment-variables)
      - [Build the project and run it](#build-the-project-and-run-it)
      - [Running the desktop client](#running-the-desktop-client)
      - [Run the project without building](#run-the-project-without-building)
      - [Partially clean enviroment](#partially-clean-enviroment)
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
docker compose --profile prod up --build
```

> [!IMPORTANT]
> Make sure to include the flag --profile prod, as it is needed for
> various services, which run in prod mode when running the whole project.

> [!NOTE]
> This won't run the desktop client. To do that [read the instructions for it](#running-the-desktop-client)

#### Running the desktop client

These steps worked in Ubuntu. There are no guarantees that it will work on other Linux distributions or even the WSL.

The desktop client requires the rest of the project to be [built and running in docker containers](#build-the-project-and-run-it)

If you don't want to manually do all this steps, please, grant permissions to execute this script:

```sh
chmod +x run_desktop_fe.sh
```

Then execute it.

```sh
./run_desktop_fe.sh
```

Otherwise, proceed with the following steps one by one:

First, you need to install the self-signed certificate of the desktop reverse proxy on your system, otherwise any calls made by the
desktop client will fail because it will notice that the certificate is self-signed and it won't trust it. You can do the 
installation by running:

```sh
sudo cp /path/to/mu_desktop_rp/certs/certificado.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

Now go to the directory of the `mu_fe_superuser` module and start the Next.js server. If you haven't build it yet,
make sure to do so with

```sh
npm install
npm run build
```

After making sure that the package is built, run the Next.js server with the following command and environmental variables

```sh
GRAPHQL_API="https://localhost:4000/query" NODE_OPTIONS=--use-openssl-ca npm run dev
```

> [!NOTE]
> Right now the project doesn't support other ports for the GRAPHQL_API, so leave that environmental variable as is

Once the Next.js server is already running, you can start the electron app with the command

```sh
npx electron --no-sandbox --ozone-platform=wayland main.cjs
```

If your Linux distribution doesn't use Wayland (look it up), then try to run the command like this

```sh
npx electron --no-sandbox main.cjs
```

To enter the admin panel, you can open the Dev Tools (by clicking View and then Toggle Developer Tools or pressing CTRL+Shift+I)
in the desktop client and type the following command in the console

```js
window.location.href="http://localhost:3000/grupos"
```

There you can send tasks to the bulk microservice and then retrieve the results using the task_id that you got

#### Run the project without building

```sh
docker compose --profile prod up
```



#### Partially clean enviroment

> [!TIP]
> If you want to have a _almost_ clean build you need to stop
> and remove containers, networks by running:

```sh
docker compose --profile prod down --remove-orphans
```

#### Fully clean environment

> [!WARNING]
> The following command gives you a clean slate to start from, but it
> remove the volumes too. So any data that you may have, it will be
> removed as well.

```sh
docker compose --profile prod down --remove-orphans --volumes
