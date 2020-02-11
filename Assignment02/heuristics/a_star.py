from data_handler import get_obj_data

__obj_data__ = None


def calculate_estimate(heuristics_no):
    print("")



def calculate_node_dist(heuristics_no, index):
    print("")
    return 0


def update_node_dist(heuristics_no, index):
    print("")


def a_star(heuristics_no, start_node, end_node):
    global __obj_data__
    if __obj_data__ is None:
        __obj_data__ = get_obj_data()
    temp_index = __obj_data__.node_name_list.index(start_node)
    calculate_estimate(heuristics_no)
    update_node_dist(heuristics_no, temp_index)
    __obj_data__.open_node_list.append([temp_index, __obj_data__.node_list[temp_index].total_dist])

    current_index = temp_index
    temp_index = __obj_data__.node_name_list.index(end_node)
    while len(__obj_data__.open_node_list) > 0:  # and current_index != temp_index:
        for item in __obj_data__.node_list[current_index].next:
            item_dist = calculate_node_dist(heuristics_no, item)
            has_item = False
            item_index = -1
            for index, dist in __obj_data__.open_node_list:
                item_index += 1
                if index == item:
                    has_item = True
                    break
            if has_item:
                if item_dist < __obj_data__.open_node_list[item_index][1]:
                    __obj_data__.node_list[item].parent = current_index
                    update_node_dist(heuristics_no, item)
                print("Its in open list")
            else:
                __obj_data__.open_node_list.append([item, item_dist])
                __obj_data__.node_list[item].parent = current_index
                update_node_dist(heuristics_no, item)
        print("While end")
        __obj_data__.open_node_list.sort(key=lambda x: x[1])
        current_index = __obj_data__.open_node_list[0]
    print("function end")
