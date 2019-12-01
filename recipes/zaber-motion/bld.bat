@echo ON
setlocal enabledelayedexpansion

cd zaber-motion-lib
if errorlevel 1 exit 1

rem Look at gulpfil.js, protobuf_py
protoc -I=. --python_out="py\zaber_motion\zaber_motion"      ^
    --plugin="protoc-gen-mypy=tools\protoc-gen-mypy.bat"     ^
    --mypy_out="py\zaber_motion\zaber_motion" protobufs\main.proto
if errorlevel 1 exit 1

echo.> py\zaber_motion\zaber_motion\protobufs\__init__.py
if errorlevel 1 exit 1


cd py\zaber_motion
%PYTHON% -m pip install . -vv --no-build-isolation --no-deps
if errorlevel 1 exit 1
cd ..\..

cd ..

cd bindings
if %ARCH% == 64 del zaber_motion_bindings_windows\zaber-motion-lib-windows-386.dll
if %ARCH% == 32 del zaber_motion_bindings_windows\zaber-motion-lib-windows-amd64.dll
%PYTHON% -m pip install . -vv --no-build-isolation --no-deps
if errorlevel 1 exit 1
cd ..
