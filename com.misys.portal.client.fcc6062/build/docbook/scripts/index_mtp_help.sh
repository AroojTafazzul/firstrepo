#!/bin/bash
###############################################################################
# Copyright (C) Misys (http://www.misys.com), 2000-2009                       #
#                                                                             #
# Insert the online help                                                      #
###############################################################################
# Global parameters
LOGFILE=logs/mtp-help.log
CONFIG_DIR=config
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
function job
{	
	    note "About to execute the command java -Djava.endorsed.dirs=$LIB_DIR -cp $GTP_CLASSPATH com.misys.onlinehelp.index.Indexer"
	    java -Djava.endorsed.dirs=$LIB_DIR -cp $GTP_CLASSPATH com.misys.onlinehelp.index.Indexer
	    return $?
}

# Buid the classpath
LIB_LIST=`ls -1rt $LIB_DIR/*.* 2>> /dev/null`
GTP_CLASSPATH=":$LIB_DIR:$CONFIG_DIR"
for lib_file in $LIB_LIST
do
	GTP_CLASSPATH="$GTP_CLASSPATH:$lib_file"
done
GTP_CLASSPATH=`echo "$GTP_CLASSPATH" | sed 's/^://'`

RC=0
note "About to index online help..."

# Launch the java program
job $SOURCE_LIST 2>&1
RC=$?
if [ $RC -ne 0 ]
then
	note "ERROR while indexing the online help!\n"
	exit $RC
fi
note "End online help indexing."
exit $RC