name: AWS CodePipeline

on:
  push:
    branches:
      - feature_neha # Change this to your default branch name

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      
      # Add other steps as necessary to build and test your code

      # After build and test steps, specify the artifact path
      - name: Upload artifact to S3
        uses: actions/upload-artifact@v2
        with:
          name: my-artifact
          path: artifacts  # Specify the path to your artifact here
