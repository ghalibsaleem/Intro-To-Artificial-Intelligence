from data_handler import get_obj_data, get_animation_obj
from helper import find_distance
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import networkx as nx

__obj_data__ = None
__shortest_dist__ = -1
__animation_graph__ = None
__end_node_index__ = 0


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
        elif heuristics_no == 2:
            for each_node in __obj_data__.node_list:
                if end_node == each_node.name:
                    each_node.estimate = 0
                else:
                    each_node.estimate = 1
        else:
            print("")
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))


def calculate_current_and_total_and_distance(index, parent_index):
    dist = 0
    try:
        global __obj_data__
        current_node = __obj_data__.node_list[index]
        dist = __obj_data__.node_list[parent_index].curr_dist + \
               find_distance(__obj_data__.node_list[parent_index],
                             current_node) + \
               current_node.estimate
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
    return dist


def calculate_node_dist(heuristics_no, index, parent_index):
    dist = 0
    try:
        global __obj_data__
        if heuristics_no == 1:
            if parent_index is not None:
                dist = calculate_current_and_total_and_distance(index, parent_index)
            else:
                dist = __obj_data__.node_list[index].estimate
        elif heuristics_no == 2:
            if parent_index is not None:
                dist = __obj_data__.node_list[parent_index].curr_dist + 2
            else:
                dist = 1
        else:
            print("")
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
    return dist


def update_node_dist(heuristics_no, index):
    try:
        global __obj_data__
        if heuristics_no == 1:
            dist = 0
            if __obj_data__.node_list[index].parent is not None:
                dist = calculate_current_and_total_and_distance(index, __obj_data__.node_list[index].parent)
            else:
                dist = __obj_data__.node_list[index].estimate
            __obj_data__.node_list[index].total_dist = dist
            __obj_data__.node_list[index].curr_dist = \
                dist - __obj_data__.node_list[index].estimate
        elif heuristics_no == 2:
            if __obj_data__.node_list[index].parent is not None:
                dist = __obj_data__.node_list[__obj_data__.node_list[index].parent].curr_dist + 1
            else:
                dist = 0
            __obj_data__.node_list[index].curr_dist = dist
            __obj_data__.node_list[index].total_dist = dist + 1
        else:
            print("")
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))


def check_in_same_path(curr_index, check_index):
    index = curr_index
    while __obj_data__.node_list[index].parent is not None:
        if __obj_data__.node_list[index].parent == check_index:
            return True
        index = __obj_data__.node_list[index].parent
    return False


def path_print(index, end_index):
    if index is not None:
        path_print(__obj_data__.node_list[index].parent, end_index)
        print(__obj_data__.node_list[index].name, end='')
        if index != end_index:
            print(" ---> ", end='')


def user_input_print(current_index):
    try:
        global __obj_data__
        print("Possible cities to where to travel from " + __obj_data__.node_name_list[current_index] + ": ", end='')
        for item in __obj_data__.node_list[current_index].next:
            if not check_in_same_path(current_index, item):
                print(__obj_data__.node_name_list[item] + " ", end='')
        print("")
        print("Cities at the end of possible paths: ", end='')
        for item in __obj_data__.open_node_list:
            print(__obj_data__.node_name_list[item[0]] + "(" + str(__obj_data__.node_list[item[0]].total_dist) + ") ",
                  end='')
        print("")
        print("*************************************************************************")
    except Exception as e:
        raise Exception("Something went wrong in user input print" + str(e))


def path_detailed_print(index, end_index):
    if index is not None:
        parent_index = __obj_data__.node_list[index].parent
        path_detailed_print(__obj_data__.node_list[index].parent, end_index)
        if parent_index is not None:
            length = __obj_data__.node_list[index].curr_dist - __obj_data__.node_list[parent_index].curr_dist
            print(__obj_data__.node_list[parent_index].name + " to " + __obj_data__.node_list[
                index].name + " length " + str(length))


def update_graph(frame_number):
    try:
        global __end_node_index__
        global __obj_data__
        final_path = []
        print("frame_number: " + str(frame_number))
        node_list = __obj_data__.graph_dt[frame_number]
        parent = node_list[0]
        current = node_list[1]
        no_of_neighbours = node_list[2]
        edge_list = []
        childs = [current]
        edge_labels = {}
        if no_of_neighbours > 0:
            childs.extend(node_list[3].split(" "))
            for i in range(0, len(childs)):
                edge_list.append((current, childs[i]))
                edge_dist = \
                    find_distance(
                        __obj_data__.node_list[
                            __obj_data__.node_name_list.index(current)
                        ],
                        __obj_data__.node_list[
                                __obj_data__.node_name_list.index(childs[i])
                        ]
                    )
                edge_labels.update({(current, childs[i]): round(edge_dist, 2)})

        nx.draw_networkx_nodes(
            __animation_graph__.graph_viz, __animation_graph__.pos,
            nodelist=childs, node_size=100, node_color='red', alpha=0.8
        )
        if parent == "":
            parent = current
        nx.draw_networkx_edges(
            __animation_graph__.graph_viz, __animation_graph__.pos,
            edgelist=[(parent, current)], width=3, edge_color='blue',
            alpha = 0.5
        )
        dist = \
            find_distance(
                __obj_data__.node_list[
                    __obj_data__.node_name_list.index(parent)
                ],
                __obj_data__.node_list[
                    __obj_data__.node_name_list.index(current)
                ]
            )
        nx.draw_networkx_edge_labels(
            __animation_graph__.graph_viz, __animation_graph__.pos,
            edge_labels={(parent, current): round(dist, 2)}, label_pos=0.5,
            font_size=5
        )
        nx.draw_networkx_edges(
            __animation_graph__.graph_viz, __animation_graph__.pos,
            edgelist=edge_list, width=2, edge_color='red', alpha=0.5,
            style="dashed"
        )
        nx.draw_networkx_edge_labels(
            __animation_graph__.graph_viz, __animation_graph__.pos,
            edge_labels=edge_labels, label_pos=0.5, font_size=5
        )
        if (len(__obj_data__.graph_dt) - 1) == frame_number:
            end_node = __obj_data__.node_list[__end_node_index__]
            while end_node.parent is not None:
                final_path.append((__obj_data__.node_list[end_node.parent].name,
                                   end_node.name))
                end_node = __obj_data__.node_list[end_node.parent]
            nx.draw_networkx_edges(
                __animation_graph__.graph_viz, __animation_graph__.pos,
                edgelist=final_path, width=5, edge_color='black', alpha=0.5
            )
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))


