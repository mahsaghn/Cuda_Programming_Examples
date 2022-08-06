#include <stdio.h>
#include <math.h>
const int N = 32;
const int blocksize = 16;

__global__ void vector_sort(int *a, int n) {
   __shared__ int *sh_a;  
   __shared__ int round;
   sh_a = a;
   int powround=1;
   int id = blockIdx.x * blockDim.x + threadIdx.x;
   int tid=0;
   for(round = 1; round <= n; round++)
   {
      tid = id*2;
      tid +=1 ;
      powround *=2;
      if((tid+1)% powround==0)
      {
         int prev_id = tid - (int)(powround/2);
         if(prev_id>0){
            sh_a[tid] += sh_a[prev_id];
         }
      }
      __syncthreads();
   }
   powround = (int)powround/2;
   for(; powround >= 2;)
   {
      tid = powround* id + (powround/2)-1;
      if((N-1- (int)(powround/2)-tid)% powround == 0)
      {
         int prev_id = tid - (int)(powround/2);
         if(prev_id>0){
            sh_a[tid] += sh_a[prev_id];
         }
      }
      __syncthreads();
      powround /=2;
   }
}

int main(){
   int *a;
   int *d_a;

   a = (int*)malloc(sizeof(int) * N);
   for( int i =0; i<N; i++){
      a[i] = i;
      printf("%d : %d\n",i,a[i]);
   }
   printf("_________\n");
   cudaMalloc((void**)&d_a, sizeof(int) * N);
   cudaMemcpy(d_a, a, sizeof(int) * N, cudaMemcpyHostToDevice);

   vector_sort<<<1,N/2>>>(d_a, log2(N));
   cudaMemcpy(a, d_a, sizeof(int) * N, cudaMemcpyDeviceToHost);
   
   for( int i =0; i<N; i++){
      printf("%d : %d\n",i,a[i]);
   }
   printf("\n");

   // Cleanup after kernel execution
   cudaFree(d_a);
   free(a);
}