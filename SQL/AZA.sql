select * from user_sequences

INSERT
INTO USERS
VALUES('teacher51','teacher52','teacher5','teacher5','55555',null,null,null,null,0,null,null);

INSERT
INTO USERS
VALUES('teacher52','teacher52','teacher5','teacher5','5252',null,null,null,null,0,null,null);

INSERT
INTO USERS
VALUES('student5','student5','student5','stduent5','525252','고등학교',null,null,null,0,null,null);

INSERT
INTO USERS
VALUES('parent5','parent5','parent5','parent5','123123',null,null,null,null,0,null,null);

INSERT
INTO LESSON 
VALUES ('abcd1234','teacher51','鍮꾪듃怨�1 �옄諛�','�썡�닔湲�','09:00','21:00','鍮꾪듃',40000,'java','�븞�뀞�븯�꽭�슂',TO_CHAR(sysdate, 'yyyy/mm/dd HH24:MI:SS'));

INSERT
INTO LESSON 
VALUES ('','teacher51','�옄諛� ���씠�븨','�썡�닔湲�','09:00','21:00','鍮꾪듃',40000,'java','�븞�뀞�븯�꽭�슂',TO_CHAR(sysdate, 'yyyy/mm/dd HH24:MI:SS'));

INSERT
INTO LESSON 
VALUES ((SELECT DBMS_RANDOM.STRING('X', 8) STR FROM DUAL),'teacher51','鍮꾪듃2 �옄諛�','�넗�씪','09:00','21:00','鍮꾪듃',90000,'java','�븞�뀞�븯�꽭�슂',TO_CHAR(sysdate, 'yyyy/mm/dd HH24:MI:SS'));

INSERT 
INTO LESSON
VALUES ('agho1216','teacher51','鍮꾪듃怨�3 �뙆�씠�뜫','�솕紐�','09:00','21:00','鍮꾪듃',40000,'python','�븯�씠猷�',TO_CHAR(sysdate, 'yyyy/mm/dd HH24:MI:SS'));

INSERT 
INTO LESSON
VALUES ('abcd4321','teacher52','鍮꾪듃怨�2 �뙆�씠�뜫','�넗�씪','11:00','20:00','媛뺣궓',80000,'javascript','鍮꾩떥�떎鍮꾩떥�떎',TO_CHAR(sysdate, 'yyyy/mm/dd HH24:MI:SS'));

/*book*/
INSERT
INTO BOOK
VALUES('9788997924325','�옄諛붿쓽 �떊','�뼱�뵒吏�','20000','�씠�긽誘�','2017-01=01','IMG');

INSERT
INTO BOOK 
VALUES('12312312355487','�끉�뼱','�뼱�뵒吏�','20000','怨듭옄','2010-01=01','IMG');

INSERT
INTO BOOK 
VALUES('99','援�媛�濡�','�뿬湲�','20000','�뵆�씪�넠','2010/03/01','IMG');

insert
INTO BOOK
VALUES('11',',TEST1','TEST','TEST','TEST','TEST','TEST');

-- test lesson delete and book --

INSERT
INTO BOOK 
VALUES('99','援�媛�濡�','�뿬湲�','20000','�뵆�씪�넠','2010/03/01','IMG');
INSERT
INTO LESSON_BOOK
VALUES(
SEQ_LESSON_BOOK_BOOK_CODE.nextVal,
(SELECT lesson_code FROM lesson WHERE lesson_code='11111111'),
(SELECT isbn FROM BOOK WHERE ISBN = '1111'));

INSERT
INTO BOOK 
VALUES('1111','�늻媛� �궡 移섏쫰 �썡移�?','�븷湲�','10000','寃쏀샇','2015/03/01','IMG');


--lesson_book
INSERT
INTO LESSON_BOOK
VALUES(
SEQ_LESSON_BOOK_BOOK_CODE.nextVal,
(SELECT lesson_code FROM lesson WHERE lesson_code='abcd1234'),
(SELECT isbn FROM BOOK WHERE ISBN = '9788997924325'));

