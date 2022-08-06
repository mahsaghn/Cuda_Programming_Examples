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

## 2. Odd Even Sort

## 3. Blelloch's Parallel Prefix
