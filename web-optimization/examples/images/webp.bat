rem   echo %%~dpnxF

echo off
for /r %%i in (*) do cwebp %%~nxi -o %%~ni.webp
