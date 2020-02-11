from collections import deque

__obj_data__ = None


class DataClass:
    def __init__(self):
        self.node_list = []
        self.node_name_list = []
        self.graph = \
            [[0 for i in range(len(self.node_list))]
             for j in range(len(self.node_list))]
        self.open_node_list = []


def get_obj_data():
    global __obj_data__
    if __obj_data__ is None:
        return DataClass()
    return __obj_data__


def init_data():
    global __obj_data__
    __obj_data__ = DataClass()


class Nodes:
    def __init__(self, name, x, y):
        self.x = x
        self.y = y
        self.name = name
        self.is_blocked = False
        self.next = []
        self.parent = None
        self.curr_dist = -1
        self.estimate = -1
        self.total_dist = -1


def read_from_file(start_node, end_node, locations_file, connections_file):
    try:
        global __obj_data__
        node_file = open(locations_file)
        for line in node_file:
            node_data = line.split()
            if len(node_data) > 1:
                __obj_data__.node_list.append(
                    Nodes(node_data[0], int(node_data[1]), int(node_data[2]))
                )
        node_file.close()
        __obj_data__.node_list.sort(key=lambda each_node: each_node.name)
        __obj_data__.node_name_list = \
            [temp_node.name for temp_node in __obj_data__.node_list]
        if __obj_data__.node_name_list.index(start_node) < 0:
            raise Exception("There is no start node in the graph")
        if __obj_data__.node_name_list.index(end_node) < 0:
            raise Exception("There is no end node in the graph")
        __obj_data__.graph = [[0 for i in range(len(__obj_data__.node_list))]
                              for j in range(len(__obj_data__.node_list))]
        node_file = open(connections_file)
        for line in node_file:
            node_data = line.split()
            if len(node_data) > 1:
                columns = __obj_data__.node_name_list.index(node_data[0])
                count = int(node_data[1])
                for x in range(0, count):
                    row = __obj_data__.node_name_list.index(node_data[2 + x])
                    __obj_data__.graph[columns][row] = 1
                    __obj_data__.node_list[columns].next.append(row)
        node_file.close()
        return 1
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))
