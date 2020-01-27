from data_handler import init_data, read_from_file
from dfs_path import get_shortest_path

import traceback

def main():
    try:
        init_data()
        start_limit = input("Enter the start point of the graph: ")
        end_limit = input("Enter the end point of the graph: ")
        ret_value = read_from_file(start_limit, end_limit)
        if ret_value < 0:
            raise Exception("Something blew up while reading the input files.")
        short_path = get_shortest_path(start_limit, end_limit)
        print("The Shortest Path from " + start_limit + " ------> " + end_limit + " : " + str(short_path[1]))
    except Exception as e:
        traceback.print_exc()
        raise Exception("Something went wrong. " + str(e))

if __name__ == "__main__":
    main()