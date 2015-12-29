# This image is used to create bleeding edge docker image and is not compatible with any other image
FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install curl git-core software-properties-common htop build-essential -y
RUN add-apt-repository ppa:fkrull/deadsnakes -y
RUN curl -sSL https://get.docker.com/ | sh
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
RUN apt-get install gitlab-ci-multi-runner -y
RUN apt-get install nodejs -y
RUN apt-get install python3.5 python3.5-dev libncurses5-dev python-pip python-dev -y
RUN update-alternatives --install /usr/bin/python3 python3.5 /usr/bin/python3.5 0
RUN pip install virtualenvwrapper
RUN rm /etc/init/gitlab-runner.conf
RUN echo "export TERM=xterm" >> ~/.bashrc
RUN echo "export DEBIAN_FRONTEND=noninteractive" >> ~/.bashrc

# Preserve runner's data
VOLUME ["/etc/gitlab-runner", "/srv/gitlab-runner"]

# init sets up the environment and launches gitlab-runner
CMD ["run", "--user=root", "--working-directory=/srv/gitlab-runner"]
ENTRYPOINT ["/usr/bin/gitlab-runner"]
