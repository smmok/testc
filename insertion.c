#include <stdio.h>

#define ASIZE 9

void printA(int A[]);
void isort(int A[]);
void printa(int A[]);

void main(int argc, char* argv[]){

  int A[ASIZE] = {5,3,8,1,7,2,4,9,6}; 

  printA(A);
  isort(A);
  printA(A);
  printf("***** The End of Insertion Sort Demo. *****\n");
}

void printA(int A[]){
  int i=0;

  printf("{");
  while (i<ASIZE){
    printf("%d ",A[i]);
    i++;
  }
  printf("}\n");
}

void printa(int A[]){
  int i=0;
  printf("[");
  while (i<ASIZE){
    printf("%d ",A[i]);
    i++;
  }
  printf("]\n");
}

void isort(int A[]){
  int i,j,key;

  for (j=1; j<ASIZE; j++){
    key = A[j];
    i = j-1;
    while (i>=0 && A[i]>key){
      A[i+1] = A[i];
      i--;
      printf("%d ",key);
      printa(A);
    }
    A[i+1] = key;
    printA(A);
    printf("---------------------------\n");
  }
} 
