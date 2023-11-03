#!/bin/bash
###############################################################################
# Copyright (C) Misys (http://www.misys.com), 2000-2009                       #
#                                                                             #
# Insert the online help                                                      #
###############################################################################
# Global parameters
LOGFILE=logs/mtp-help.log
CONFIG_DIR=config
CATALOG_DIR=$CONFIG_DIR/catalog
DTD_DIR=$CONFIG_DIR/dtd
DATA_DIR=data
LIB_DIR=lib

# Common functions
date_time() {
	echo `date +%D' '%H:%M:%S`':'
	return 0
}
note() {
	echo "`date_time` $1" >> $LOGFILE 2>&1
}
# Function in charge of the java invocation
#function job
#{	
#	    note "About to execute the command java -Dlog4j.configuration=log4j.properties -Djava.endorsed.dirs=$LIB_DIR -cp $GTP_CLASSPATH com.neomalogic.onlinehelp.Generator index operation inserthelp $1"
#	    java -Dlog4j.configuration=log4j.properties -Djava.endorsed.dirs=$LIB_DIR -cp $GTP_CLASSPATH com.neomalogic.onlinehelp.Generator -index -operation inserthelp $1
#	    return $?
#}

# Buid the classpath
LIB_LIST=`ls -1rt $LIB_DIR/*.* 2>> /dev/null`
GTP_CLASSPATH=":$CONFIG_DIR:$CATALOG_DIR:$DTD_DIR"
for lib_file in $LIB_LIST
do
	GTP_CLASSPATH="$GTP_CLASSPATH:$lib_file"
done
GTP_CLASSPATH=`echo "$GTP_CLASSPATH" | sed 's/^://'`

#For each file, trigger the java process
#SOURCE_LIST=`ls -1rt -m $DATA_DIR | tr -d ',' 2>> /dev/null`
#RC=0
note "About to load online help..."
note "About to load the file(s) $SOURCE_LIST\n"
	    
note "About to execute the command java -Dlog4j.configuration=log4j.properties -Djava.endorsed.dirs=$LIB_DIR -cp $GTP_CLASSPATH com.neomalogic.onlinehelp.Generator index operation inserthelp $1"
java -Dlog4j.configuration=log4j.properties -Djava.endorsed.dirs=$LIB_DIR -cp $GTP_CLASSPATH com.neomalogic.onlinehelp.Generator -index -operation inserthelp data/mtp_help_client_en.html data/mtp_help_bank_en.html

# Process files
#FILE_LIST=`ls -1rt $DATA_DIR/*.* 2>> /dev/null`
#for data_file in $FILE_LIST
#do
#	job $data_file 2>&1
#	RC=$?
#	if [ $RC -ne 0 ]
#	then
#		note "ERROR processing $source_file !\n"
#		exit $RC
#	fi
note "End online help loading."
exit $RC
