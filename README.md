**Hello, Welcome to my repository!**

I have created this repository one to share some of the code that I have written in recent years. Below I briefly discuss each of the folders/files in the repository.

**inPlaceSorts.cpp**

A few in place sorting algorithms I wrote for a CS assignment. Nothing much to say about them

*ZeroOneSort: sorts an array of randomized 0s and 1s without allocating any more memory space than that of the starting array

*ZeroOneTwoSort: sorts an array of randomized 0s, 1s, and 2s without allocating any more memory space than that of the starting array

**sortFunctions.cpp**

These are a few sorting related algorithms I wrote in c++ for a report. Unfortunately I don't have access to the full source code, only the functions themselves, so I copypasted them into a cpp file from my report.

* insertion_sort: takes in an unsorted sequence given in [first, last) and sorts them using insertion sort approach.
* merge: takes in two sorted sequences [first, mid) and [mid, last) and merges them into a single sequence contained in [first, last).
* merge_k: takes in ⌈n/k⌉ sorted sequences defined in [first, last) and merges them into a single sequence contained in
[first, last). Here the input k is the size of each sub-sequence excluding the last which might be smaller
than k
* merge_sort: unlike the the traditional merge sort, divides the sequence into subsequences of size k (a user-defined parameter), sorts each subsequence [n/k] using insertion sort, and recusrively merges the sorted [n/k] subsequences into a single sorted sequence

Very detailed descriptions of how each function works are provided in the file



If you're curious about the game mentioned in my resume. Its called One Night at Barneys 3 on Steam and it took my buddy and I 9 months to develop
