%let pgm=utl-altair-personal-slc-odbc-sqlite-read-write-access-meta-data;

%stop_submission;

Altair personal slc odbc sqlite read write access meta data

see github, too long to post on a listserve
https://github.com/rogerjdeangelis/utl-altair-personal-slc-odbc-sqlite-read-write-access-meta-data

CONTENTS (altair personal slc and sqlite - no access product needed)

   1 creating sqlite table classage
   2 print sqlite table
   3 create a wpd file from a sqlite table (convert to sas7bdat later?)
   4 access sqlite dictionary
   5 log on end

Thanks to MayK feedback on ODBC

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

/*-- disable html precode and send output to listing destination ---*/
%utlfkil(%sysfunc(pathname(WPSWBHTM))); /*-- disable precode --*/
&_init_;

libname mydb odbc noprompt="Driver=SQLite3 ODBC Driver;Database=d:\sqlite\new.db;";

proc datasets lib=mydb;
  delete classage;
run;quit;

* LOG: NOTE: DELETING "MYDB.CLASSAGE" (MEMTYPE="DATA");

data mydb.classage;
  input
    name$
    sex$ age;
cards4;
Alfred  M 14
Alice   F 11
Barbara F 15
Carol   F 17
Henry   M 11
James   M 18
;;;;
run;quit;

* LOG: NOTE: DATA SET "MYDB.CLASSAGE" HAS AN UNKNOWN NUMBER OF OBSERVATION(S) AND 3 VARIABLE(S);

proc print data=mydb.classage;
run;

/*---
LISTING
Altair SLC

Obs    NAME        SEX         AGE

 1     Alfred      M            14
 2     Alice       F            11
 3     Barbara     F            15
 4     Carol       F            17
 5     Henry       M            11
---*/

libname dic wpd (wpshelp);
proc sql;
  select * from mydb.sqlite_master
  where type = 'table';
quit;

* LISTING: CREATE TABLE classage( NAME VARCHAR(8), SEX VARCHAR(8), AGE DOUBLE PRECISION );

libname wd1x wpd "d:/sd1";
data wd1x.wd1_classages;
  set mydb.classage;
run;quit;

* LOG: NOTE: DATA SET "SD1X.SD1_CLASSAGESQLITE" HAS 6 OBSERVATION(S) AND 3 VARIABLE(S);

libname sd1x sas7bdat "d:/sd1";
data sd1x.sd1_classages;
  set mydb.classage;
run;quit;

* LOG: NOTE: DATA SET "WD1X.WD1_CLASSAGES" HAS 6 OBSERVATION(S) AND 3 VARIABLE(S);

options nolabel;
proc sql;
  select libname, memname from dic.vtable where libname in ("WD1X", "SD1X", "MYDB")
;quit;

* SAS AND THE SLC DO NOT PROVIDE DICTIONARY INFORMATION ON EXTERNAL DATABASES;
* YOU NEED TO QUERY THE DATABASE DICTIONARY TABES. THIS IS NORMAL.

/*---
Altair SLC

  LIBNAME   MEMNAME
  ------------------------------------------
  SD1X      SD1_CLASSAGES
  WD1X      CLASSAGES
---*/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1507      ODS _ALL_ CLOSE;
1508      FILENAME WPSWBHTM TEMP;
NOTE: Writing HTML(WBHTML) BODY file d:\wpswrk\_TD16284\#LN00095
1509      ODS HTML(ID=WBHTML) BODY=WPSWBHTM GPATH="d:\wpswrk\_TD16284";
1510
1511      %utlfkil(%sysfunc(pathname(WPSWBHTM))); /*-- disable precode --*/
1512      &_init_;
1513
1514      libname mydb odbc noprompt=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
NOTE: Library mydb assigned as follows:
      Engine:        ODBC
      Physical Name:  (SQLite version 3.43.2)

Altair SLC

The DATASETS Procedure

     Directory

Libref         MYDB
Engine         ODBC
Data Source
1515
1516      proc datasets lib=mydb;
NOTE: No matching members in directory
1517        delete classage;
1518      run;quit;
NOTE: Deleting "MYDB.CLASSAGE" (memtype="DATA")
NOTE: Procedure datasets step took :
      real time : 0.268
      cpu time  : 0.093