INSERT
INTO LESSON_BOOK
VALUES(
SEQ_LESSON_BOOK_BOOK_CODE.nextVal,
(SELECT lesson_code FROM lesson WHERE lesson_code='abcd4321'),
(SELECT isbn FROM BOOK WHERE ISBN = '12312312355487'));

INSERT
INTO LESSON_BOOK
VALUES(
SEQ_LESSON_BOOK_BOOK_CODE.nextVal,
(SELECT lesson_code FROM lesson WHERE lesson_code='abcd4321'),
(SELECT isbn FROM BOOK WHERE ISBN = '99'));

--//STUDENTS_RECORD
INSERT
INTO STUDENTS_RECORD
VALUES(seq_students_record.nextVal,'W5MFIVX7',(SELECT lesson_name FROM lesson WHERE lesson_code = 'W5MFIVX7'),'student1','금쪽이',1,TO_CHAR(sysdate),40000,0);

INSERT
INTO STUDENTS_RECORD
VALUES(seq_students_record.nextVal,'agho4567',(SELECT lesson_name FROM lesson WHERE lesson_code = 'agho4567'),'student5','student',1,TO_CHAR(sysdate),40000,0);

INSERT
INTO STUDENTS_RECORD
VALUES(seq_students_record.nextVal,'ZKIECEUA',(SELECT lesson_name FROM lesson WHERE lesson_code = 'ZKIECEUA'),'student5','student',1,TO_CHAR(sysdate),40000,0);

INSERT
INTO STUDENTS_RECORD
VALUES(seq_students_record.nextVal,'agho4567','student5',0,TO_CHAR(sysdate),40000,0);

INSERT
INTO STUDENTS_RECORD
VALUES(seq_students_record.nextVal,'abcd4321','student5',0,TO_CHAR(sysdate),40000,0);

INSERT
INTO STUDENTS_RECORD
VALUES(seq_students_record.nextVal,'agho1216','student52',0,TO_CHAR(sysdate),40000,0);

INSERT
INTO schdule
 ==========================================
/* getLesson*/
SELECT * from lesson
where lesson_code like 'abcd1234';

/* updateLesson */
UPDATE lesson
SET lesson_name = '鍮꾪듃珥�2 c�뼵�뼱',
	lesson_day = '�썡 湲�',
	lesson_place = '鍮꾪듃珥� 2-2諛�',
	fees = '300000',
	subject = 'c�뼵�뼱',
	le.lesson_content='�뼱由곗씠 �뿬�윭遺� �븞�눦?'
WHERE lesson_name like '鍮꾪듃怨�1 �옄諛�';

UPDATE lesson le, students_record sr
SET le.lesson_name = '鍮꾪듃珥�3 c�뼵�뼱',
	sr.fees = 10000
where le.lesson_code = sr.lesson_code AND lesson_name like '鍮꾪듃怨�1 �옄諛�';

/* deleteLesson */
DELETE FROM lesson
WHERE lesson_code like 'abcd1234';

/* listLesson �닔�뾽紐�, �븰�깮紐� */
SELECT * FROM LESSON
ORDER BY lesson_create_at DESC;

select *
from lesson
where lesson_name like '%鍮꾪듃怨�3 �뙆�씠�뜫%';

SELECT *
FROM lesson le, students_record sr
where le.lesson_code = sr.lesson_code and student_id like 'student52';

select *
from lesson
where lesson_create_at between '2022/05/30 00:00:00' AND '2022/05/31 23:59:59';

/* �꽑�깮�떂 */
SELECT*
FROM (SELECT inner_table.*
	FROM (SELECT * FROM lesson
		WHERE lesson_name like '%鍮꾪듃%' 
		ORDER BY lesson_create_at DESC) inner_table
	WHERE lesson_create_at <='20220531' AND teacher_id = 'teacher51')
WHERE lesson_create_at > '2022/05/30 00:00:00';
--WHERE lesson_create_at between '2022/05/30 00:00:00' AND '20220531 23:59:59';

SELECT L.lesson_name, L.teacher_id, U.user_name, L.lesson_day, L.lesson_start_time, L.lesson_end_time, L.subject, L.lesson_code
		FROM LESSON L, USERS U 
		WHERE L.teacher_id = U.user_id and L.teacher_id = 'teacher51'
		ORDER BY L.lesson_create_at desc;
		
		
