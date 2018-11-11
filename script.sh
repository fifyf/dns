#!/bin/bash

# isCourt[]active; 0=off; 1=25%; 2=50%; 3=100%
isCourtAactive=0
isCourtBactive=0

c_date=`date +"%d"`
c_mon=`date +"%m"`
c_year=`date +"%Y"`

c_day=`date +"%w"`

c_hr=`date +"%H"`
c_min=`date +"%M"`


grep '^;' /home/balaji/dns/dnsAuto.conf | while read -r line
do
dayIsSet=0
f_date=`echo $line | awk -F';' '{print $2}' | awk -F'-' '{print $1}'`
f_mon=`echo $line | awk -F';' '{print $2}' | awk -F'-' '{print $2}'`
f_year=`echo $line | awk -F';' '{print $2}' | awk -F'-' '{print $3}'`
f_shr=`echo $line | awk -F';' '{print $3}' | awk -F'-' '{print $1}' | awk -F':' '{print $1}'`
f_smin=`echo $line | awk -F';' '{print $3}' | awk -F'-' '{print $1}' | awk -F':' '{print $2}'`
f_ehr=`echo $line | awk -F';' '{print $3}' | awk -F'-' '{print $2}' | awk -F':' '{print $1}'`
f_emin=`echo $line | awk -F';' '{print $3}' | awk -F'-' '{print $2}' | awk -F':' '{print $2}'`
venue=`echo $line | awk -F';' '{print $4}'`

if [ "$f_year" = "$c_year" ]; then
 if [ "$f_mon" = "$c_mon" ]; then
  if [ "$f_date" = "MF" ]; then
    if [ "$c_day" -le 5 ]; then
      if [ "$c_day" -ne 0 ]; then
        dayIsSet=1;
      fi
    fi
    f_date=$c_date
  elif [ "$f_date" = "MS" ]; then
    if [ "$c_day" -ge 6 ]; then
      if [ "$c_day" -ne 0 ]; then
        dayIsSet=1;
      fi
    fi
    f_date=$c_date
  elif [ "$f_date" = "FW" ]; then
    dayIsSet=1;
    f_date=$c_date
  elif [ "$f_date" = "ST" ]; then
    if [ "$c_day" -eq 6 ]; then
      dayIsSet=1;
    fi
    f_date=$c_date
  elif [ "$f_date" = "SU" ]; then
    if [ "$c_day" -ne 0 ]; then
      dayIsSet=1;
    fi
    f_date=$c_date
  elif [ "$f_date" = "SS" ]; then
    if [ "$c_day" -eq 0 ]; then
      dayIsSet=1;
    fi
    if [ "$c_day" -eq 6 ]; then
      dayIsSet=1;
    fi
    f_date=$c_date
  elif [ "$f_date" = "$c_date" ]; then
    dayIsSet=1;
    f_date=$c_date
  fi  #date 
 fi  #Month
fi  #Year

st_time="$f_year-$f_mon-$f_date $f_shr:$f_smin"
end_time="$f_year-$f_mon-$f_date $f_ehr:$f_emin"

tot_time=$(echo $(date -d "$end_time" +%s) - $(date -d "$st_time" +%s) | bc)
current_tot_time=$(echo $(date +%s) - $(date -d "$st_time" +%s) | bc)

if [ $dayIsSet -eq 1 ]; then
n_hr=`expr $f_ehr + 1`
  if [ "$c_hr" -ge "$f_shr" -a "$c_hr" -lt "$f_ehr" ]; then
    echo "#Keep Venue on"
  elif [ "$c_hr" -eq "$f_ehr" ]; then
    if[ "$c_min" -le 15 ]; then
    echo "#Keep Venue on"
    fi
    if[ "$c_min" -le "15" ]; then
    echo "#Keep Venue on"
    fi
    if[ "$c_min" -le "15" ]; then
    echo "#Keep Venue on"
    fi
  fi
fi

done
