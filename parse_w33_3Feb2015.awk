#!/usr/bin/awk -f
# Parser for M4 files that may contain # M4 sets of data. (18 columns, 9 cols of data)
#
# Will look for lines with M4_UART tag
# and retrieve: ppg1 ppg2 rhr delta_samples accX accY accZ heartRate Confidence (add date & time in last 2 columns)
# and save it into .txt.#
#
# Resting Heart Rate = (i_rhr+6) * 25/256 *60 beats/min
#
# Swee Mok, Feb 3, 2015
#
#======================================================================================
#
# M4=0x0eee
# Feb 3, 2015
#
#    LogV(LOG_HR,"hr %d %d %d %d %d %d %d %d %d %d",
#    sample_count,
#    (S32)(ppg1*1000000),
#    (S32)(ppg2*1000000),
#    i_rhr,
#    (S32)delta_samples,
#    (S32)accelData->x,
#    (S32)accelData->y,
#    (S32)accelData->z,
#    (U32)hrData->heartRate,
#    (U32)hrData->confidence);
#
#
# Example:
#                                                         No   P1  P2 rhr d X      Y      Z     HR Conf
#    1     2             3     4    5 6       7 8      9  10   11  12 13 14 15     16     17    18 19
#
#    02-03 12:31:10.305  1427  1427 D M4_UART : 6427: AfeDrv: Initialize Successfully
#    ...
#    02-03 12:33:39.001  1427  1427 D M4_UART : 10142: hr 3556 886 659 0 11 -67299 -51751 28741 78 0
#    02-03 12:33:39.007  1427  1427 D M4_UART : 10142: hr 3557 263 435 0 11 -67299 -51751 28741 78 0
#    02-03 12:33:39.035  1427  1427 D M4_UART : 10143: hr 3558 -281 289 0 11 -72547 -58599 35717 78 0
#    02-03 12:33:39.075  1427  1427 D M4_UART : 10144: hr 3559 -444 447 0 11 -87907 -61959 33925 78 0
#    02-03 12:33:39.115  1427  1427 D M4_UART : 10145: hr 3560 -207 854 0 11 -122339 -27623 17157 78 0
#    ...
#    02-03 12:44:00.431  1427  1427 D M4_UART : 25649: AfeDrv: DeInit Successfully

#-------------------------------------------------------------------------------------------
#
BEGIN {x=0;}
{
  if ($6=="M4_UART")
  {
    if ($9=="AfeDrv:" && $10=="Initialize")
    {
      if (x>0) close output
      x+=1;
      output = substr(FILENAME,1,index(FILENAME,".")-1)".txt."x
    }
    else if (x>0 && $9=="hr" && NF==19)
    {
      print $10 "," $11 "," $12 "," $13 "," $14 "," $15 "," $16 "," $17 "," $18 "," $19 "," $1 "," $2 > output
    }
  }
}

#======================================================================================
