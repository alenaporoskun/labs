#!/usr/bin/env python3
import json
import os

# src
src_dir = "./dataset"
zip_file = "test.zip"
fn_csv_in_zip = 'arc/master/data/test.csv'

# dst
dst_dir = "./data/"


def main():
    print_header("4. Convert csv to json and xlsx")
    data_json, filename_json = convert_csv_to_json(dst_dir, fn_csv_in_zip)
    print("json:", data_json)
    print("json filename:", filename_json)


def convert_csv_to_json(dn, fn_csv):
    data = read_test_csv_dict(dn, fn_csv)

    dn_json = os.path.dirname(fn_csv)
    fn_csv_name = os.path.basename(fn_csv)
    fn_parts = os.path.splitext(fn_csv_name)
    fn_name = fn_parts[0]
    filename_json = os.path.join(dn, dn_json, fn_name + '.json')

    # Serializing json
    data_json = json.dumps(data, indent=2)

    # Writing to json
    with open(filename_json, "w") as json_file:
        json_file.write(data_json)

    return data_json, filename_json
