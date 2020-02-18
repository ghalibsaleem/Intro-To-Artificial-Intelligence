### Programming Assignment 1 - Depth First Search ###

#### Contributors ####

1) Divyanshu Gupta : U21369422
2) Ghalib Saleem : U03151409

The purpose of this assignment is to traverse a graph using A-Star search using different type of heuristics and print out all the possible paths using same heuristics of A-Star.

User enters the starting node (from where the traversal will start), the ending node (where the traversing will end), whether step by step option enables or not, and heuristics.
After finding path program will ask to show graph or not 

```
Requirement: Python 3.7.5 or later 
```

#### Assignment Structure ####

```
Assignment01             // Root Folder
├── data_handler.py      // File that reads the input files
├── a_star.py          // File that performs actual A-Star
├── helper.py            // File containing helper functions 
├── input                // Folder containing input files
│   ├── connections.txt  // Connect of nodes in the graph
│   └── locations.txt    // x and y coordinates of each node
│── main.py              // Main File
└──README.md             // Read Me file
```

#### Input ####

The script takes in 2 files paths as input:

1) locations.txt
2) connections.txt

#### How to run the script ####

1) cd <PATH_TO_DOWNLOAD_FOLDER>/Assignment01
2) python3 main.py input/locations.txt input/connections.txt
3) When the script runs, its asks user few inputs:
   * First is the starting node for the graph traversal
   * Second is the ending node for the graph traversal
   * Third is the number of DFS paths that you want to see. If you do not enter this, then you will be shown one path which will be DFS path where DFS traversal was done based on the increasing order of alphanumeric strings.
```
NOTE: The two input files containing locations and connections are requied and scripts gices error if they are not provided.
```

#### Output ####

```
Enter the start point of the graph: A1
Enter the end point of the graph: D3
Enter Cities excluded (it should be comma separated eg. A1,A2): 
Do you want step by step solution (Yes or No): n
Enter Heuristics: 
1 for Straight line distance 
2 Fewest Cities
--> 1
A1 to B1 length 177.0
B1 to B2 length 112.99999999999994
B2 to C3 length 131.21737689803132
C3 to C4 length 155.72411502397426
C4 to D4 length 215.10230124292025
D4 to D3 length 138.0
A1 ---> B1 ---> B2 ---> C3 ---> C4 ---> D4 ---> D3
Total path length: 930.0437931649258
Do you want show graph? (Yes or No): y

```

* Line => Path1
  * Path number
* Line => A1 -----> A2 : 130.0
  * This means path from A1 to A2 is of distance 130.0
  * Similarly rest of the lines.
* Line => A1 ------ Overall -----> G5 : 3817.435623623003
  * This line says that the overall distance from node A1 to G5 is 3817.435623623003
* Line => Total number of paths found: 2486
  * This line says that to total number of found DFS paths from A1 to G5 are 2486.
* Line => The Shortest Path among the displayed paths from A1 ------> G5 : 3817.435623623003
  * This line says that from all the paths that are displayed, what is the distance of the shortest path among them.
* Line => The overall Shortest Path from A1 ------> G5 : 1217.320939639531
  * This line says that from all the "2486" DFS that were found, the shortest path among those paths has the distance of 1217.320939639531.