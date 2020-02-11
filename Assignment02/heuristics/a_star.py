from data_handler import get_obj_data
from helper import find_distance

__obj_data__ = None


def calculate_straight_line_distance(end_node):
    try:
        global __obj_data__
        end_node_details = None
        for each_node in __obj_data__.node_list:
            if each_node.name == end_node:
                end_node_details = each_node
                break
        for each_node in __obj_data__.node_list:
            each_node.estimate = find_distance(each_node, end_node_details)
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))


def calculate_estimate(heuristics_no, end_node):
    try:
        global __obj_data__
        if heuristics_no == 1:
            calculate_straight_line_distance(end_node)
        else:
            print("")
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))


def calculate_current_and_total_and_distance(index):
    dist = 0
    try:
        global __obj_data__
        current_node = __obj_data__.node_list[index]
        dist = __obj_data__.node_list[current_node.parent].curr_dist + \
               find_distance(__obj_data__.node_list[current_node.parent],
                             current_node) + \
               current_node.estimate
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
    return dist


def calculate_node_dist(heuristics_no, index):
    dist = 0
    try:
        global __obj_data__
        if heuristics_no == 1:
            dist = calculate_current_and_total_and_distance(index)
        else:
            print("")
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
    return dist


def update_node_dist(heuristics_no, index):
    try:
        global __obj_data__
        if heuristics_no == 1:
            dist = calculate_current_and_total_and_distance(index)
            __obj_data__.node_list[index].total_dist = dist
            __obj_data__.node_list[index].curr_dist = \
                dist - __obj_data__.node_list[index].estimate
        else:
            print("")
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))


def a_star(heuristics_no, start_node, end_node):
    global __obj_data__
    if __obj_data__ is None:
        __obj_data__ = get_obj_data()
    temp_index = __obj_data__.node_name_list.index(start_node)
    calculate_estimate(heuristics_no)
    update_node_dist(heuristics_no, temp_index)
    __obj_data__.open_node_list.append(
        [temp_index, __obj_data__.node_list[temp_index].total_dist]
    )

    current_index = temp_index
    temp_index = __obj_data__.node_name_list.index(end_node)
    # and current_index != temp_index:
    while len(__obj_data__.open_node_list) > 0:
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
