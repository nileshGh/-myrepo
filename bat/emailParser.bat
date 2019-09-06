@echo off
set WORKING_DIR=C:\QaAutomation\Utilities\EmailParser
cd C:\QaAutomation\Utilities\EmailParser\bin

set "param1=%~3"
set "param2=%~4"
setlocal EnableDelayedExpansion
if "!param1!"=="" ( 
		java -jar EmailParser.jar -Djavax.net.ssl.trustStore=C:\QaAutomation\Utilities\EmailParser\config\cacerts -Djavax.net.ssl.trustStorePassword=hello123 -Djava.security.debug=certpath -Djavax.net.debug=trustmanager Inbox "URGENT  Potential Shortage in %2" "Account Code: <b>%1</b>" "" 99999 TCA1 QaAutomation Hann6bal HSSMail 
) ELSE ( 
	java -jar EmailParser.jar -Djavax.net.ssl.trustStore=C:\QaAutomation\Utilities\EmailParser\config\cacerts -Djavax.net.ssl.trustStorePassword=hello123 -Djava.security.debug=certpath -Djavax.net.debug=trustmanager Inbox "URGENT  Potential Shortage in %2 %3 %4" "Account Code: <b>%1</b>" "" 99999 TCA1 QaAutomation Hann6bal HSSMail
)

rem java -jar EmailParser.jar -Djavax.net.ssl.trustStore=C:\QaAutomation\Utilities\EmailParser\config\cacerts -Djavax.net.ssl.trustStorePassword=hello123 -Djava.security.debug=certpath -Djavax.net.debug=trustmanager Inbox "URGENT  Potential Shortage in %2 %3 %4" "Account Code: <b>%1</b>" "" 99999 TCA1 QaAutomation Hann6bal HSSMail

exit