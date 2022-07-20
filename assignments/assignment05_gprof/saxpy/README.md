# Basic AX+Y Implmentation

## Build

```sh
mkdir build && cd build
cmake .. 
make
```

## Profile

```sh
mkdir build && cd build
cmake .. -DCMAKE_CXX_FLAGS="-pg -O0" -DCMAKE_BUILD_TYPE=Debug
make
./saxpy
gprof ./saxpy gmon.out
```

