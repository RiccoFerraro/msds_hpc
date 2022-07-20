cmake_minimum_required(VERSION 3.1.0)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
project(saxpy LANGUAGES CXX)

add_executable(saxpy saxpy.cpp)

