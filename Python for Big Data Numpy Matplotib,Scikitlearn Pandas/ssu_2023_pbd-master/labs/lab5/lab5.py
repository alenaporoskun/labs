#!/usr/bin/env python3
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def main():
    print_header("Check version")
    print_version()

    print_header("NumPy: the absolute basics for beginners")

    print_header("How to create a basic array")
    print("np.array([1, 2, 3]):\n", np.array([1, 2, 3]))
    print("np.zeros(2):\n", np.zeros(2))
    print("np.ones(2):\n", np.ones(2))
    print("np.empty(4):\n", np.empty(4))
    print("np.arange(5):\n", np.arange(5))
    print("np.arange(2, 12, 2):\n", np.arange(2, 12, 2))
    print("np.linspace(0, 12, num=5):\n", np.linspace(0, 12, num=5))
    print("np.ones(2, dtype=np.int64):\n", np.ones(2, dtype=np.int64))

    print_header("Adding, removing, and sorting elements")
    arr = np.array([2, 1, 5, 3, 7, 4, 6, 8])
    print("arr\n", arr)
    print("np.sort(arr):\n", np.sort(arr), "\n")
    a = np.array([1, 2, 3, 4])
    b = np.array([5, 6, 7, 8])
    print(" a ", a, "\n", "b ", b)
    print("np.concatenate((a, b)):\n", np.concatenate((a, b)))

    print_header("How do you know the shape and size of an array?")
    array_example = np.array([[[0, 1, 2, 3],
                               [4, 5, 6, 7]],
                              [[10, 20, 30, 40],
                               [11, 21, 31, 41]],
                              [[100, 110, 120, 130],
                               [40, 50, 60, 70]]])
    print("array_example:\n", array_example, "\n")
    print("array_example.ndim:\n", array_example.ndim)
    print("array_example.size:\n", array_example.size)
    print("array_example.shape:\n", array_example.shape)

    print_header("Can you reshape an array?")
    a = np.arange(6)
    print("a ", a)
    print("a.reshape(3, 2):\n", a.reshape(3, 2))

    print_header("How to convert a 1D array into a 2D array (how to add a new axis to an array)")
    a = np.array([1, 2, 3, 4, 5, 6])
    a.shape
    row_vector = a[np.newaxis, :]
    row_vector.shape
    col_vector = a[:, np.newaxis]
    col_vector.shape
    print("a:", a, "\n", "a.shape:", a.shape)
    print("row_vector = a[np.newaxis, :] \nrow_vector.shape:", row_vector.shape)
    print("col_vector = a[:, np.newaxis] \ncol_vector.shape:", col_vector.shape)

    print_header("Indexing and slicing")

    data = np.array([1, 2, 3, 4, 5])
    print("data:      ", data)
    print("data[0:2]: ", data[0:2])
    print("data[1:]:  ", data[1:])
    print("data[-2:]: ", data[-2:])
    print("data[::-1]:", data[::-1], "\n")

    a = np.array([[0, -1, -2, -3], [1, 2, 3, 4], [5, 8, 11, 14]])
    print("a:\n", a)
    print("a[a < 5]:\n", a[a < 5])
    five_up = (a >= 5)
    print("five_up = (a >= 5),  a[five_up]:\n", a[five_up])
    print("a[(a > 2) & (a < 11)]:\n", a[(a > 2) & (a < 11)])

    print("a:\n", a)
    b = np.nonzero(a < 3)
    # In this example, a tuple of arrays was returned: one for each dimension.
    print("b=np.nonzero(a < 3):\n", b)
    print("(row indices, column indices)")
    print("list(zip(b[0], b[1])):\n", list(zip(b[0], b[1])))
    #list_of_coordinates = list(zip(b[0], b[1]))
    #for coord in list_of_coordinates:
    #    print(coord)

    print_header("How to create an array from existing data")
    a1 = np.array([[1, 1],
                   [2, 2]])

    a2 = np.array([[3, 3],
                   [4, 4]])
    print("a1:\n", a1, "\n", "a2:\n", a2)
    print("np.vstack((a1, a2)):\n", np.vstack((a1, a2)))
    print("np.hstack((a1, a2)):\n", np.hstack((a1, a2)))
    print("np.arange(1, 25).reshape(2, 12):\n", np.arange(1, 25).reshape(2, 12), "\n")

    a = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
    print("a:\n", a)
    b1 = a[0, :]
    print("b1 = a[0, :]:\n", b1)
    b2 = a.copy()
    print("b2 = a.copy():\n", b2)
    b1[0] = 99
    print("b1[0]=99:\n", b1[0])
    print("a:\n", a)
    print("b2:\n", b2)

    print_header("Basic array operations and Broadcasting")
    data = np.array([1, 2, 3])
    ones = np.ones(3, dtype=int)
    print("data: ", data)
    print("ones: ", ones)
    print("data + ones: ", data + ones)
    print("data - ones: ", data - ones)
    print("data.sum(): ", data.sum())
    print("data * 1.6: ", data * 1.6)
    print("data.min(): ", data.min())

    print_header("Creating matrices")
    print("np.zeros(3):\n", np.zeros(3))
    print("np.ones((3, 2)):\n", np.ones((3, 2)))
    print("np.ones((2, 3, 4)):\n", np.ones((2, 3, 4)))

    print_header("Generating random numbers")
    rng = np.random.default_rng()
    print("rng = np.random.default_rng()")
    print("rng.random(3):\n", rng.random(3))
    print("rng.integers(5, size=(2, 4)):\n", rng.integers(5, size=(2, 4)))

    print_header("Transposing and reshaping a matrix")
    data_new = np.array([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    print("data_new:\n", data_new)
    print("data_new.reshape(1, 9):\n", data_new.reshape(1, 9))
    print("data_new.transpose():\n", data_new.transpose())

    print_header("How to reverse an array")

    arr = np.array([1, 2, 3, 4, 5, 6, 7, 8])
    print("arr:\n", arr)
    print("np.flip(arr):\n", np.flip(arr), "\n")

    arr_2d = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
    print("arr_2d:\n", arr_2d)
    print("np.flip(arr_2d):\n", np.flip(arr_2d))

    print_header("How to access the docstring for more information")
    print("help(max):\n")
    help(max)
    # max? - not work
    # arr? - not work

    # def fun_double(a):
    #     '''Return a * 2'''
    #     return a * 2
    # help(fun_double(a))
    # fun_double? or ??

    print_header("How to save and load NumPy objects")
    a = np.array([1, 2, 3, 4, 5, 6])
    print("a:\n", a)
    np.save('filename1', a)
    print("np.save(\'filename1\', a)")
    b = np.load('filename1.npy')
    print("b = np.load('filename.npy'):\n", b, "\n")

    np.savetxt('new_file_csv.csv', a)
    print("np.savetxt('new_file_csv.csv', a)")
    c = np.loadtxt('new_file_csv.csv')
    print("c = np.loadtxt('new_file_csv.csv'):\n", c)


    print_header("Importing and exporting a CSV")
    # import pandas as pd
    arr_art = np.array([["Billie Holiday", 'Jazz', 1300000, 27000000],
                        ["Jimmie Hendrix", 'Rock', 2700000, 70000000],
                        ["SIA", "Pop", 2000000, 74000000]])
    df = pd.DataFrame(arr_art, columns=["Artist",  "Genre",  "Listeners",  "Plays"])
    print("df:\n", df, "\n")
    print("df.loc[2]:\n", df.loc[2], "\n")

    data = {
        "calories": [420, 380, 390],
        "duration": [50, 40, 45]
    }
    df2 = pd.DataFrame(data, index=["day1", "day2", "day3"])
    print("df2:\n", df2, "\n")
    print("df2.loc[\"day2\"]:\n", df2.loc["day2"], "\n")

    df2.to_csv('pd_csv.csv')
    print("df2.to_csv('pd_csv.csv')")
    data_new = pd.read_csv('pd_csv.csv')
    print("data_new = pd.read_csv('pd_csv.csv'):\n", data_new)

    print_header("Plotting arrays with Matplotlib")
    # import matplotlib.pyplot as plt
    x = np.linspace(0, 5, 20)
    y = np.linspace(0, 10, 20)
    print("x:\n", x)
    print("y:\n", y)

    plt.plot(x, y, 'purple')  # line
    plt.plot(x, y, 'o')  # dots


def print_version():
    print(sys.version)

def print_header(msg):
    line = '=' * (len(msg) + 2)
    print(f'\n{line}')
    print(f' {msg} ')
    print(f'{line}')

if __name__ == '__main__':
    main()
