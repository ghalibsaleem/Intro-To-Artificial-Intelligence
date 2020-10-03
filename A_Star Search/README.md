### Depth First Search ###

#### Contributors ####

1) Divyanshu Gupta : U21369422
2) Ghalib Saleem : U03151409

The purpose of this project is to traverse a graph using A-Star search using different type of heuristics and print out all the possible paths using same heuristics of A-Star.

User enters the starting node (from where the traversal will start), the ending node (where the traversing will end), whether step by step option enables or not, and heuristics.
After finding path program will ask to show graph or not 

```
Requirement: Python 3.7.5 or later 
```

#### Libraries for graph and visualisation generation

```
pip3 install networkx[all]
```
* Incase, there is any error, just make sure that you have matplotlib module

```
pip3 install matplotlib
```

#### Assignment Structure ####

```
Assignment02             // Root Folder
├── data_handler.py      // File that reads the input files
├── heuristics           // Folder contatining the main a-star code
|   └── a_star.py        // File that performs actual A-Star
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

1) cd <PATH_TO_DOWNLOAD_FOLDER>/Assignment02
2) python3 main.py input/locations.txt input/connections.txt
3) When the script runs, its asks user few inputs:
   * First is the starting node for the graph traversal
   * Second is the ending node for the graph traversal
   * Third is the comma separated list of cities to be excluded. Leave it blank if you don't want to exclude any cities
   * If you want step by step solution.
   * The heuristic around which the path would be generated.
```
NOTE: 
  * After the answer is displayed, you will be prompted to see the graph visualisation. Enter the response accordingly.
  * The two input files containing locations and connections are requied and scripts gives error if they are not provided.
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

* First 8 lines are the user prompts and inputs
* Next 6 lines are the node by node traversal and their length
* Then the next line displays the whole path of traversal
* And the line after this displays the total path length
* The last line is user prompt, where user enters yes or no to see the graph visualisation
