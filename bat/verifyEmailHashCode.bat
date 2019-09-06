@echo off
set WORKING_DIR=C:\QaAutomation\Utilities\EmailParser
cd C:\QaAutomation\Utilities\EmailParser\bin
java -jar EmailParser.jar -Djavax.net.ssl.trustStore=C:\QaAutomation\Utilities\EmailParser\config\cacerts -Djavax.net.ssl.trustStorePassword=hello123 -Djava.security.debug=certpath -Djavax.net.debug=trustmanager Inbox %1 %2 "" %3 TCA1 QaAutomation Hann6bal HSSMail
