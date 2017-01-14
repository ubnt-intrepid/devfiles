# Minimal C++ template

This is a minimal template for C++11 development with Waf build system.

To use the template, following environments are required:

* Python
* C++ compiler
  - Visual Studio (2013 or later)
  - g++ (4.8 or later)
  - clang++ (3.4 or later)

## Usage

1. Edit your C++ source files and `wscript`.

2. Build the project:

    ```
    $ ./waf configure --check-cxx-compiler msvc --msvc_lazy_autodetect
    $ ./waf configure --check-cxx-compiler clang++
    $ ./waf clean build --notests
    ```

3. run tests

    ```
    $ ./waf build --alltests
    ```

## CI Status

* Travis CI (g++, clang++)
  [![Build Status](https://travis-ci.org/ys-nuem/my-cpp-template.svg?branch=master)](https://travis-ci.org/ys-nuem/my-cpp-template)

* Appveyor (msvc)
  [![Build status](https://ci.appveyor.com/api/projects/status/agj94pensas4jmnc/branch/master?svg=true)](https://ci.appveyor.com/project/y-sasaki-nuem/my-cpp-template/branch/master)



## LICENSE

MIT License (see [LICENSE](LICENSE).)

## TODO

- [ ] Boost
- [ ] other C++ libraries
- [ ] support for Android (termux)
