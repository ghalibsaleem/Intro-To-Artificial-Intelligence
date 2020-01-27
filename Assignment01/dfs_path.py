from data_handler import get_obj_data, DataClass
from helper import find_distance, print_stack_paths


obj_data = None
shortest_path = [0, -1, 0, 0]


def get_shortest_path(start_limit, end_limit):
    try:
        global shortest_path
        find_all_path(start_limit, end_limit, 0)
        return shortest_path
    except Exception as e:
        raise Exception("Something went wrong.")


def find_all_path(start_limit, end_limit, dist):
    try:
        global obj_data
        global shortest_path
        ret_value = -1
        if start_limit == end_limit:
            if shortest_path[1] == -1 or shortest_path[1] > dist:
                shortest_path[1] = dist
            shortest_path[3] += 1
            print("\nNew Path Found")
            return 2
        if obj_data is None:
            obj_data = get_obj_data()
        temp_index = obj_data.node_name_list.index(start_limit)
        obj_data.node_list[temp_index].is_blocked = True
        obj_data.node_list[temp_index].dist = dist
        obj_data.graph_stack.append(obj_data.node_list[temp_index])
        if dist == 0:
            shortest_path[0] = temp_index
        temps = obj_data.graph[temp_index]
        # Finding all indexes
        all_indexes = [idx for idx, x in enumerate(temps) if x == 1]
        for item in all_indexes:
            if not obj_data.node_list[item].is_blocked:
                temp_dist = find_distance(obj_data.node_list[temp_index], obj_data.node_list[item])
                dist += temp_dist
                # print(obj_data.node_name_list[shortest_path[0]] + "---->" + obj_data.node_name_list[item] + " : " + str(dist))
                ret_value = find_all_path(obj_data.node_name_list[item], end_limit, dist)
                if ret_value == 2:
                    print_stack_paths(obj_data.graph_stack, obj_data.node_name_list[shortest_path[0]])
                    print(obj_data.node_name_list[shortest_path[0]] + "---->" + obj_data.node_name_list[item] + " : " + str(dist))
                else:
                    ret_value = -1
                dist -= temp_dist
        obj_data.node_list[temp_index].is_blocked = False
        obj_data.graph_stack.pop()
        return -1
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
