#include <iostream>
#include <cstdlib>

#define SIZE 10

using namespace std;

int compare(const void *a, const void *b);
void print(const int *A);

//---------------------------------

int main(int argc, char* argv[]){

  int A[SIZE] = {5,2,4,3,1,7,6,9,0,8};

  print(A);
  qsort(A,SIZE,sizeof(int),compare);
  print(A);

  return 0;
}

int compare(const void *a, const void *b){
  int *x = (int*)a;
  int *y = (int*)b;

  if (*x < *y)
    return -1;
  else if (*x == *y)
         return 0;
  else 
    return 1;
}

void print(const int *A) {
  for (int i=0; i<SIZE; i++)
    cout << " " << A[i];
  cout << endl;
}


