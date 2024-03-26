create database svsv;
use svsv;
create table t1(vid int primary key, vaddr varchar(50), vmobile int, vname varchar(50));

create table t2(vid int, firid int, firdescrp varchar(50), firdate date, caseid int,primary key(vid, firid));
alter table t2 add foreign key(vid) references t1(vid);

create table t3(crid int primary key, crname varchar(50), crmobile int, crimedet varchar(50));

create table t4(pid int, crid int, arrestdate date,primary key(pid, crid));
alter table t4 add foreign key(crid) references t3(crid);

create table t5(caseid int, firid int, casedescrp varchar(50), cstatus varchar(50), evidence varchar(50),primary key(caseid,firid));
#alter table t5 add foreign key(firid) references t2(firid);  

create table t6(pid int, psid int,primary key(pid, psid));
alter table t6 add foreign key(pid) references t4(pid);

create table t7(psid int primary key, psaddr varchar(50));

create table t8(caseid int, psid int);
alter table t8 add foreign key(psid) references t7(psid);
alter table t8 add foreign key(caseid) references t5(caseid);

alter table t6 add foreign key(psid) references t7(psid);
alter table t2 add foreign key(caseid) references t5(caseid);

insert into t1 values(1,"abc", 123, "sri");
insert into t1 values(2,"def", 596, "vyshu");

insert into t2 values(1, 56, "ghi", '2020-03-19', 553);
insert into t2 values(2, 93, "jkl", '2020-12-20', 280);

insert into t3 values(586, "parul", 106, "mno9");
insert into t3 values(993, "rachel", 218, "pqr18");

insert into t4 values(207, 586, '2020-04-20');
insert into t4 values(208, 993, '2021-03-15');

insert into t5 values(553, 56, "xyz1", "complete", "knife");
insert into t5 values(280, 93, "lmn2", "complete", "gun");

insert into t6 values(207, 111);
insert into t6 values(208, 125);

insert into t7 values(111, "vag");
insert into t7 values(125, "svc");

insert into t8 values(553, 111);
insert into t8 values(280, 125);

select *from t1;
select *from t2;
select *from t3;
select *from t4;
select *from t5;
select *from t6;
select *from t7;
select *from t8;

#queries
#who is the criminal for given caseid
select crname from t3 where crid=(select crid from t4  where pid=(select pid from t6 where psid=(select psid from t8 where caseid=553)));

#victim details for given caseid
select *from t1 where vid=(select vid from t2 where caseid=280);

#arrest date for the case of given victim name
select arrestdate from t4 where pid=(select pid from t6 where psid=(select psid from t8 where caseid = (select caseid from t2 where vid=(select vid from t1 where vname = "vyshu"))));