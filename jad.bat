::����:     ����bat������jar������Դ��jar��
::����:     seavers
::����:     http://seavers.iteye.com/
::�汾:     1.7


::��/�ر���������ʾ
REM @echo OFF

::::::::::::::::::::::::::::���������ñ���::::::::::::::::::


::����jad�ļ���·��, ����ȡ��jad.exe, ��ʾ��PATH�в���,������ֹ�ָ��,���������޸�
set JAD_PATH=jad.exe

::���ý�ѹ����class�ļ���ŵ�λ��(���·��)
set CLASS_PATH=bin

::���÷�������java�ļ���ŵ�λ��(���·��)
set JAVA_PATH=src

::���JAD�ļ��Ƿ����bat����Ŀ¼��,
if exist "%~dp0jad.exe" set JAD_PATH=%~dp0jad.exe

::�жϲ�������,���û���ļ�����,�򱨴�,����Ҳ����ʹ��%~f1,Ҳ������%1,û�й�ϵ,֮��Ҫȥ������
if ""%1""=="""" (set /P JAR_PATH=������Ҫ�������JAR����·��...) else (set JAR_PATH=%~f1)
if '%JAR_PATH:~0,1%%JAR_PATH:~0,1%'=='""' set JAR_PATH=%JAR_PATH:~1,-1%

::��ȡԴ�����ŵ�·��,����ȡJAR������·��,Ȼ��ȥ��".jar"��Ϊ�ļ���·��, �����LOCATION���ܴ�����,��Ϊ���滹Ҫ׷���ַ�)
if ""%2""=="""" (set LOCATION=%JAR_PATH:~0,-4%) else (set LOCATION=%~f2)

::::::::::::::::::::��ʼִ�г���:::::::::::::::::::::::::::::::

::��ȡWinRAR.exe��·��,��������ʱ����rarpath��
for /f "usebackq delims=" %%i in (`ftype WinRAR`) do set RARPATH=%%i

::��rarpath���н���,ȥ��ǰ��7���ڷ�,ȥ������5���ַ�,�õ�WinRARִ��·��
::·����������������ʽ  Winrar="C:\Program Files\WinRAR\WinRAR.exe" "%1"
set RAREXE=%RARPATH:~7,-5%

::����WinRAR����,��ѹ�ļ���ָ��Ŀ¼��binĿ¼��
%RAREXE% x "%JAR_PATH%" "%LOCATION%\%CLASS_PATH%\"

::��������binĿ¼,ȡ����class�ļ�,����jad.exe�������Դ��,��class�Ŀ�����srcĿ¼��
::�򿪱����ӳٹ���
setlocal EnableDelayedExpansion
for /r "%LOCATION%\bin" %%i in (*.*) do if '%%~xi'=='.class' ("%JAD_PATH%"  -o -r -sjava -ff -b -nonlb -space -t -8 -d"%LOCATION%\%JAVA_PATH%" "%%~si") else (set TEMP_PATH=%%i & echo f|xcopy "%%i" "!TEMP_PATH:%LOCATION%\bin=%LOCATION%\src!")
endlocal EnableDelayedExpansion

::��������java�ļ�ѹ����Դ���ļ�
%RAREXE% a -ep1 -r "%LOCATION%-src.zip" "%LOCATION%\%JAVA_PATH%\*.*"


::::::::::::::::::�������, ��ʾ���н��::::::::::::::::::::::
echo *********************************************
echo �������н���
echo ������JAR����·��Ϊ %JAR_PATH%
echo ��ѹ������WinRAR.exe��·��Ϊ %RAREXE%
echo �����빤��JAD.exe��·��Ϊ %JAD_PATH%
echo ��������ļ��ĸ�·��Ϊ %LOCATION%
echo �������class�ļ������ %LOCATION%\%CLASS_PATH%
echo �������java�ļ������ %LOCATION%\%JAVA_PATH%
echo ѹ�����java�ļ������ %LOCATION%-src.zip
echo *********************************************
pause


