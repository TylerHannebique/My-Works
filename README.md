**Hello Employers!**

I have created this repository one to share some of the code that I have written in recent years, most of which is game related stuff because that's really all I code in my free time. Below I briefly discuss each of the folders in the repository.


**Bygone**

Bygone is the game that I am currently working on alongside a small team of 6 people. It is an isometric, pixel art RPG. I am one of two programmers working on it. In the folder, I put a few of the objects that I myself coded. 
Most of the interesting stuff will be in the Create, Step, and Draw files

* oBattle is the object that controls everything to do with the player being engaged in the games turn based battle systems.
* oCameraManager controlls the camera movements in the game
* oCuttingGame is for rhythm based minigame involving cutting carrots. It is my first attempt at creating a rhythm game.
* oDayNightManager controls the the ingame time and draws a fiter over the game depending on the time of day

If you'd be interested in an actual explination or in-game footage I'd be glad to provide.


**sort_functions.cpp.txt**

These are a few sorting related algorithms I wrote in c++ for a report. Unfortunately I don't have access to the full source code, only the functions themselves. So I copypasted them into a text file.

* insertion_sort: takes in an unsorted sequence given in [first, last) and sorts them using insertion sort approach.
* merge: takes in two sorted sequences [first, mid) and [mid, last) and merges them into a single sequence contained in [first, last).
* merge_k: takes in ⌈n/k⌉ sorted sequences defined in [first, last) and merges them into a single sequence contained in
[first, last). Here the input k is the size of each sub-sequence excluding the last which might be smaller
than k
* merge_sort: unlike the the traditional merge sort, divides the sequence into subsequences of size k (a user-defined parameter), sorts each subsequence [n/k] using insertion sort, and recusrively merges the sorted [n/k] subsequences into a single sorted sequence

Very detailed descriptions of how each function works are provided in the file
