#/bin/bash  
################################################################  
#  automatically run a script(action.sh) when the contents  
#     of a directory (${EVENTPATH}) changed.  
#  pls. install the inotify-tools-3.13-1.el4.rf.i386.rpm module  
#       before use this scripts  
# 
#  Sep.8, 2013  
################################################################  
  
EVENTPATH="."  
MSG=".inotifymsg"  
PATTERN=".rpm$"          # only when the rpm files changed.  
while inotifywait -e modify -e create -e delete -e moved_to -e moved_from \  
                   ${EVENTPATH} 1>${EVENTPATH}/${MSG} 2>/dev/null;  
do  
        FILE=`cat $EVENTPATH/${MSG} |egrep ${PATTERN} | awk '{print $3}' `  
        ACTION=`cat $EVENTPATH/${MSG} |egrep ${PATTERN} | awk '{print $2}' `  
        [ ! -z ${FILE} ] && \  
        echo "in the directory ${EVENTPATH}, the file: ${FILE} modified,  action:${ACTION} " && \  
        ./action.sh  
done  
