# README

Very primitive scripts for arduino projects.

They include: 

- a simple dependency manager 
- a simple version bumper

## Dependency manager

Use: 

```
# Write your dependencies.conf (use the provided template)

# Execute
./pull_dependencies

# Your dependencies are pulled from GIT and placed under ./src/ as symlinks

```

## Version bumper

Use: 

```
# Write your own library.json including the current version

# Execute
./bump <MAJOR|MINOR|PATCH>

# Your library.json will be modified, and commit and tags created.

```
