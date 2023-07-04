#!/usr/bin/env python3
import sys


def main():
    print_header("1. Check version")
    print_version()


def print_header(msg):
    line = '=' * (len(msg) + 2)
    print(f'\n{line}')
    print(f' {msg} ')
    print(f'{line}')


def print_version():
    print(sys.version)


if __name__ == '__main__':
    main()
