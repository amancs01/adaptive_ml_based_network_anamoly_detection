@echo off
setlocal

REM ---- EDIT THESE PATHS IF YOURS ARE DIFFERENT ----
set PPCAP=D:\adaptive_ai\PcapPlusPlus
set NPCAPSDK=C:\npcapsdk
REM -------------------------------------------------

if not exist "%PPCAP%\Pcap++\header\PcapLiveDeviceList.h" (
  echo ERROR: PcapPlusPlus headers not found at %PPCAP%
  echo Expected: %PPCAP%\Pcap++\header\PcapLiveDeviceList.h
  exit /b 1
)

if not exist "%NPCAPSDK%\Lib\x64\wpcap.lib" (
  echo ERROR: Npcap SDK libs not found at %NPCAPSDK%
  echo Expected: %NPCAPSDK%\Lib\x64\wpcap.lib
  exit /b 1
)

if not exist "src\main.cpp" (
  echo ERROR: src\main.cpp not found.
  exit /b 1
)

if not exist "bin" mkdir bin

cl /EHsc /MD src\main.cpp ^
 /I"%PPCAP%\Common++\header" ^
 /I"%PPCAP%\Packet++\header" ^
 /I"%PPCAP%\Pcap++\header" ^
 /Fe:bin\main.exe ^
 /link ^
 /LIBPATH:"%PPCAP%\build\Common++\Release" ^
 /LIBPATH:"%PPCAP%\build\Packet++\Release" ^
 /LIBPATH:"%PPCAP%\build\Pcap++\Release" ^
 /LIBPATH:"%NPCAPSDK%\Lib\x64" ^
 Pcap++.lib Packet++.lib Common++.lib wpcap.lib Packet.lib ws2_32.lib iphlpapi.lib

if errorlevel 1 (
  echo.
  echo Build FAILED.
  exit /b 1
)

echo.
echo Build OK. Output: bin\main.exe
endlocal