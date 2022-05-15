# Jenkins master with executor
# - needed tools on executor node:
#   - python 3.x
#   - doxygen

FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y python3 doxygen && rm -rf /var/lib/apt/lists/*
USER jenkins
