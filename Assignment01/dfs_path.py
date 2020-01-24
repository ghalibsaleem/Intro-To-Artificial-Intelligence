from datahandler import getobjdata, DataClass


def findallpath(start, end):
    objdata = getobjdata()
    tempindex = objdata.nodeNameList.index(start)
    objdata.nodeList[tempindex].isBlocked = True
    objdata.graphStack.append(objdata.nodeList[tempindex])
