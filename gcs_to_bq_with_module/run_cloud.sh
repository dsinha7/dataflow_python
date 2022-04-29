#gcloud config set project mllab-gregoryselva
#gcloud config set compute/zone us-centrala1
#export GOOGLE_APPLICATION_CREDENTIALS=~/mllab-gregoryselva-0f040207eba1.json
export GOOGLE_APPLICATION_CREDENTIALS=~/Downloads/mllab-gregoryselva-0f040207eba1.json

export PROJECT=mllab-gregoryselva
export STORAGE_BUCKET=$PROJECT-deb-data

export template_name=gcs_to_bq_with_module
export TEMPLATE_IMAGE="gcr.io/$PROJECT/samples/dataflow/$template_name:latest"
export WORKDIR=/dataflow/python/gcs_to_bq_with_module
export TEMPLATE_PATH="gs://$STORAGE_BUCKET/dataflow/templates/$template_name.json"

# Run the Flex Template.
gcloud dataflow flex-template run "gcs-to-bq-with-module-`date +%Y%m%d-%H%M%S`" \
--template-file-gcs-location "$TEMPLATE_PATH" \
--region "us-central1" \
--additional-experiments=use_runner_v2 \
--parameters=setup_file=/dataflow/python/gcs_to_bq_with_module/setup.py \
--parameters input="gs://$STORAGE_BUCKET/usa_names_100.csv" \
--parameters output_table="lake.usa_names_300"


