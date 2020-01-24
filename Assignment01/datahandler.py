from collections import deque


class DataClass:
    def __init__(self):
        self.nodeList = []
        self.nodeNameList = []
        self.graphStack = deque()
        self.graph = [[0 for i in range(len(self.nodeList))] for j in range(len(self.nodeList))]


def getobjdata():
    global objData
    return objData


def initdata():
    global objData
    objData = DataClass()


class Nodes:
    def __init__(self, name, x, y):
        self.x = x
        self.y = y
        self.name = name
    isBlocked = False


def readfromfile(start, end):
    global objData
    nodefile = open("input/locations.txt")
    for line in nodefile:
        nodedata = line.split()
        if len(nodedata) > 1:
            objData.nodeList.append(Nodes(nodedata[0], int(nodedata[1]), int(nodedata[2])))
    nodefile.close()
    objData.nodeList.sort(key=lambda x: x.name, reverse=False)
    objData.nodeNameList = [tempnode.name for tempnode in objData.nodeList]
    if objData.nodeNameList.index(start) < 0:
        print("There is no start node in the graph")
        return -1
    if objData.nodeNameList.index(end) < 0:
        print("There is no end node in the graph")
        return -1
    objData.graph = [[0 for i in range(len(objData.nodeList))] for j in range(len(objData.nodeList))]
    nodefile = open("input/connections.txt")
    for line in nodefile:
        nodedata = line.split()
        if len(nodedata) > 1:
            columns = objData.nodeNameList.index(nodedata[0])
            count = int(nodedata[1])
            for x in range(0, count):
                row = objData.nodeNameList.index(nodedata[2 + x])
                objData.graph[columns][row] = 1
    nodefile.close()
    return 1


