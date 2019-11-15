#!/bin/bash
### BEGIN INIT INFO
# Provides:     MediaAgent
# Required-Start:   $remote_fs $remote_fs $network
# Required-Stop:    $remote_fs $remote_fs $network
# Default-Start:    2 3 4 5
# Default-Stop:     0 1 6
# Short-Description: Start or Stop MediaAgent 
### END INIT INFO
############# JAR PATH ##############
JAR_PATH=/home/MediaAgent/lib/MediaAgent.jar

########### PARAMETERS ##############
WATCH_PATH=/home/namwoo/torrent
MOVIE_PATH=/home/namwoo/media/MOVIE
TV_PATH=/home/namwoo/media/TV
SUB_PATH=/home/namwoo/media/SUBTITLE
USER_ID=namwoo
REFRESH_CYCLE=6

RENAME_USE=TRUE
RENAME_WORD=RENAMED
RENAME_SEPARATOR=.

########### OPENSUBTITLE ############
OPENSUB_ID=
OPENSUB_PW=
OPENSUB_LANG=

########### LOGPATH #################
LOGDIR=/logs/MediaAgent
LOGLEVEL=INFO

########### SYSLOG ##################
DATE=$(date +"%G-%m-%d.%T")
SYSFILE=System.out.println.${DATE}

########## FUCTION ##################
welcome(){
	echo
	echo "#######################################"
    printf "########## MEDIAAGENT %-6s ##########\n" $TITLE
    echo "#######################################"
    echo
    echo "WATCH DIRECTORY : ${WATCH_PATH}"
    echo "MOVIE DIRECTORY : ${MOVIE_PATH}"
	echo "TV    DIRECTORY : ${TV_PATH}"
    echo "SUB   DIRECTORY : ${SUB_PATH}"
    echo "USER ID         : ${USER_ID}"
    echo "REFRESH CYCLE   : ${REFRESH_CYCLE}"
    echo
}

#####################################
# 실행

case "$1" in
	
	start)
		TITLE='START'
		PID=$(ps -ef | grep MediaAgent.jar | grep java | awk '{print $2}')
		if((${PID}));then
		kill ${PID}
		echo kill ${PID} process...
		fi
		nohup java -Dwatch_path=${WATCH_PATH} -Dmovie_path=${MOVIE_PATH} -Dtv_path=${TV_PATH} -Dsub_path=${SUB_PATH} -Duser_id=${USER_ID} -Dlogdir=${LOGDIR} -DlogLevel=${LOGLEVEL} -Drefresh_cycle=${REFRESH_CYCLE} -Drename_use=${RENAME_USE} -Drename_word=${RENAME_WORD} -Drename_separator=${RENAME_SEPARATOR} -Dopensub_id=${OPENSUB_ID} -Dopensub_pw=${OPENSUB_PW} -Dopensub_lang=${OPENSUB_LANG} -jar ${JAR_PATH} > ${LOGDIR}/${SYSFILE} 2>&1 &
		sleep 2
		welcome
		PROCESS=$(ps -ef | grep MediaAgent.jar | grep java | awk '{print $2}')
		if((${PROCESS}));then
		STAT=RUN
		else
		STAT=DOWN
		fi

		echo "PID             : ${PROCESS}"
		echo "STATUS          : ${STAT}"
		echo
	;;

	stop)
		TITLE='STOP'
		PID=$(ps -ef | grep MediaAgent.jar | grep java | awk '{print $2}')
		if((${PID}));then
		kill ${PID}
		welcome
		echo
		echo "STATUS          : DOWN"
		echo
		else
		welcome
		echo 
		echo "STATUS          : DOWN"
		echo
		fi
	;;

	status)
		TITLE='STATUS'
		PID=$(ps -ef | grep MediaAgent.jar | grep java | awk '{print $2}')
		if((${PID}));then
		welcome
		echo "PID             : ${PID}"
		echo "STATUS          : RUN"
		echo
		else
		welcome
		echo "STATUS          : DOWN"
		echo
		fi
	;;

esac
























