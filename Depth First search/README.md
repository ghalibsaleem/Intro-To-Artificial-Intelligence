### Depth First Search ###

#### Contributors ####

1) Divyanshu Gupta : U21369422
2) Ghalib Saleem : U03151409

The purpose of this project is to traverse a graph using Depth First search and print out all the possible paths using Depth First Search.

The very first path printed is the DFS path where DFS traversal was done based on the increasing order of alphanumeric strings.

User enters the starting node (from where the traversal will start) and the ending node (where the traversing will end) and the total number of DFS paths that the user wants to see (since there can be many different DFS paths in the graph).

```
Requirement: Python 3.7.5 or later 
```

#### Assignment Structure ####

```
Assignment01             // Root Folder
├── data_handler.py      // File that reads the input files
├── dfs_path.py          // File that performs actual DFS processing
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
Path 1
A1 -----> A2 : 130.0
A2 -----> A4 : 305.0
A4 -----> A5 : 90.0
A5 -----> C5 : 306.0
C5 -----> B5 : 229.16587878652442
B5 -----> B4 : 36.05551275463989
B4 -----> C4 : 96.0
C4 -----> C3 : 155.72411502397438
C3 -----> B2 : 131.21737689803132
B2 -----> B1 : 113.0
B1 -----> D1 : 231.0
D1 -----> D2 : 126.0
D2 -----> F2 : 162.00308639035245
F2 -----> E4 : 303.03300150313663
E4 -----> D4 : 137.01459776242822
D4 -----> D5 : 100.0
D5 -----> F5 : 263.0
F5 -----> E5 : 81.78630692236935
E5 -----> G4b : 140.41723540933285
G4b -----> G2b : 231.0
G2b -----> G2 : 27.018512172212592
G2 -----> G4 : 232.0
G4 -----> G5 : 191.0
A1 ------ Overall -----> G5 : 3817.435623623003

Total number of paths found: 2486
The Shortest Path among the displayed paths from A1 ------> G5 : 3817.435623623003
The overall Shortest Path from A1 ------> G5 : 1217.320939639531
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
