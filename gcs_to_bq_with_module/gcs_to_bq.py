import argparse
import logging
import re
from typing import List
import apache_beam as beam

from apache_beam.options.pipeline_options import PipelineOptions
from helper.data_transformation import DataTransformation

def run(
        input_file:str,
        output_table:str,
    ) -> None:
    """Build and run the pipeline."""
    options = PipelineOptions(beam_args, save_main_session=True)
    #data_ingestion = DataIngestion()
    data_transformation =  DataTransformation()
    with beam.Pipeline(options=options) as pipline:
        message = (
            pipline
            | 'Read from a File' >> beam.io.ReadFromText(input_file,skip_header_lines=1)
            | 'String To BigQuery Row' >>
            beam.Map(lambda s: data_transformation.parse_method(s)) |
            'Write to BigQuery' >> beam.io.WriteToBigQuery(
                output_table,
                # Here we use the simplest way of defining a schema:
                # fieldName:fieldType
                schema='state:STRING,gender:STRING,year:STRING,name:STRING,'
                       'number:STRING,created_date:STRING',
                # Creates the table in BigQuery if it does not yet exist.
                create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                # Deletes all data in the BigQuery table before writing.
                write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE))

        pipline.run().wait_until_finish()

if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    logging.info("Starting the dataflow")
    parser =argparse.ArgumentParser()
    parser.add_argument(
        '--input',
        dest='input',
        required=False,
        help='Input file to read. This can be a local file or '
             'a file in a Google Storage Bucket.',
        # This example file contains a total of only 10 lines.
        # Useful for developing on a small set of data.
        default='gs://python-dataflow-example/data_files/head_usa_names.csv')

    # This defaults to the lake dataset in your BigQuery project. You'll have
    # to create the lake dataset yourself using this command:
    # bq mk lake
    parser.add_argument(
        "--output_table",
        dest='output',
        help="Output BigQuery table for results specified as: "
             "PROJECT:DATASET.TABLE or DATASET.TABLE.",
    )
    args, beam_args = parser.parse_known_args()
    run(args.input, args.output)
