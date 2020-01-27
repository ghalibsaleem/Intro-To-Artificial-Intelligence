import math


def find_distance(start_limit, end_limit):
    return math.sqrt(pow((start_limit.x - end_limit.x), 2) + pow((start_limit.y - end_limit.y), 2))


def print_stack_paths(obj_stack, start_limit):
    for item in obj_stack:
        if item.name != start_limit:
            print(start_limit + " -----> " + item.name + " : " + str(item.dist))
    return


