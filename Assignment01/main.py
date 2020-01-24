from datahandler import initdata, readfromfile
from dfs_path import findallpath


def main():
    initdata()
    start = input("Enter the start point of the graph")
    end = input("Enter the end point of the graph")
    print("main method")
    retvalue = readfromfile(start, end)
    if retvalue < 0:
        return -1
    findallpath(start, end)


if __name__ == "__main__":
    main()
