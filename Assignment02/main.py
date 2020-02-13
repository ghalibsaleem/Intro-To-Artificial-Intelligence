import traceback
import sys
from data_handler import init_data, read_from_file
from heuristics.a_star import a_star


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
        cities_excluded = input("Enter Cities excluded (it should be comma separated eg. A1,A2)")
        step_flag = input("Do you want step by step solution (Yes or No) :")
        number_of_paths = input("Enter Heuristics: \n1 for Straight line distance \n2 Fewest Cities\n-->")

        cities_excluded = cities_excluded.split(",")

        if not number_of_paths:
            number_of_paths = 1
        else:
            number_of_paths = int(number_of_paths)
        if step_flag == "Yes" or step_flag == "yes" or step_flag == "Y" or step_flag == "y":
            step_flag = True
        else:
            step_flag = False
        ret_value = read_from_file(start_node, end_node, locations_file,
                                  connections_file)
        if ret_value < 0:
            raise Exception("Something blew up while reading the input files.")

        a_star(number_of_paths, start_node, end_node, step_flag, cities_excluded)

        # shortest_path = get_shortest_path(start_node, end_node, number_of_paths)
        # print("The Shortest Path among the displayed paths from " +
        #       start_node + " ------> " + end_node + " : " +
        #       str(shortest_path[2]))
        # print("The overall Shortest Path from " + start_node + " ------> " +
        #       end_node + " : " + str(shortest_path[1]))
    except Exception as e:
        traceback.print_exc()
        raise Exception("Something went wrong. " + str(e))


if __name__ == "__main__":
    main(sys.argv)
