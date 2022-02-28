FROM ubuntu:18.04

# Replace shell with bash so we can source files later on
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install vim, curl
RUN apt update
RUN apt install -y vim curl

# Install NVM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.11.0
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN source $NVM_DIR/nvm.sh

# Install Node
RUN source $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install yarn
RUN npm install -g yarn

# Install
COPY . /app
WORKDIR /app
RUN yarn
