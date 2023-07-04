#!/usr/bin/env python3
import csv
import os

# src
src_dir = "./dataset"
zip_file = "test.zip"
fn_csv_in_zip = 'arc/master/data/test.csv'

# dst
dst_dir = "./data/"


def main():
    print_header("3. Read csv file")
    # 3.1 Read csv file as list of list
    data_list = read_test_csv_list(dst_dir, fn_csv_in_zip)
    print("data_list:", data_list)
    print("data_list year:", data_list[1][0])
    # 3.2 Read csv file as list of dictionary
    data_dict = read_test_csv_dict(dst_dir, fn_csv_in_zip)
    print("data_dict:", data_dict)
    print("data_dict year:", data_dict[1]['year'])


def read_test_csv_list(dn, fn):
    filename = os.path.join(dn, fn)
    lines = []
    with open(filename, 'r') as data:
        for line in csv.reader(data):
            lines.append(line)

    return lines


def read_test_csv_dict(dn, fn):
    filename = os.path.join(dn, fn)
    with open(filename, 'r') as f:
        dict_reader = csv.DictReader(f)
        list_of_dict = list(dict_reader)
    return list_of_dict
