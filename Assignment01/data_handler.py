from collections import deque


obj_data = None


class DataClass:
    def __init__(self):
        self.node_list = []
        self.node_name_list = []
        self.graph_stack = deque()
        self.graph = [[0 for i in range(len(self.node_list))] for j in range(len(self.node_list))]


def get_obj_data():
    global obj_data
    if obj_data is None:
        return DataClass()
    return obj_data


def init_data():
    global obj_data
    obj_data = DataClass()


class Nodes:
    def __init__(self, name, x, y):
        self.x = x
        self.y = y
        self.name = name
    is_blocked = False


def read_from_file(start_limit, end_limit):
    try:
        global obj_data
        node_file = open("input/locations.txt")
        for line in node_file:
            node_data = line.split()
            if len(node_data) > 1:
                obj_data.node_list.append(Nodes(node_data[0], int(node_data[1]), int(node_data[2])))
        node_file.close()
        obj_data.node_list.sort(key = lambda each_node: each_node.name)
        obj_data.node_name_list = [temp_node.name for temp_node in obj_data.node_list]
        if obj_data.node_name_list.index(start_limit) < 0:
            raise Exception("There is no start_limit node in the graph")
        if obj_data.node_name_list.index(end_limit) < 0:
            raise Exception("There is no end_limit node in the graph")
        obj_data.graph = [[0 for i in range(len(obj_data.node_list))] for j in range(len(obj_data.node_list))]
        node_file = open("input/connections.txt")
        for line in node_file:
            node_data = line.split()
            if len(node_data) > 1:
                columns = obj_data.node_name_list.index(node_data[0])
                count = int(node_data[1])
                for x in range(0, count):
                    row = obj_data.node_name_list.index(node_data[2 + x])
                    obj_data.graph[columns][row] = 1
        node_file.close()
        return 1
    except Exception as e:
        raise Exception("Something went wrong. " + str(e))