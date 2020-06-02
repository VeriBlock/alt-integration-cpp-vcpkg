# alt-integration-cpp-vcpkg
![CI](https://github.com/VeriBlock/alt-integration-cpp-vcpkg/workflows/CI/badge.svg)

How to use:

1. Install vcpkg first.
2. Add repository as submodule with the name 'veriblock-pop-cpp'
```
$ cd vcpkg/ports
# cloned directory name should be 'veriblock-pop-cpp'
$ git submodule add --name veriblock-pop-cpp https://github.com/VeriBlock/alt-integration-cpp-vcpkg veriblock-pop-cpp
```

2. Use vcpkg:
```
$ vcpkg install veriblock-pop-cpp
```
 