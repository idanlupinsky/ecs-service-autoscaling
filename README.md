# ECS Fargate Service Auto-Scaling Demo

This repository contains a minimal HTTP service to demonstrate the usage of auto-scaling concepts with ECS and Fargate.

The service uses the [Warp web framework](https://github.com/seanmonstar/warp). The docker image is deployed to https://hub.docker.com/r/idanlupinsky/autoscaled-service-example and is specified in the task definition.

The network architecture is not optimal as we're deploying the tasks to public subnets. This is done for the sake of brevity as this example focuses on the aspect of provisioning the ECS service as a scalable target.
