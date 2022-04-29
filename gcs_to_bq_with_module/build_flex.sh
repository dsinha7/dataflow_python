export PROJECT=mllab-gregoryselva
export template_name=gcs_to_bq_with_module
export TEMPLATE_IMAGE="gcr.io/$PROJECT/samples/dataflow/$template_name:latest"

export STORAGE_BUCKET=$PROJECT-deb-data
export TEMPLATE_PATH="gs://$STORAGE_BUCKET/dataflow/templates/$template_name.json"
echo $PROJECT
# Build the Flex Template.
gcloud dataflow flex-template build $TEMPLATE_PATH \
  --image "$TEMPLATE_IMAGE" \
  --sdk-language "PYTHON"
