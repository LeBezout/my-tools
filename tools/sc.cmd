@ECHO OFF

@REM echo SC %1

IF "%1"=="-h" (
	echo sc [id regle]
	echo Exemple sc 1100
	goto fin
)

set RULE_ID=%1

IF "X%RULE_ID%"=="X" GOTO suite1
goto suite2

:suite1
set /p RULE_ID="Saisir l'ID de la regle ShellCheck. Exemple 1100 : "
IF "X%RULE_ID%"=="X" GOTO suite1

:suite2
start https://github.com/koalaman/shellcheck/wiki/SC%RULE_ID%

:fin
