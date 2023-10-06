@echo on

mkdir _build
cd _build

:: configure
cmake "%SRC_DIR%" ^
    -G "Ninja" ^
    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ^
    -DCMAKE_C_COMPILER=gcc ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DENABLE_C:BOOL=yes ^
    -DENABLE_MATLAB:BOOL=no ^
    -DENABLE_PYTHON:BOOL=no

:: build
cmake --build . --parallel "%CPU_COUNT%" --verbose

:: install
cmake --build . --parallel "%CPU_COUNT%" --verbose --target install