select user_name from users where user_id='teacher52')


--list lesson parent
SELECT L.*
FROM LESSON L, (SELECT SR.lesson_code SRL, SR.student_id SRI
    FROM students_record SR, (SELECT student_id SI
            FROM users U, relation R
            WHERE U.user_id = R.parent_id AND U.user_id = 'parent5') A
    WHERE SR.student_id = A.SI) B
WHERE L.lesson_code = B.SRL

--insert
INSERT 
INTO LESSON	
VALUES ((SELECT DBMS_RANDOM.STRING('X', 8) STR FROM DUAL),
		(SELECT techer_id FROM USERS WHERE user_id = 'teacher52'),
		(select user_name from users where user_id='teacher52'),
 		#{lessonName}, #{lessonDay},
		#{lessonStartTime},#{lessonEndTime}, #{lessonPlace}, #{fees}, #{subject}, #{lessonContent:VARCHAR}, 
		TO_CHAR(sysdate, 'yyyy/mm/dd HH24:MI:SS'))
/*�꽑�깮�떂 �떎�떆 �븳嫄�*/
SELECT*
FROM (SELECT inner_table.*, ROWNUM AS row_seq
	FROM (SELECT L.lesson_name, U.user_name, L.lesson_day, L.lesson_start_time, L.lesson_end_time,L.lesson_place, L.subject, L.lesson_code
		FROM LESSON L, USERS U 
		WHERE L.teacher_id = U.user_id  AND teacher_id = 'teacher52'
		ORDER BY L.lesson_create_at desc) inner_table
		WHERE ROWnUM <= 3) inner_table
	WHERE row_seq BETWEEN 1 and 3;

/*�븰�깮 �떎�떆 �븳嫄�*/
SELECT L.lesson_name,  U.user_name, SR.proposal
FROM LESSON L, STUDENTS_RECORD SR, USERS U
WHERE L.lesson_code = SR.lesson_code and L.teacher_id = U.user_id and SR.student_id ='student5';

select*from lesson l, students_record sr where l.lesson_code = sr.lesson_code and sr.student_id ='student5';

SELECT*
		FROM (SELECT inner_table.*, ROWNUM AS row_seq		
			FROM(
				SELECT L.lesson_name,  U.user_name, L.lesson_day, L.lesson_start_time, L.lesson_end_time, L.subject, L.lesson_code, SR.proposal, L.lesson_place
				FROM LESSON L, STUDENTS_RECORD SR, USERS U
				WHERE L.lesson_code = SR.lesson_code and L.teacher_id = U.user_id and SR.student_id = 'student5'
				ORDER BY L.lesson_create_at desc			
			 )inner_table
				WHERE ROWNUM < = 3)
			WHERE row_seq BETWEEN 1 and 3;
/*====================================*/

SELECT*
FROM (SELECT inner_table.*
	FROM (SELECT * FROM lesson
		WHERE student_id like 'student5'
		ORDER BY lesson_create_at DESC) inner_table
	WHERE lesson_create_at <='20220531')
WHERE lesson_create_at between '2022/05/30 00:00:00' AND '20220531 23:59:59';


select*from lesson le, students_record sr
where le.lesson_code = sr.lesson_code AND student_id = 'student5'
order by lesson_create_at desc;



/* �몮�씠 媛숈� 肄붾뱶*/
select*from lesson le, students_record sr
where le.lesson_code = sr.lesson_code AND sr.student_id = 'student5'
ORDER BY le.lesson_create_at desc;

select *
from lesson le, (select*from students_record
		where student_id = 'student5') sr
WHERE le.lesson_code = sr.lesson_code AND sr.student_id = 'student5';

--getTotalCount
SELECT COUNT(*)
FROM (SELECT *FROM LESSON)
WHERE teacher_id = 'teacher51';
/*=================================================================*/

CREATE OF REPLACE TRIGGER TR_BOOK
	AFTER INSERT
	ON BOOK
	FOR EACH ROW
BEGIN
	INSERT INTO LESSON_BOOK VALUES()
	
	


