from datahandler import initdata, readfromfile
from dfs_path import get_shortest_path


def main():
    initdata()
    start = input("Enter the start point of the graph: ")
    end = input("Enter the end point of the graph: ")
    print("main method")
    retvalue = readfromfile(start, end)
    if retvalue < 0:
        return -1
    short_path = get_shortest_path(start, end)

    print("The Shortest Path from " + start + " ------> " + end + " : " + str(short_path[1]))


if __name__ == "__main__":
    main()
