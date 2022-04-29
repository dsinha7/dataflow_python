
export PROJECT=mllab-gregoryselva
export template_name=gcs_to_bq_with_module
export TEMPLATE_IMAGE="gcr.io/$PROJECT/samples/dataflow/$template_name:latest"
# Build the image into Container Registry, this is roughly equivalent to:
#   gcloud auth configure-docker
#   docker image build -t $TEMPLATE_IMAGE .
#   docker push $TEMPLATE_IMAGE
gcloud builds submit --tag "$TEMPLATE_IMAGE" .
