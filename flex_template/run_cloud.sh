#gcloud config set project mllab-gregoryselva
#gcloud config set compute/zone us-centrala1
#export GOOGLE_APPLICATION_CREDENTIALS=~/mllab-gregoryselva-0f040207eba1.json
export GOOGLE_APPLICATION_CREDENTIALS=~/Downloads/mllab-gregoryselva-0f040207eba1.json

export PROJECT=mllab-gregoryselva
export STORAGE_BUCKET=$PROJECT-deb-data

export template_name=flex_batch_avd1
export TEMPLATE_IMAGE="gcr.io/$PROJECT/samples/dataflow/$template_name:latest"
export WORKDIR=/dataflow/python/using_flex_template_adv1
export TEMPLATE_PATH="gs://$STORAGE_BUCKET/dataflow/templates/$template_name.json"

# Run the Flex Template.
gcloud dataflow flex-template run "etl-using-flex-template-adv1-`date +%Y%m%d-%H%M%S`" \
--template-file-gcs-location "$TEMPLATE_PATH" \
--region "us-central1" \
--additional-experiments=use_runner_v2 \
--parameters=setup_file=/dataflow/python/using_flex_template_adv1/setup.py \
--parameters=input=gs://dataflow-samples/shakespeare/kinglear.txt \
--parameters=output=gs://$STORAGE_BUCKET/using_flex_template_adv1/output

