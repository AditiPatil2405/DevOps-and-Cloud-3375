#!/bin/bash

# Variables
GCR_IMAGE="gcr.io/your-project/your-image:tag"  # Replace with your GCR image
ECR_IMAGE="your-ecr-repo-url/your-image:tag"    # Replace with your ECR image URL

# Pull GCR Image
docker pull $GCR_IMAGE

# Tag the image for ECR
docker tag $GCR_IMAGE $ECR_IMAGE

# Push to ECR
docker push $ECR_IMAGE
