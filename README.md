# nix-build-for-each

Parse nix-build output and trigger a hook for each built derivation.
Great for maintaining a private cache.

## Why?

In general, you can always use `nix copy --to s3://blah` to copy a build result and all its
dependencies.  So for that simple case, you don't need this fancy hook.

However, imagine that you are using nix in CI environment where you expect build failures of top
level derivations to fail, such as often the case in large team projects.  `nix copy` can only work
on successfully built derivations, but you may want to copy any of the successfully built
dependencies as well so that additional CI runs are faster.

`nix-build-for-each` provides a way to parse nix-build output and then copy each successful
dependency as it is built, or really do any other intermediate work.

Heavily inspired by `cachix`, but generalized to a more naive purpose.

Tested with nix 2.1.

## Usage

```
nix-build -A release 2>&1 | nix-build-for-each 'nix copy --to s3://my-bucket'

# OR


nix-build -A release 2>&1 | tee buildoutput
cat buildoutput | nix-build-for-each 'nix copy --to s3://my-bucket'
```
