from data_handler import get_obj_data
from helper import find_distance, print_stack_paths

__obj_data__ = None
__shortest_path__ = [0, -1, 0, 0]
__number_of_paths_to_print__ = 1
__total_paths__ = 0


def get_shortest_path(start_node, end_node, number_of_paths):
    try:
        global __shortest_path__
        global __number_of_paths_to_print__
        if number_of_paths > 1:
            __number_of_paths_to_print__ = number_of_paths
        find_all_path(start_node, end_node, 0)
        print("\nTotal number of paths found: " + str(__total_paths__))
        return __shortest_path__
    except Exception as e:
        raise Exception("Something went wrong.")


def find_all_path(start_node, end_node, dist):
    try:
        global __obj_data__
        global __shortest_path__
        global __total_paths__
        global __number_of_paths_to_print__
        ret_value = -1
        # if __number_of_paths_to_print__ <= 0:
        #     return -1

        if __obj_data__ is None:
            __obj_data__ = get_obj_data()
        temp_index = __obj_data__.node_name_list.index(start_node)
        __obj_data__.node_list[temp_index].is_blocked = True
        # __obj_data__.node_list[temp_index].dist = dist
        __obj_data__.graph_stack.append(__obj_data__.node_list[temp_index])
        if start_node == end_node:
            if __shortest_path__[1] == -1 or __shortest_path__[1] > dist:
                __shortest_path__[1] = dist
            __shortest_path__[3] += 1
            __number_of_paths_to_print__ -= 1
            __total_paths__ += 1
            return 2
        if dist == 0:
            __shortest_path__[0] = temp_index
        temps = __obj_data__.graph[temp_index]
        all_indexes = [idx for idx, x in enumerate(temps) if x == 1]
        for item in all_indexes:
            if not __obj_data__.node_list[item].is_blocked:
                temp_dist = find_distance(__obj_data__.node_list[temp_index],
                                          __obj_data__.node_list[item])
                dist += temp_dist
                __obj_data__.node_list[item].dist = temp_dist
                ret_value = find_all_path(__obj_data__.node_name_list[item],
                                          end_node, dist)
                if ret_value == 2 and __number_of_paths_to_print__ >= 0:
                    print("\nPath " + str(__total_paths__))
                    print_stack_paths(
                        __obj_data__.graph_stack,
                        __obj_data__.node_name_list[__shortest_path__[0]]
                    )
                    print(__obj_data__.node_name_list[__shortest_path__[0]] +
                          " ------ Overall -----> " + __obj_data__.node_name_list[item] + " : " +
                          str(dist))
                    if __shortest_path__[2] == 0 or \
                            __shortest_path__[1] < __shortest_path__[2]:
                        __shortest_path__[2] = __shortest_path__[1]
                if ret_value == 2:
                    __obj_data__.node_list[item].is_blocked = False
                    __obj_data__.graph_stack.pop()
                dist -= temp_dist
        __obj_data__.node_list[temp_index].is_blocked = False
        __obj_data__.graph_stack.pop()
        return -1
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
