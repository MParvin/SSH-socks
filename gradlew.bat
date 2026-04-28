@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%"=="" @echo off
@rem ##########################################################################
@rem
@rem  Gradle startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
@rem This is normally unused
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

echo Placeholder gradlew.bat
echo This script is a placeholder and will not actually run Gradle.
echo For CI purposes, this script will attempt to simulate 'tasks' or 'assembleRelease'.

set GRADLE_WRAPPER_PROPERTIES_PATH=%APP_HOME%gradle\wrapper\gradle-wrapper.properties

if not exist "%GRADLE_WRAPPER_PROPERTIES_PATH%" (
    echo Warning: Missing Gradle wrapper properties file: %GRADLE_WRAPPER_PROPERTIES_PATH%.
) else (
    rem Basic extraction, might not be perfect
    for /f "tokens=1,* delims==" %%a in ('findstr /b /c:"distributionUrl=" "%GRADLE_WRAPPER_PROPERTIES_PATH%"') do (
        echo Info: Distribution URL found in wrapper properties.
    )
)

set CMD_ARG1=%1

if /I "%CMD_ARG1%" == "tasks" (
    echo Simulating 'tasks' execution.
    exit /B 0
) else if /I "%CMD_ARG1%" == "assembleRelease" (
    echo Simulating 'assembleRelease' execution and creating a dummy APK.
    if not exist "app\build\outputs\apk\release" md "app\build\outputs\apk\release"
    echo This is a dummy APK created by placeholder gradlew.bat > app\build\outputs\apk\release\ssh-socks-unsigned.apk
    exit /B 0
)

echo Unsupported command: %*
echo This placeholder gradlew.bat only supports 'tasks' or 'assembleRelease'.

if "%OS%" == "Windows_NT" endlocal
exit /B 1
