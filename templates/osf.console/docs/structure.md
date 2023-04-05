# Repo Template

This is a template to create a new repo.

## Structure

```text
├── <files>
├── .github
│   ├── ...
│   └── workflows
├── deploy
│   ├── local
│   ├── prod
│   └── staging
├── docs
│   └── ...
└── src 
    ├── ...
    └── ...
```

### `<files>`

The following list of files will be there:

- `readme.md`: Document to describe the project / repo.
- `LICENSE`: MIT License.
- `.gitignore`: Generic git-ignore.
- `.dockerignore`: Generic docker-ignore.
- `dockerfile`: Dockerfile to build & run.
- `makefile`: Makefile with certain targets like show, prune, clean, clean-all, build, run, recreate-lock-files.

### `.github` folder

This folder will contain #TODO.

### `deploy` folder

This folder contains deployment scripts / manifests for each environment: local, staging & production (prod).

### `docs` folder

This folder will contain `.md` files with relevant documents.

### `src` folder

This folder will contain the source code.

## Secrets

Any secret, like access-token / credentials / etc, should be stored in Github secrets inside the environment. As mentioned earlier, there can be local, staging & production environment with their respective secrets.

## Environments

### local

This environment is meant for development purpose. This can be a placeholder since most of the times it will be running out of developer's local computer.

### staging

This environment is for testing before the changes are pushed to production.

### production (prod)

This is production environment.
