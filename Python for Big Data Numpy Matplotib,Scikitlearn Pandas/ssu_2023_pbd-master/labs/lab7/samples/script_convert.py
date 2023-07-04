#!/usr/bin/env python3
import csv
import json
import os
import shutil
import sys
from zipfile import ZipFile

import openpyxl
import pandas

# src
src_dir = "../datasets"
zip_files = ["oil-prices.zip", "population.zip", "ppp.zip"]

# dst
dst_dir = "../data/"


def main():
    print("The conversion script is running...")

    print_header("1. Check version")
    print_version()

    print_header("2. Unpack zip")
    remove_dst()
    unpack_arc()

    print_header("3. Create folder 'src' and copy the csv files to it.")
    copy_csv_files()

    print_header("4. Read csv file")
    read_csv()

    print_header("5. Convert csv to json and xlsx")
    fun_convert_csv_to_json_and_xlsx()


def print_header(msg):
    line = '=' * (len(msg) + 2)
    print(f'\n{line}')
    print(f' {msg} ')
    print(f'{line}')


def print_version():
    print(sys.version)


def remove_dst():
    print(f"Current workdir: {os.getcwd()}")
    if dst_dir and dst_dir not in ('/', './'):
        shutil.rmtree(dst_dir, ignore_errors=True)


def unpack_arc():
    for zip_file in zip_files:
        zip_full_path = os.path.join(src_dir, zip_file)
        with ZipFile(zip_full_path, 'r') as zip_obj:
            zip_obj.extractall(dst_dir)

def copy_csv_files():
    # Create folder 'src' and copy the csv files
    if os.path.exists('../src') == False:
        print("Copy the csv files...\n")
        os.mkdir('../src')
        # print(os.getcwd())
        paths_from = ['../data/oil-prices-master/data', '../data/population-master/data/', '../data/ppp-master/data/']
        paths_to = ['../src/oil-prices', '../src/population', '../src/ppp']
        # ./src - якщо скрипт в lab7;  ../src - якщо скрипт в lab7/samples або ін. директорії

        for i in range(len(paths_from)):
            os.mkdir(paths_to[i])
            k = 0
            for file in os.listdir(paths_from[i]):
                if '.csv' not in file:
                    continue
                k += 1
                print("#", k)
                print('name of file: ', file)
                path_join = os.path.join(paths_from[i], file)
                print('path_join: ', path_join, '\n')
                shutil.copy2(path_join, paths_to[i])

            if os.listdir(paths_from[i]) == os.listdir(paths_to[i]):
                print("All files from folder '{}' to folder '{}' are copied.\n".format(paths_from[i], paths_to[i]))

        print("The process of copying files is complete.\n")


def read_csv():
    # Read csv files from folder './src/' in two formats: list and dictionary
    print("os.listdir('../src/'): ", os.listdir('../src/'), '\n')
    paths_to = ['../src/oil-prices', '../src/population', '../src/ppp']
    for i in range(len(paths_to)):
        k = 0
        for file in os.listdir(paths_to[i]):
            if '.csv' not in file:
                continue
            k += 1
            print("#", k)
            print('name of file: ', file)
            path_join = os.path.join(paths_to[i], file)
            print('path_join: ', path_join, '\n')

            # 1 Read csv file as list of list
            data_list = read_csv_list(path_join)
            print("data_list[0]:", data_list[0])
            print("data_list[1]:", data_list[1], '\n')
            # print("data_list:", data_list)

            # 2 Read csv file as list of dictionary
            data_dict = read_csv_dict(path_join)
            print("data_dict[0]:", data_dict[0])
            print("data_dict[1]:", data_dict[1], '\n')
            # print("data_dict:", data_dict)

        print("Reading files from folder '{}' in two formats is complete.\n".format(paths_to[i]))

    print("The process of reading files is complete.\n")


def read_csv_list(filename):
    lines = []
    with open(filename, 'r') as data:
        for line in csv.reader(data):
            lines.append(line)
    return lines


def read_csv_dict(filename):
    with open(filename, 'r') as f:
        dict_reader = csv.DictReader(f)
        list_of_dict = list(dict_reader)
    return list_of_dict


def fun_convert_csv_to_json_and_xlsx():
    # Convert csv to json all files in src
    print("os.listdir('../src/'): ", os.listdir('../src/'), '\n')
    paths_to = ['../src/oil-prices', '../src/population', '../src/ppp']
    for i in range(len(paths_to)):
        k = 0
        for file in os.listdir(paths_to[i]):
            if '.csv' not in file:
                continue
            k += 1
            print("#", k)
            print('name of file: ', file)
            path_join = os.path.join(paths_to[i], file)
            print('path_join:    ', path_join)

            data_json, filename_json = convert_csv_to_json(path_join)
            print('json filename:', filename_json)
            # print("json:", data_json)

            filename_xlsx = convert_json_to_xlsx_by_pandas(filename_json)
            print('xlsx filename:', filename_xlsx, '\n')

        print("Converting files in folder '{}' from csv to json and xlsx is complete.\n".format(paths_to[i]))

    print("The process of converting all files from csv to json and xlsx is complete.\n")

def convert_csv_to_json(path_join):
    # Convert csv to json file
    data = read_csv_dict(path_join)
    # print('data[0]:', data[0])

    dn_json = os.path.dirname(path_join)
    fn_csv_name = os.path.basename(path_join)

    fn_parts = os.path.splitext(fn_csv_name)
    fn_name = fn_parts[0]
    filename_json = os.path.join(dn_json, fn_name + '.json')

    # Serializing json
    data_json = json.dumps(data, indent=2)

    # Writing to json
    with open(filename_json, "w") as json_file:
        json_file.write(data_json)

    return data_json, filename_json


def convert_json_to_xlsx_by_pandas(filename_json):
    fn_parts = os.path.splitext(filename_json)
    fn_name = fn_parts[0]
    filename_xlsx = fn_name + '_pandas.xlsx'

    pandas.read_json(filename_json).to_excel(filename_xlsx, index=False)

    return filename_xlsx


if __name__ == '__main__':
    main()

