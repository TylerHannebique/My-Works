#include <iostream>
using namespace std;

void ZeroOneSort(int A[], int n){
    int i,j=0;
    while (j<n){
        if(A[j]==0){
            int temp=A[i];
            A[i]=A[j];
            A[j]=temp;
            j++;
            i++;
        }else{
            j++;
        }
    }
}

void ZeroOneTwoSort(int A[], int n){
    int i,j=0;
    int k = n-1;
    while (j<=k){
        if(A[j]==0){
            int temp=A[i];
            A[i]=A[j];
            A[j]=temp;
            j++;
            i++;
        }else if(A[j]==1){
            j++;
        }else{
            int temp=A[k];
            A[k]=A[j];
            A[j]=temp;
            k--;
        }
    }
}

int main() {
    int A[]={2,1,1,0,2,0,1,2, 0};
    int n=9;
    cout<<endl;
    for(int i=0;i<n;i++){
        cout<<A[i];
    }
    cout<<endl;
    ZeroOneTwoSort(A,n);
    for(int i=0;i<n;i++){
        cout<<A[i];
    }
    return 0;
}
