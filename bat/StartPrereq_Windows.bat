@echo off

REM Usage: StartPrereq_Windows.bat ACTIVE_MQ_IP ACTIVE_MQ_PORT
start cmd.exe /K "cd C:\QaAutomation\Utilities\apache-activemq-5.6.0\bin && activemq.bat" 
timeout 10
start cmd.exe /K "cd C:\QaAutomation\Utilities\Pipe\Artifacts && java -jar QueueConsumer-0.0.3-SNAPSHOT.one-jar.jar "%1" "%2"" 
timeout 10
start cmd.exe /K "cd C:\QaAutomation\Utilities\Routes\bin && java -jar ConsumerProducerRoute.jar "%1" "%2""
timeout 10