CREATE OR REPLACE TRIGGER TR_BOOK
BEFORE INSERT ON BOOK
FOR EACH ROW
    BEGIN
    IF INSERTING THEN
        INSERT INTO LESSON_BOOK('11','�깉�슦醫뗭븘','���띁','70000','�늻援ъ�','2022/06/01','IMG');
        VALUES (::ISBN);
    END IF;
END TR_STUDENT_TEST;

--�궘�젣 �맂 �썑


CREATE OR REPLACE TRIGGER TR_BOOK
	AFTER INSERT ON BOOK
	FOR EACH ROW
	BEGIN
		
	END 


--�뀒�씠釉� �젣�빟議곌굔 寃��깋
SELECT CONSTRAINT_NAME, STATUS
FROM ALL_CONSTRAINTS
WHERE TABLE_NAME='LESSON_BOOK';
--�젣�빟議곌굔 �궘�젣
ALTER TABLE LESSON_BOOK DROP CONSTRAINT lESSON_BOOK_DELETE;

/* Book=================*/
/* add book*/
INSERT ALL
	INTO BOOK VALUES('19981216','�븞寃쏀샇','�옄�꽌�쟾','1000000','�븞寃쏀샇','2030/12/16','IMG')
	INTO LESSON_BOOK VALUES(SEQ_LESSON_BOOK_BOOK_CODE.nextVal,'agho1216','19981216')
	SELECT*FROM DUAL;
(SELECT lesson_code FROM lesson WHERE lesson_code='11111111'),
(SELECT isbn FROM BOOK WHERE ISBN = '1111'));

/* listLesson Book teacher*/
select *
from (select inner_table.*, ROWNUM AS row_seq
	FROM (SELECT B.book_title, B.author, B.publisher, B.book_year, B.book_price, L.lesson_name,LB.lesson_code
		FROM BOOK B, LESSON_BOOK LB, LESSON L
		WHERE B.ISBN=LB.ISBN AND LB.lesson_code = L.lesson_code and L.teacher_id = 'teacher51') inner_table
		WHERE rownum<3)
WHERE ROW_SEQ BETWEEN 1 AND 3;		

and L.lesson_code = 'agho1216';

/*listLesson Book students*/

SELECT B.book_title, B.author, B.publisher, B.book_year, B.book_price, A.LN
FROM  LESSON_BOOK LB, BOOK B ,(SELECT L.lesson_code LC, L.lesson_name LN
        FROM LESSON L, STUDENTS_RECORD SR, USERS U
        WHERE L.lesson_code = SR.lesson_code and L.teacher_id = U.user_id and SR.student_id = 'student5') A
WHERE A.LC = LB.lesson_code AND LB.isbn = B.isbn


/* deleteLessonBook*/
delete from lesson_book
where isbn = '987654321';

--DELETE
--FROM book B
--where EXISTS(
--	SELECT *
--	FROM lesson_BOOK LB
--	WHERE B.ISBN = LB.ISBN AND B.ISBN ='1111' and LB.isbn='1111'
--);
	
/*addlessonschedule*/
INSERT
INTO schedule
VALUES(SEQ_SCHEDULE_SCHEDULE_CODE.nextVal,(SELECT user_id FROM USERS WHERE user_id = 'teacher51'),TO_CHAR(sysdate,'yyyy/mm/dd'),TO_CHAR(sysdate,'HH24:MI:SS'),'2022/07/01',null,'怨듬�','�씪�젙api');

(SELECT user_id FROM USERS WHERE user_id = 'teacher51'));

