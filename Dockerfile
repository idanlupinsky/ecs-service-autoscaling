# Based on the Dockerfile in this post by Alexander Brand:
# https://alexbrand.dev/post/how-to-package-rust-applications-into-minimal-docker-containers/
#
# The multi-stage build significantly decreases the size of the final image as it only includes
# the statically-linked executable. In addition, the Docker build cache is used by first building
# a plain project with only the dependencies as a separate layer.

FROM rust:latest AS build

RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /app
RUN USER=root cargo new service

# Create separate layer with service dependencies
WORKDIR /app/service
COPY Cargo.toml Cargo.lock ./
RUN cargo build --release

# Create a new layer with the application code added
COPY src ./src
RUN cargo install --target x86_64-unknown-linux-musl --path .

# Build scratch image with only the target executable from our build image
FROM scratch
COPY --from=build /usr/local/cargo/bin/ecs-service-autoscaling .
USER 1000
CMD [ "./ecs-service-autoscaling" ]