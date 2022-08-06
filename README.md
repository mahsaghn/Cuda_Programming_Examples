# Cuda Programming Examples 
Run each sample with the following command:
```
nvcc example.cu -o example

./example
```
Replace **example** with the name of the desired file.

## 1. Rank Sort
Pseudo code:

```
for all i in 0 .. n ‐ 1:

  cnt = 0;
  
  myValue = array[i];
  
  for all j in 0 .. n ‐ 1:
  
    if array[j] < myValue then cnt++;
    
      array[cnt] = myValue;
```

## 2. Odd Even Transposition Sort
<img src="https://github.com/mahsaghn/Cuda_Programming_Examples/blob/master/statistics/2_odd_even.png" width=500>

For more details of the algorithm see [GeeksForGeeks:Odd Even Transposition Sort](https://www.geeksforgeeks.org/odd-even-transposition-sort-brick-sort-using-pthreads/)
## 3. Blelloch's Parallel Prefix
Here is the schematic of the Blelloch's sort algorithm on a list including eight elements. 

<img src="https://github.com/mahsaghn/Cuda_Programming_Examples/blob/master/statistics/3.png" width=500>

