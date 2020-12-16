# README

Very primitive helper scripts for arduino projects.

The project includes: 

- a simple dependency manager 
- a simple version bumper
- a simple code formatter

## Why?

I pretty much enjoy using `platformio` for dependency management. 
It is just that it seems to rely too much on libraries having been released:

https://docs.platformio.org/en/latest/librarymanager/creating.html

This is not the case for a significant amount of existent libraries. I want to still
be able to use them, and "treat" them in an easy way beforehand to integrate them in my projects.
I hope in the future I won't have to maintain this project anymore.

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
