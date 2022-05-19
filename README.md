# Homework home

The repository for pipelines and [README][r].

# Repository mapping
- [repoA: fork][a] - due to issues with Doxygen I forked [bitcoin/bitcoin][b] rather than [grpc/grpc][g]
- [repoC: for python][c]
- [this repository for pipelines and README][p]

## Branches in this repo
This repository holds the following branches:
- [`taskB`][tb] for [pipelineB][jb]
- [`taskC`][tc] for [pipelineC][jc]
- [`taskD`][td] for [README.md][r] (**NOT** the file you're reading)
- [`master`][m] - additional branch for this readme as well as for  [Dockerfile][d] & [Makefile][f],
  that made this homework much easier (and reproducible).

# Environment
Due to time constraints I decided to use [the official docker image of Jenkins][h].  I extended the image with:
- python3.9
- doxygen
- graphviz (package that contains the `dot` utility, required by Doxygen to generate images; I decided to add this
  software package rather than removing the dependency via patching the Doxyfile because it was easier and provided
  additional value to the generated documentation).
  
See enclosed [Dockerfile][d] and [Makefile][f] for details.

# The Parser
The parser script requires Python 3.9+, since it utilizes [`str.removeprefix()`][3.9] method, new in version 3.9.

## `ignore not standard lines`
Since I was working with doxygen warning log, i decided to process only the lines containing a "`warning: `" string.

## `identify separator`
I understood this line as a subtask to guess what the field separator in warning log file was (colon, but I provide
the logic that fairly guesses it and verifies by counting lines in files identified).

For CSV file I used the comma and double quotes for all string values.

# The Pipelines
The last point of taskB (- archive it) does not make it clear whether "it" means "all generated output" or the compression
output ("doc.tar.gz").  I decided to archive only the compressed output.  I used Jenkins archiving; however taskD
("repoA-doc contains binaries/what is the advantage to use LFS?") may suggest that I should have pushed "doc.tar.gz" back
to the repository instead, which I didn't do, as it wasn't clear enough.

Due to time constraints I failed to provide unit tests for my Python code, although I tested it manually enought
to safely consider it working as expected.

# Closing notes
Please proceed to [**the answers**][r].  I really look forward to hear from you on the easier alternatives
to LFS - the only one I can think of at the moment is [IPFS - Inter Planetary FileSystem][z], which could be
used as the backend for `git-lfs`.


[3.9]: https://docs.python.org/3.9/library/stdtypes.html#str.removeprefix
[a]: https://github.com/szycha76/homework-43-repoA
[b]: https://github.com/bitcoin/bitcoin
[c]: https://github.com/szycha76/homework-43-repoC
[d]: ../../blob/master/Dockerfile
[f]: ../../blob/master/Makefile
[g]: https://github.com/grpc/grpc
[h]: https://hub.docker.com/r/jenkins/jenkins
[jb]: ../../blob/taskB/Jenkinsfile
[jc]: ../../blob/taskC/Jenkinsfile
[m]: ../../tree/master
[p]: https://github.com/szycha76/homework-43-pipelines
[r]: ../../blob/taskD/README.md
[s]: https://github.com/szycha76/homework-43-repoC/blob/master/parser.py
[tb]: ../../tree/taskB
[tc]: ../../tree/taskC
[td]: ../../tree/taskD
[z]: https://ipfs.io/
