FROM python:3.10-alpine
LABEL org.opencontainers.image.source https://github.com/qernal/github-actions-rust-clippy

# add packages
RUN apk add gcc libgcc libstdc++ llvm12-libs musl musl-dev curl openssl-dev git openssh --no-cache
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --output /tmp/rustup.sh && \
    chmod +x /tmp/rustup.sh && \
    /tmp/rustup.sh -y && \
    ln -s $HOME/.cargo/bin/* /usr/bin/
COPY ./src /

# setup src
RUN mkdir -p /root/.ssh
RUN mkdir /app
COPY ./ ./app/

CMD ["python", "/clippy.py"]