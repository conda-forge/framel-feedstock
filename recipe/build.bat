@echo on

mkdir _build
cd _build

cmake ^
  %CMAKE_ARGS% ^
  -G "Ninja" ^
  -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ^
  -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
  -DENABLE_C:BOOL=yes ^
  -DENABLE_MATLAB:BOOL=no ^
  -DENABLE_PACKAGING:BOOL=no ^
  -DENABLE_PYTHON:BOOL=no ^
  "%SRC_DIR%" ^
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --parallel "%CPU_COUNT%" --verbose
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --parallel "%CPU_COUNT%" --verbose --target install
if %ERRORLEVEL% neq 0 exit 1
