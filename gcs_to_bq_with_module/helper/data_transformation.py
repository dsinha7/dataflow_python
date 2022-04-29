import os.path
from pathlib import Path
from apache_beam.io.gcp.bigquery_tools import parse_table_schema_from_json
import csv

class DataTransformation:

    def __init__(self):
        dir_path = Path(__file__).resolve().parent.parent
        self.schema_str = ''
        schema_file = os.path.join(dir_path, 'resources',
                                   'usa_names_schema.json')
        with open(schema_file) as f:
            data = f.read()
            self.schema_str = '{"fields" :' + data + '}'

    def parse_method(self, string_input):
        """This method translates a single line of comma separated values to a
        dictionary which can be loaded into BigQuery"""
        schema = parse_table_schema_from_json(self.schema_str)
        field_map = [f for f in schema.fields]
        reader = csv.reader(string_input.split('\n'))
        for csv_row in reader:
            month = '01'
            day = '01'
            year = csv_row[2]
            row = {}
            for i,value in enumerate(csv_row):
                if field_map[i].type == 'DATE':
                    # Format the date to YYYY-MM-DD format which BigQuery
                    # accepts.
                    value = '-'.join((year, month, day))

                row[field_map[i].name] = value

            return row