1519
1520      * LOG: NOTE: DELETING "MYDB.CLASSAGE" (MEMTYPE="DATA");
1521
1522      data mydb.classage;
1523        input
1524          name$
1525          sex$ age;
1526      cards4;

NOTE: Data set "MYDB.classage" has an unknown number of observation(s) and 3 variable(s)
NOTE: The data step took :
      real time : 0.340
      cpu time  : 0.031


1527      Alfred  M 14
1528      Alice   F 11
1529      Barbara F 15
1530      Carol   F 17
1531      Henry   M 11
1532      James   M 18
1533      ;;;;
1534      run;quit;
1535
1536      * LOG: NOTE: DATA SET "MYDB.CLASSAGE" HAS AN UNKNOWN NUMBER OF OBSERVATION(S) AND 3 VARIABLE(S);
1537
1538      proc print data=mydb.classage;
1539      run;
NOTE: 6 observations were read from "MYDB.classage"
NOTE: Procedure print step took :
      real time : 0.152
      cpu time  : 0.062


1540
1541      /*---
1542      LISTING
1543      Altair SLC
1544
1545      Obs    NAME        SEX         AGE
1546
1547       1     Alfred      M            14
1548       2     Alice       F            11
1549       3     Barbara     F            15
1550       4     Carol       F            17
1551       5     Henry       M            11
1552      ---*/
1553
1554      proc sql;
1555        select * from mydb.sqlite_master
1556        where type = 'table';
WARNING: truncating character column type to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column name to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column tbl_name to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column sql to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column TYPE to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column NAME to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column TBL_NAME to 1024 characters long, based on dbmax_text setting.
WARNING: truncating character column SQL to 1024 characters long, based on dbmax_text setting.
1557      quit;
NOTE: Procedure sql step took :
      real time : 0.135
      cpu time  : 0.031


1558
1559      * LISTING: CREATE TABLE classage( NAME VARCHAR(8), SEX VARCHAR(8), AGE DOUBLE PRECISION );
1560
1561      libname wd1x wpd "d:/sd1";
NOTE: Library wd1x assigned as follows:
      Engine:        WPD
      Physical Name: d:\sd1

1562      data wd1x.wd1_classages;
1563        set mydb.classage;
1564      run;

NOTE: 6 observations were read from "MYDB.classage"
NOTE: Data set "WD1X.wd1_classages" has 6 observation(s) and 3 variable(s)
NOTE: The data step took :
      real time : 0.095
      cpu time  : 0.015


1564    !     quit;
1565
1566      * LOG: NOTE: DATA SET "SD1X.SD1_CLASSAGESQLITE" HAS 6 OBSERVATION(S) AND 3 VARIABLE(S);
1567
1568      libname sd1x sas7bdat "d:/sd1";
NOTE: Library sd1x assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\sd1

1569      data sd1x.sd1_classages;
1570        set mydb.classage;
1571      run;

NOTE: 6 observations were read from "MYDB.classage"
NOTE: Data set "SD1X.sd1_classages" has 6 observation(s) and 3 variable(s)
NOTE: The data step took :
      real time : 0.099
      cpu time  : 0.015


1571    !     quit;
1572
1573      * LOG: NOTE: DATA SET "WD1X.WD1_CLASSAGES" HAS 6 OBSERVATION(S) AND 3 VARIABLE(S);
1574
1575      options nolabel;
1576      proc sql;
1577        select libname, memname from dic.vtable where libname in ("WD1X", "SD1X", "MYDB")
1578      ;quit;
NOTE: View opening spill file for output observations.
NOTE: Procedure sql step took :
      real time : 0.118
      cpu time  : 0.046


1579
1580      * SAS AND THE SLC DO NOT PROVIDE DICTIONARY INFORMATION ON EXTERNAL DATABASES;
1581      * YOU NEED TO QUERY THE DATABASE DICTIONARY TABES. THIS IS NORMAL.
1582
1583      /*---
1584      Altair SLC
1585
1586        LIBNAME   MEMNAME
1587        ------------------------------------------
1588        SD1X      SD1_CLASSAGES
1589        WD1X      CLASSAGES
1590      ---*/
1591
1592      quit; run;
1593      ODS _ALL_ CLOSE;
1594      FILENAME WPSWBHTM CLEAR;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
