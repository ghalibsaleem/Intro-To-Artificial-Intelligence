import math


def find_all_indexes(objlist, item):
    indexlist = []
    try:
        print("")
    except ValueError as e:
        print("")
    print("")


def find_distance(start, end):
    return math.sqrt((start.x - end.x) * (start.x - end.x) + (start.y - end.y) * (start.y - end.y))


def print_stack_paths(obj_stack, start):
    for item in obj_stack:
        if item.name != start:
            print(start + " -----> " + item.name + " : " + str(item.dist))
    return


