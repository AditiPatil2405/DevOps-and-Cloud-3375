#!/bin/bash

# List of Docker images to push to ECR
images=(
    "gcr.io/google-samples/microservices-demo/emailservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/checkoutservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/recommendationservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/frontend:v0.9.0"
    "gcr.io/google-samples/microservices-demo/paymentservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/productcatalogservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/cartservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/loadgenerator:v0.9.0"
    "gcr.io/google-samples/microservices-demo/currencyservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/shippingservice:v0.9.0"
    "gcr.io/google-samples/microservices-demo/adservice:v0.9.0"
)

# AWS ECR repository URI
ecr_repository="058264132523.dkr.ecr.ca-central-1.amazonaws.com/test"

# Authenticate Docker client to ECR
aws ecr get-login-password --region ca-central-1 | docker login --username AWS --password-stdin "$ecr_repository"

# Tag and push each Docker image to ECR
for image in "${images[@]}"; do
    echo "Pushing Docker image: $image"
    docker pull "$image"     
    trimmed_image="${image//:/-}"
    tagged_image="$ecr_repository:${trimmed_image#gcr.io/google-samples/microservices-demo/}"
    docker tag "$image" "$tagged_image"
    docker push "$tagged_image"
done
