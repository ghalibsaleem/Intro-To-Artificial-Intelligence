import traceback
import sys
from data_handler import init_data, read_from_file
from dfs_path import get_shortest_path


def main(arguments):
    try:
        init_data()
        if len(arguments) < 3:
            raise Exception("Locations and Connections file paths are " +
                            "required as input")
        locations_file = arguments[1]
        connections_file = arguments[2]
        start_node = input("Enter the start point of the graph: ")
        end_node = input("Enter the end point of the graph: ")
        number_of_paths = input("Enter number of path you want to see: ")
        if not number_of_paths:
            number_of_paths = 1
        else:
            number_of_paths = int(number_of_paths)
        ret_value = read_from_file(start_node, end_node, locations_file,
                                  connections_file)
        if ret_value < 0:
            raise Exception("Something blew up while reading the input files.")
        shortest_path = get_shortest_path(start_node, end_node, number_of_paths)
        print("The Shortest Path among the displayed paths from " +
              start_node + " ------> " + end_node + " : " +
              str(shortest_path[2]))
        print("The overall Shortest Path from " + start_node + " ------> " +
              end_node + " : " + str(shortest_path[1]))
    except Exception as e:
        traceback.print_exc()
        raise Exception("Something went wrong. " + str(e))


if __name__ == "__main__":
    main(sys.argv)
