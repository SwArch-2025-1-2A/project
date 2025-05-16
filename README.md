# MeetUN

![logo MeetUN](frontend/public/assets/meetUN.svg "MeetUN")

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
