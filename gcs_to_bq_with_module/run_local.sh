#gcloud config set project mllab-gregoryselva
#gcloud config set compute/zone us-centrala1
#export GOOGLE_APPLICATION_CREDENTIALS=~/mllab-gregoryselva-0f040207eba1.json
export GOOGLE_APPLICATION_CREDENTIALS=~/Downloads/mllab-gregoryselva-0f040207eba1.json

export DATAFLOW_REGION=us-central1
export PROJECT_ID=mllab-gregoryselva
export STORAGE_BUCKET=$PROJECT_ID-deb-data

echo $STORAGE_BUCKET
python3 gcs_to_bq.py \
    --region $DATAFLOW_REGION \
    --input gs://$STORAGE_BUCKET/usa_names_100.csv \
    --output_table lake.usa_names_10 \
    --project $PROJECT_ID \
    --temp_location gs://$STORAGE_BUCKET/tmp/

#    --output gs://$STORAGE_BUCKET/results/outputs \
#    --runner DataflowRunner \