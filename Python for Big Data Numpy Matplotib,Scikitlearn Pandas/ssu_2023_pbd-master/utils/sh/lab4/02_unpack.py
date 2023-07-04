#!/usr/bin/env python3
import os
import shutil
import sys
from zipfile import ZipFile

# src
src_dir = "./dataset"
zip_file = "test.zip"

# dst
dst_dir = "./data/"


def main():
    print_header("2. Unpack zip")
    remove_dst()
    unpack_arc()


def remove_dst():
    print(f"Current workdir: {os.getcwd()}")
    if dst_dir and dst_dir not in ('/', './'):
        shutil.rmtree(dst_dir, ignore_errors=True)


def unpack_arc():
    print(sys.version)

    zip_full_path = os.path.join(src_dir, zip_file)
    with ZipFile(zip_full_path, 'r') as zip_obj:
        zip_obj.extractall(dst_dir)
