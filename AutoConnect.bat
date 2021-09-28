@ECHO OFF
ECHO ------------------------------Feito Por Skyron------------------------------
ECHO.
ECHO -------------------------INICIO (%date%)%time:~0,5%-------------------------
ECHO.
SET TimeInicial=%time:~0,5%
:config
for /f "tokens=*" %%a in ('FIND "Instancias" Config.json') do SET ConfigImport==%%a
SET Instancias=%ConfigImport:~12,100%
for /f "tokens=*" %%a in ('FIND "Automatic" Config.json') do SET ConfigImport==%%a
SET Automatic=%ConfigImport:~11,100%
for /f "tokens=*" %%a in ('FIND "AutoReboot" Config.json') do SET ConfigImport==%%a
SET AutoReboot=%ConfigImport:~12,100%
for /f "tokens=*" %%a in ('FIND "ContasPorIP" Config.json') do SET ConfigImport==%%a
SET Aviso=%ConfigImport:~13,100%
for /f "tokens=*" %%a in ('FIND "Server" Config.json') do SET ConfigImport==%%a
SET Server=%ConfigImport:~8,100%
for /f "tokens=*" %%a in ('FIND "EnterChar" Config.json') do SET ConfigImport==%%a
SET EnterChar=%ConfigImport:~11,100%

SET Atual=1
SET Count=0
SET CountGeral=0
SET InstanciasCount=0

ECHO (%date%)%time:~0,5% Verificando sua conexao...
GOTO ping

:selectStart
IF %Automatic% == True (
GOTO startA ) else (
GOTO start )

:checagem
IF %EnterChar% == False SET Char=False
IF %Count% == %Aviso% (
	IF %AutoReboot% == True (
		GOTO reboot ) else ( 
							GOTO dica ) )
							
FIND "Login%Atual%" Contas.txt > NUL
IF %errorlevel%==1 GOTO final
GOTO selectStart	


:startA
for /f "tokens=*" %%a in ('FIND "Login%Atual%" Contas.txt') do SET Login=%%a
for /f "tokens=*" %%a in ('FIND "Senha%Atual%" Contas.txt') do SET Password=%%a
IF %EnterChar% == True for /f "tokens=*" %%a in ('FIND "Char%Atual%" Contas.txt') do SET Char==%%a
START /REALTIME ELEMENTCLIENT.LNK startbypatcher rendernofocus user:%Login:~8,100% pwd:%Password:~8,100% server:%Server% role:%Char%
SET /A "InstanciasCount=%InstanciasCount%+1"
ECHO Logando a conta:
ECHO (%date%)%time:~0,5% %Login:~8,100%
ECHO %LoginI%%Atual%|CLIP
echo.

IF NOT %InstanciasCount% == %Instancias% (
SET /A "Atual=%Atual%+1"
SET /A "Count=%Count%+1"
SET /A "CountGeral=%CountGeral%+1"
GOTO checagem )

TIMEOUT /t 55 /nobreak
TASKKILL /IM ELEMENTCLIENT.EXE /F > NUL
SET /A "Atual=%Atual%+1"
SET /A "Count=%Count%+1"
SET /A "CountGeral=%CountGeral%+1"
SET InstanciasCount=0
echo.
GOTO checagem

:start
for /f "tokens=*" %%a in ('FIND "Login%Atual%" Contas.txt') do SET Login=%%a
for /f "tokens=*" %%a in ('FIND "Senha%Atual%" Contas.txt') do SET Password=%%a
IF %EnterChar% == True for /f "tokens=*" %%a in ('FIND "Char%Atual%" Contas.txt') do SET Char==%%a
START /REALTIME ELEMENTCLIENT.LNK startbypatcher rendernofocus user:%Login:~8,100% pwd:%Password:~8,100% server:%Server% role:%Char%
SET /A "InstanciasCount=%InstanciasCount%+1"
ECHO Logando a conta:
ECHO (%date%)%time:~0,5% %Login:~8,100%
ECHO %LoginI%%Atual%|CLIP
echo.

IF NOT %InstanciasCount% == %Instancias% (
SET /A "Atual=%Atual%+1"
SET /A "Count=%Count%+1"
SET /A "CountGeral=%CountGeral%+1"
GOTO checagem )

PAUSE
TASKKILL /IM ELEMENTCLIENT.EXE /F > NUL
SET /A "Atual=%Atual%+1"
SET /A "Count=%Count%+1"
SET /A "CountGeral=%CountGeral%+1"
SET InstanciasCount=0
echo.
GOTO checagem

:final
ECHO -------------------------FIM-------------------------
ECHO -------------------------BOT FINISH (%date%)%time:~0,5%-------------------------
ECHO Horario Inicial: %TimeInicial%
ECHO Horario Final: %time:~0,5%
ECHO Foram logadas %Atual% contas
PAUSE
EXIT

:dica
ECHO (%date%)%time:~0,5% Voce ja logou %Aviso% contas
PAUSE
SET Count=0
GOTO checagem

:error
ECHO (%date%)%time:~0,5% %error%
PAUSE
EXIT

:reboot

REM Faça aqui seu AutoReboot

GOTO ping

:ping
ping google.com >nul
IF ERRORLEVEL 1 GOTO PING else (
SET Count=0
ECHO (%date%)%time:~0,5% Conexao com a internet estabelecida
ECHO.
GOTO checagem
)
							