FROM node:latest

ENV TERM=xterm \
  GIT_DEPTH=1 \
  GIT_SUBMODULE_DEPTH=1 \
  GIT_SUBMODULE_STRATEGY=recursive \
  VIRTUAL_ENV="" \
  VENVBIN=""

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        git \
        unzip \
        make \
        python3 \
        python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    export target=/awscliv2.zip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o ${target} && \
    unzip ${target} && \
    ./aws/install && \
    npm install -g aws-cdk && \
    rm -rf ${target} ./aws && \
    rm -rf /var/lib/apt/lists/*