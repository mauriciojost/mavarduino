# README

Very primitive helper scripts for arduino projects.

The project includes: 

- a simple dependency manager 
- a simple version bumper
- a simple code formatter

## How to use

Enter your project's directory and do: 

```
git submodule add https://github.com/mauriciojost/mavarduino.git .mavarduino
git commit ...
./.mavarduino/create_links
```

Then simply use:

```
./pull_dependencies ...
./launch_tests ...
./bump_version ...
```

## Dependency manager

- Write your `dependencies.conf` (use the provided template)
- Execute

```
./pull_dependencies -p -l
```

- Your dependencies are pulled from GIT and placed under `./src/` as symlinks

## Version bumper

Use: 

```
- Write your own `library.json` including the current version
- Execute

```
./bump <MAJOR|MINOR|PATCH>
```

- Your `library.json` will be modified, and commit and tags created.

```
