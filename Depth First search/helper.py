import math


def find_distance(start_node, end_node):
    return math.sqrt(pow((start_node.x - end_node.x), 2) +
                     pow((start_node.y - end_node.y), 2))


def print_stack_paths(obj_stack, start_node):
    prev_node = start_node
    for item in obj_stack:
        if item.name != start_node:
            print(prev_node + " -----> " + item.name + " : " + str(item.dist))
            prev_node = item.name
