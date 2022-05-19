# Welcome!

This repository holds the following branches:
- `taskB` for pipelineB
- `taskC` for pipelineC
- `taskD` for README.md (the file you're reading)
- `master` - for Makefile that made this homework much easier

# Q&A

### How did you test your pipelines?
Due to time constraints I have tested them manually only - i.e.
- I added some debugging output in the console logs, such as:
   - variable values,
   - configuration file (i.e. Doxyfile)
   - for Doxyfile patching: diffs between stages
- Revised "post mortem" - browsed through the workspace or archived
   artifacts to see if the output matches expectations.

### How did you test repoC python?
Unfortunately, again due to limited time I performed only manual tests, such as:
- emulating exceptions by intentionally passing wrong parameters to functions,
- printing some values as the loops progress,
- artificially limited the scope of operations to a few percent and dump
   the result on screen
- once local testing became not feasible (I didn't have Python 3.9 locally
   and it became required because I used `str.removeprefix()` method twice,
   for convenience) - I kept running pipelines and reading the logs to see
   what happened.
- I repeated those steps until I got satisfying results.

### LFS
LFS stands for "Large File Storage".  Git-lfs is a de-facto standard plugin
to git that offloads the repository by storing the BLOBs (Binary Large OBjects)
outside the actual repository.  It works as a set of hooks that would take care
of up- and downloading the actual data to LFS store, and track their fingerprints
only instead.  Main cons: it is not distributed (git is), requires some overhead
of setting up and also when using.  Pros: drastically reduces time needed to start
working with the code (since the binaries are not cloned by default).

#### how to turn it on

```bash

# Use your OS method of installing packages to get/install git-lfs.  Then:

git lfs install

git lfs track <list-of-files to track> | <pattern>

git add .gitattributes

git add <all files set to be tracked in lfs>
```

See also: https://github.com/git-lfs/git-lfs/wiki/Tutorial#migrating-existing-repository-data-to-lfs

Note: Major git service providers now offer easy git lfs integration.



[#]: vim: number relativenumber et ts=3 sw=3
