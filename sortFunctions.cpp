**Insertion Sort Implementation**
template<typename RandomAccessIterator, typename Comparator>
void insertion_sort(RandomAccessIterator first, RandomAccessIterator last, Comparator comp){
    for(auto i = first; i != last; ++i){ //loop through length of array
        auto key = *i; //set key to the current array value at i
        auto j = i - 1;
        while(j >= first && comp(key, *j)){ //if the array at index j is less than the
            // key and j is not at the beginning of the array
            *(j + 1) = *j; //place the value of j on index to the right
            --j; //decrement j
        }
        *(j + 1) = key; //place the value of key in the array at index j + 1
    }
}
/*
Insertion Sort: The insertion sort starts with a for loop iterating through the length of the input sub-array using variable i. Inside the loop, a variable key is set to the value of the input array at index i and a
variable j is set to i - 1. Then a while loop is opened to continuously check if the key is less than the value to the left of it in the input array by comparing it with the value at j. If it is then the value of the
array at index j is shifted one to the right. The loop ends when the key is no longer less than the value at j or j has reached the beginning of the input array. After the loop ends, the value of the input array at index
j+1 is set to key. After the for loop has ended, the input array will have been sorted.
*/


**Merge Implementation**
void merge(RandomAccessIterator first, RandomAccessIterator mid, RandomAccessIterator last, Comparator comp){
    vector<typename RandomAccessIterator::value_type> out; //create temp array
    auto left = first; //place left iterator at first
    auto right = mid; //place right iterator at mid


    while(left != mid && right != last){ //left is not equal to mid and right is not equal to mid
        if(comp(*left, *right)){ //if the value at left is less than the value at right
            out.push_back(*left); //push the value at left to the output array
            ++left; //increment left
        }else{ //if the value at left is greater than the value at right
            out.push_back(*right); //push the value at right to the output array
            ++right; //increment right
        }
    }
/*
 * Merge: The merge function first creates a temporary vector called temp to store the merged values of two subsections. A variable left is set to first to be the initial value of the left subsection and another variable
right is set to mid to be the initial value of the right subsection. Next, a while loop is opened and will run until left has reached mid or right has reached last. Inside the loop, it is first checked if the current
value at left is less than the current value at right. If it is then it is pushed to temp and left is iterated by 1. Otherwise, the value at right is added to temp and right is iterated by 1. After the while loop closes,
either the left or the right subsection has all their values added to temp, so the remaining values of the other subsection need to be added. The following while loop runs while there are any remaining values in the left
subsection by checking if the left iterator is equal to mid. If this is true, then this conditional is skipped. Otherwise, the while loop will iterate over the remaining values of left and push them to temp. One this
loop closes the same check will be done on the right subsection. After these loops close, all of the values from both subsections of the input array will be properly sorted and merged inside temp. The last step is to
copy the values of temp back into the original array.
*/


    while (left != mid){ //while left is less than mid
        out.push_back(*left); //push the remaining values of left
        ++left;
    }
    while (right != last){ //while right is less than last
        out.push_back(*right); //push the remaining values of right
        ++right;
    }


    copy(out.begin(),out.end(),first); //copy over the output array back into the input array
}


**Merge_k Implementation**
template<typename RandomAccessIterator, typename Comparator>
void merge_k(long int k, RandomAccessIterator first, RandomAccessIterator last, Comparator comp){
    int n=last-first;


    for (int subSize=k; subSize<n; subSize*=2){ //double size of subSections being merged
        for (int start=0; start<n; start+=2*subSize) {//merge every 2 subSections of size subSize
            int mid=start+subSize; //set mid to start + subSize
            if (mid>=n){ //if greater than the length of input array, set mid to n
                mid=n;
            }
            int end=start+2*subSize; //set end to start + 2 times the subSize
            if (end>n){ //if greater than the length of input array, set end to n
                end=n;

            }


            merge(first + start, first + mid, first + end, comp); //call merge function on the 2 subSections
        }
    }
}
/*
Merge_k: Merge k first sets a variable n to the size of the entire input array, represented by last minus first. A for loop is then opened, setting a variable subSize to k and running until it is greater or equal to n,
and multiplying subSize by 2 each iteration. subSize will represent the combined size of the two subsections to be merged. The inner for loop sets a variable start to 0, runs until it is greater and equal to n, and adds
2 * subSize to start each iteration. Start will represent the starting index of the first of the two subsections to be merged. Inside the inner for loop. A variable mid is set to start + subSize. This is the middle of
the two subsections being looked at given that start is the beginning and start + subSize is the end. It is then checked if mid is greater than or equal to n. If it is, then mid is past the length of the entire input
array, and it is just set to n. A variable end is then set to start+2*subSize to represent the end of the second subsection being merged. It is also checked if this variable is greater or equal to n. And if so it is set
to n as well. After these variables are set, the merge function is then called using start, mid, and end as the boundaries of the two subsections to be merged. After this the for loops iterate until every subsection is
merged back into one singular sorted array.
*/

**Merge Sort Implementation**
template<typename RandomAccessIterator, typename Comparator>
void merge_sort(RandomAccessIterator first, RandomAccessIterator last, Comparator comp, long int k = 1){
    int n=last-first; //length of working section
    if(n<=k){ //will only run if subsection is of length k or less
        insertion_sort(first, last, comp); //sort subsections
    }else{ //otherwise split entire array into subarrays of length k or less
        for(int i=0; i<n; i+=k){ //loop through every length k
            if(i+k>n){ //if the current first + k is past the end of the array
                merge_sort(first+i, last, comp, last-(first+i)); //sub array that's less than size k
            }else{
                merge_sort(first+i, first+i+k, comp, k); //sub array that is size k
            }
        }
        merge_k(k, first, last, comp); //merge all subsections
    }
}
/*
//Merge Sort: upon a call of merge_sort, a variable n is set to the length of the given subsection of the array, given by last - first. The following conditional checks for the length of n. If it is less than or equal to
k, then it will call insertion sort on the given subsection of the array. In the initial call of the function, n is the entire length of the array, so this conditional will be ignored. The else statement loops through
every chunk of k elements in the input array by iterating a variable i by k. The function will then recursively call merge_sort on that subsection of size k. If at any point the variable i + k is greater than the length
of the input array, merge_sort will only be called on the subsection from i to the last index of the input array. After the for loop iterates over the entire array, merge_k is called to merge all of the now sorted arrays
of size k (or less) back into one array. In each of these recursive calls of merge_sort, the size of n will be less than or equal to k, therefore the first conditional statement will be true. This calls insertion_sort on
the given subsection of size n, properly sorting it to be later merged back into the whole array.
*/