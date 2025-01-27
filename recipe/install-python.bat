@echo on

set "_builddir=_build%PY_VER%"
mkdir "%_builddir%"
cd "%_builddir%"

rem configure
cmake "%SRC_DIR%" ^
    -G "Ninja" ^
    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ^
    -DCMAKE_C_COMPILER=gcc ^
    -DCMAKE_INSTALL_PREFIX:PATH="%PREFIX%" ^
    -DENABLE_C:BOOL=no ^
    -DENABLE_MATLAB:BOOL=no ^
    -DENABLE_PACKAGING:BOOL=no ^
    -DENABLE_PYTHON:BOOL=yes ^
    -DPython3_EXECUTABLE:FILEPATH="%PYTHON%"
if errorlevel 1 exit 1

rem build
cmake --build . --parallel "%CPU_COUNT%" --verbose
if errorlevel 1 exit 1

rem install
cmake --build . --parallel "%CPU_COUNT%" --verbose --target install
if errorlevel 1 exit 1