INSERT INTO schedule 
		VALUES (seq_schedule_schedule_code.nextval,
		(SELECT user_id FROM USERS WHERE user_id = 'teacher51'),#{scheduleStartDate},#{scheduleStartTime:VARCHAR},
		#{scheduleEndDate},#{scheduleEndTime:VARCHAR},#{scheduleContent})

/*getLessonschedule*/
SELECT * FROM schedule
WHERE schedule_code = 1021;

SELECT L.lesson_name, S.schedule_start_date, S.schedule_end_date, S.schedule_start_time, S.schedule_end_time, S.schedule_content
FROM schedule S, users U, lesson L
WHERE S.teacher_id = u.user_id AND L.teacher_id = U.user_id  AND S.teacher_id = 'teacher51' AND S.schedule_code=1001; 

/*getLessonSchedule 理쒖쥌*/
SELECT S.schedule_start_date, S.schedule_end_date, S.schedule_start_time, S.schedule_end_time, S.schedule_content
FROM schedule S, users U
WHERE S.teacher_id = u.user_id AND S.schedule_code=1001;

/*udpateLessonSchedule*/
UPDATE schedule
SET schedule_Start_Date = TO_CHAR(sysdate,'yyyy/mm/dd'),
	schedule_End_Date = '2022/06/16',
	schedule_Start_Time = TO_CHAR(sysdate,'HH24:MI:SS'),
	schedule_content = '�솕�씠�똿�븯�옄'
WHERE schedule_start_date ='2022/05/31' AND schedule_start_time='19:06:13' and teacher_id='teacher51';

UPDATE schedule
SET schedule_Start_Date ='2022/06/04',
	schedule_End_Date = '2022/06/05',
	schedule_Start_Time = TO_CHAR(sysdate,'HH24:MI:SS'),
	schedule_content = 'why can not change'
WHERE schedule_code = 1021 and teacher_id = 'teacher53';


/*deleteLessonSchedule*/
DELETE 
FROM schedule
WHERE schedule_code = 1021;

/*listLessonSchedule*/
SELECT *
FROM (
	SELECT inner_table.*, ROWNUM AS row_seq
	FROM ( SELECT L.lesson_Name, S.* FROM schedule S, users U, lesson L
			WHERE S.teacher_id = U.user_id and u.user_id = L.teacher_id and L.teacher_id = 'teacher51'
			ORDER BY schedule_start_date || schedule_start_time) inner_table
	WHERE ROWNUM <= 3)
WHERE row_seq BETWEEN 1 AND 10;

SELECT *
FROM (
	SELECT inner_table.*, ROWNUM AS row_seq
	FROM ( SELECT L.lesson_Name, S.* FROM schedule S, users U, lesson L
			WHERE S.teacher_id = U.user_id and u.user_id = L.teacher_id and S.teacher_id = 'teacher51'
			ORDER BY S.schedule_code desc) inner_table
	WHERE ROWNUM <= 3)
WHERE row_seq BETWEEN 1 AND 3;

/*listLessonSchedule students*/
SELECT S.*
FROM schedule S, users U, (SELECT L.teacher_id LT
        FROM students_record SR, lesson L
        WHERE SR.lesson_code = L.lesson_code AND SR.student_id = 'student5') A
WHERE S.teacher_id = U.user_id AND U.user_id = A.LT AND S.teacher_Id = 'teacher51';


select*from schedule
where teacher_id = 'teacher51'
order by schedule_start_date || schedule_start_time;

select 


row count
SELECT COUNT(*)
FROM ( SELECT *	FROM alert
        WHERE receiver_id = 'parent12'
) countTable


/* casecade book & lessonBook */
ALTER TABLE lesson_book ADD CONSTRAINT lesson_book_DELETE
FOREIGN key (isbn)
REFERENCES book(isbn)
on delete cascade;

DROP TRIGGER after_statement_trigger;

CREATE OR REPLACE TRIGGER after_statement_trigger
	AFTER INSERT ExamData
BEGIN
	IF INSERTING THEN
	INSERT INTO ExamMemo(memo) VALUES ('insert');
END;

CREATE OR  REPLACE TRIGGER TR_BOOK
AFTER INSERT  of BOOK ON 


--listchat
SELECT *
FROM (
	SELECT inner_table.*, ROWNUM AS row_seq
	FROM ( SELECT L.lesson_Name, S.* FROM schedule S, users U, lesson L
			WHERE S.teacher_id = U.user_id and u.user_id = L.teacher_id and teacher_id = 'teacher51'
			ORDER BY schedule_start_date || schedule_start_time) inner_table
	WHERE ROWNUM <= 3)
WHERE row_seq BETWEEN 1 AND 3;

--而щ읆 �궘�젣
ALTER TABLE emp DROP COLUMN email;

