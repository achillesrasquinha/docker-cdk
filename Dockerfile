FROM ubuntu:latest

ENV GIT_DEPTH=1 \
  GIT_SUBMODULE_DEPTH=1 \
  GIT_SUBMODULE_STRATEGY=recursive

ENV NVM_VERSION="0.35.3" \
    NODE_VERSION="18"

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
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    . $NVM_DIR/nvm.sh && \
    nvm install ${NODE_VERSION} && \
    nvm alias default $NODE_VERSION && \
    nvm use default && \
    npm config delete prefix && \
    npm config set prefix $NVM_DIR/versions/node/v${NODE_VERSION} && \
    export PATH="$NVM_DIR/versions/node/v${NODE_VERSION}/bin:$PATH" && \
    npm install -g yarn aws-cdk && \
    ln -s $NVM_DIR/versions/node/v${NODE_VERSION}/bin/node /usr/bin/node && \
    ln -s $NVM_DIR/versions/node/v${NODE_VERSION}/bin/yarn /usr/bin/yarn && \
    ln -s $NVM_DIR/versions/node/v${NODE_VERSION}/bin/cdk  /usr/bin/cdk  && \
    rm -rf ${target} ./aws && \
    rm -rf /var/lib/apt/lists/*