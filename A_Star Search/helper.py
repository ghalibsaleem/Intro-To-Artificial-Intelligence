import math


def find_distance(start_node, end_node):
    return math.sqrt(pow((start_node.x - end_node.x), 2) +
                     pow((start_node.y - end_node.y), 2))