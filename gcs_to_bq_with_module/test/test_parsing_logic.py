import logging
import unittest
from gcs_to_bq_with_module.helper.data_transformation import DataTransformation

class TestHandlers(unittest.TestCase):
    def setUp(self):
        logging.basicConfig(level=logging.DEBUG)

    def test_parsing_data_transformation(self):
        """Test the parsing logic in data_transformation.py"""
        data_ingestion = DataTransformation()
        csv_input = 'KS,F,1923,Dorothy,654,11/28/2016'
        expected_dict_output = {
            'state': 'KS',
            'gender': 'F',
            'year': '1923-01-01',  # This is the BigQuery format.
            'name': 'Dorothy',
            'number': '654',
            'created_date': '11/28/2016'
        }
        actual_dict_outut = data_ingestion.parse_method(csv_input)
        self.assertEqual(actual_dict_outut, expected_dict_output)

if __name__ == '__main__':
    unittest.main()
