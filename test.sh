#!/bin/bash

# Define services to test
services=(
  "emailservice"
  "productcatalogservice"
  "recommendationservice"
  "shippingservice"
  "checkoutservice"
  "paymentservice"
  "currencyservice"
  "cartservice"
  "frontend"
  "adservice"
  "loadgenerator"
)

# Loop through each service and check if Docker image exists
for service in "${services[@]}"; do
  if docker image inspect $service:latest &>/dev/null; then
    echo "Docker image $service:latest exists. Test passed."
  else
    echo "Docker image $service:latest does not exist. Test failed."
    exit 1
  fi
done

echo "All Docker images built successfully. Test passed."