def a_star(heuristics_no, start_node, end_node, step_flag, cities_excluded):
    try:
        global __obj_data__
        global __shortest_dist__
        global __animation_graph__
        global __end_node_index__
        if start_node == end_node:
            print("Start City and End City is same")
            return
        if __animation_graph__ is None:
            __animation_graph__ = get_animation_obj()
        if __obj_data__ is None:
            __obj_data__ = get_obj_data()
        temp_index = __obj_data__.node_name_list.index(start_node)
        calculate_estimate(heuristics_no, end_node)
        update_node_dist(heuristics_no, temp_index)
        __obj_data__.open_node_list.append([temp_index, __obj_data__.node_list[temp_index].total_dist])

        current_index = temp_index
        temp_index = __obj_data__.node_name_list.index(end_node)
        __end_node_index__ = temp_index
        while len(__obj_data__.open_node_list) > 0:  # and current_index != temp_index:

            if len(__obj_data__.node_list[current_index].next) == 0:
                for open_node in __obj_data__.open_node_list:
                    if open_node[0] == current_index:
                        __obj_data__.open_node_list.remove(open_node)
                        break
            if temp_index == current_index:
                item_dist = __obj_data__.node_list[current_index].total_dist
                if __shortest_dist__ == -1 or __shortest_dist__ > item_dist:
                    __shortest_dist__ = item_dist
                    __obj_data__.open_node_list = [x for x in __obj_data__.open_node_list if x[1] < __shortest_dist__]
            child_names = ""
            for item in __obj_data__.node_list[current_index].next:
                if check_in_same_path(current_index, item) or cities_excluded.__contains__(
                        __obj_data__.node_name_list[item]):
                    continue

                item_dist = calculate_node_dist(heuristics_no, item, current_index)
                child_names = child_names + __obj_data__.node_name_list[item] + " "

                if __shortest_dist__ > 0:
                    __obj_data__.open_node_list = [x for x in __obj_data__.open_node_list if x[1] < __shortest_dist__]

                has_item = False
                item_index = -1
                for index, dist in __obj_data__.open_node_list:
                    item_index += 1
                    if index == item:
                        has_item = True
                        break

                if has_item:
                    if item_dist < __obj_data__.open_node_list[item_index][1]:
                        __obj_data__.open_node_list[item_index][1] = item_dist
                        __obj_data__.node_list[item].parent = current_index
                        update_node_dist(heuristics_no, item)
                else:
                    if (item_dist < __obj_data__.node_list[item].total_dist
                        or __obj_data__.node_list[item].total_dist == -1) and (
                            __shortest_dist__ == -1 or item_dist <= __shortest_dist__):
                        __obj_data__.open_node_list.append([item, item_dist])
                        __obj_data__.node_list[item].parent = current_index
                        update_node_dist(heuristics_no, item)

            for open_node in __obj_data__.open_node_list:
                if open_node[0] == current_index:
                    __obj_data__.open_node_list.remove(open_node)
                    break

            # Step by Step
            if step_flag:
                print("City selected: " + __obj_data__.node_name_list[current_index])
                user_input_print(current_index)

            if __obj_data__.node_list[current_index].parent is not None:
                __obj_data__.graph_dt.append([__obj_data__.node_name_list[__obj_data__.node_list[current_index].parent],
                                              __obj_data__.node_list[current_index].name,
                                              len(__obj_data__.node_list[current_index].next) - 1,
                                              child_names.rstrip()])
            else:
                __obj_data__.graph_dt.append(["",
                                              __obj_data__.node_list[current_index].name,
                                              len(__obj_data__.node_list[current_index].next) - 1,
                                              child_names.rstrip()])
            __obj_data__.open_node_list.sort(key=lambda x: x[1])
            if len(__obj_data__.open_node_list) > 0:
                current_index = __obj_data__.open_node_list[0][0]
        if __shortest_dist__ >= 0:
            path_detailed_print(temp_index, temp_index)
            path_print(temp_index, temp_index)
            print("\nTotal path length: " + str(__shortest_dist__))
        else:
            print("No path found")
        print("len(__obj_data__.graph_dt): " + str(len(__obj_data__.graph_dt)))
        anim = FuncAnimation(
                   plt.gcf(), update_graph, frames=len(__obj_data__.graph_dt),
                   interval=500, repeat=False
               )
        plt.show()
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
