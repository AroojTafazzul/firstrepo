@echo off
 setLocal EnableDelayedExpansion
 set MY_CLASSPATH="
 for /R ./lib %%a in (*.jar) do (
   set MY_CLASSPATH=!MY_CLASSPATH!;%%a
 )
 set MY_CLASSPATH=!MY_CLASSPATH!"

java -Dlog4j.configuration=config/log4j.properties -Djava.endorsed.dirs=. -cp !MY_CLASSPATH!;config;config/catalog;config/dtd com.neomalogic.onlinehelp.Generator -index -operation inserthelp data/mtp_help_client_en.html data/mtp_help_bank_en.html
