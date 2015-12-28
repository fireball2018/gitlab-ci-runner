# This image is used to create bleeding edge docker image and is not compatible with any other image
FROM ubuntu:14.04

RUN curl -sSL https://get.docker.com/ | sh
RUN curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
RUN apt-get install gitlab-ci-multi-runner

# Preserve runner's data
VOLUME ["/etc/gitlab-runner", "/srv/gitlab-runner"]

# init sets up the environment and launches gitlab-runner
CMD ["run", "--user=root", "--working-directory=/srv/gitlab-runner"]
ENTRYPOINT ["/usr/bin/gitlab-runner"]
