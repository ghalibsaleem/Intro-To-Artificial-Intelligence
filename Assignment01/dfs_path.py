from datahandler import getobjdata, DataClass
from helper import find_distance, print_stack_paths

objdata = None
shortest_path = [0, -1, 0, 0]


def get_shortest_path(start, end):
    global shortest_path
    find_all_path(start, end, 0)
    return shortest_path


def find_all_path(start, end, dist):
    global objdata
    global shortest_path
    ret_value = -1
    if start == end:
        if shortest_path[1] == -1 or shortest_path[1] > dist:
            shortest_path[1] = dist
        shortest_path[3] += 1
        print("\n\nNew Path Found")
        return 2
    if objdata is None:
        objdata = getobjdata()
    tempindex = objdata.nodeNameList.index(start)
    objdata.node_list[tempindex].isblocked = True
    objdata.node_list[tempindex].dist = dist
    objdata.graphStack.append(objdata.node_list[tempindex])
    if dist == 0:
        shortest_path[0] = tempindex
    temps = objdata.graph[tempindex]
    allindexes = [idx for idx, x in enumerate(temps) if x == 1]    # Finding all indexes
    for item in allindexes:
        if not objdata.node_list[item].isblocked:
            temp_dist = find_distance(objdata.node_list[tempindex], objdata.node_list[item])
            dist += temp_dist
            # print(objdata.nodeNameList[shortest_path[0]] + "---->" + objdata.nodeNameList[item] + " : " + str(dist))
            ret_value = find_all_path(objdata.nodeNameList[item], end, dist)
            if ret_value == 2:
                print_stack_paths(objdata.graphStack, objdata.nodeNameList[shortest_path[0]])
                print(objdata.nodeNameList[shortest_path[0]] + "---->" + objdata.nodeNameList[item] + " : " + str(dist))
            else:
                ret_value = -1
            dist -= temp_dist
    objdata.node_list[tempindex].isblocked = False
    objdata.graphStack.pop()
    return -1
