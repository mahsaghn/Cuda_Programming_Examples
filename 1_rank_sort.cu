#include <stdio.h>

const int N = 30;
const int blocksize = 16;

__global__ void vector_add(float *out, float *a, int n) {
   int tid = blockIdx.x * blockDim.x + threadIdx.x;
   int counter = 0;
   for(int i = 0; i < n; i ++){
        if(a[i]<a[tid] || (a[i] == a[tid] && tid>i)){
           counter++;
        }
    }
   out[counter] = a[tid];
}

int main(){
   float *a, *out;
   float *d_a, *d_out;

   a = (float*)malloc(sizeof(float) * N);
   out = (float*)malloc(sizeof(float) * N);
   for( int i =0; i<N; i++){
      a[i] = (N-i + 5)%(N-5);
   }

   cudaMalloc((void**)&d_a, sizeof(float) * N);
   cudaMalloc((void**)&d_out, sizeof(int) * N);
   cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);

   vector_add<<<1,N>>>(d_out, d_a, N);
   cudaMemcpy(out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost);
   
   for( int i =0; i<N; i++){
      printf("%f : %f\n",a[i], out[i]);
   }

   // Cleanup after kernel execution
   cudaFree(d_a);
   cudaFree(d_out);
   free(a);
   free(out);
}