#include <stdio.h>
const int N = 24;
const int blocksize = 16;

__global__ void vector_sort(float *a, int n) {
   __shared__ float *sh_a;  
   sh_a = a;
   int id = blockIdx.x * blockDim.x + threadIdx.x;
   int tid = 0; 
   if(id < N-1)
   {
      for(int i = 0; i <= n; i++){
         
         if(i%2==0)
         {
            tid = id*2;
         }
         else
         {
            tid = id*2+1;
         }
         if(sh_a[tid] > sh_a[tid+1]){
            float h = sh_a[tid];
            sh_a[tid] = sh_a[tid+1];
            sh_a[tid+1] = h;
         }
         __syncthreads();
      }
   }
}

int main(){
   float *a;
   float *d_a;

   a = (float*)malloc(sizeof(float) * N);
   for( int i =0; i<N; i++){
      a[i] = (7*(N-i) + 5)%(N-5);
      printf("%d : %f\n",i,a[i]);
   }
   printf("_________\n");
   cudaMalloc((void**)&d_a, sizeof(float) * N);
   cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);

   vector_sort<<<1,N/2>>>(d_a, N);
   cudaMemcpy(a, d_a, sizeof(float) * N, cudaMemcpyDeviceToHost);
   
   for( int i =0; i<N; i++){
      printf("%d : %f\n",i,a[i]);
   }
   printf("\n");

   // Cleanup after kernel execution
   cudaFree(d_a);
   free(a);
}