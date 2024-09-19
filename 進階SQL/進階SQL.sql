
-- 1. 查詢學過 "c001" 並且也學過 "c002" 的同學的學號、姓名
SELECT DISTINCT s1.sno, s1.sname
FROM sc s1
JOIN sc s2 ON s1.sno = s2.sno
WHERE s1.cno = 'c001' AND s2.cno = 'c002';

-- 2. 查詢老師 “諶燕” 所上的課程數量
SELECT COUNT(*)
FROM course
JOIN teacher ON course.tno = teacher.tno
WHERE teacher.tname = '諶燕';

-- 3. 查詢所有老師所上的課程數量
SELECT teacher.tname, COUNT(course.cno) AS courses_taught
FROM teacher
JOIN course ON teacher.tno = course.tno
GROUP BY teacher.tname;

-- 4. 查詢沒學過 "諶燕" 老師講授的任一門課程的學號、學生姓名
SELECT student.sno, student.sname
FROM student
WHERE student.sno NOT IN (
    SELECT sc.sno
    FROM sc
    JOIN course ON sc.cno = course.cno
    WHERE course.tno IN (
        SELECT tno
        FROM teacher
        WHERE tname = '諶燕'
    )
);

-- 5. 查詢 'c001' 課程比 'c002' 課程成績高的所有學生的學號
SELECT s1.sno
FROM sc s1
JOIN sc s2 ON s1.sno = s2.sno
WHERE s1.cno = 'c001' AND s2.cno = 'c002' AND s1.score > s2.score;

-- 6. 查詢與學號為 "s001" 一起上過課的同學的學號和姓名
SELECT DISTINCT student.sno, student.sname
FROM sc
JOIN student ON sc.sno = student.sno
WHERE sc.cno IN (
    SELECT cno
    FROM sc
    WHERE sno = 's001'
) AND sc.sno != 's001';

-- 7. 查詢平均成績大於60分且小於80分的同學的學號和平均成績
SELECT sc.sno, AVG(sc.score) AS avg_score
FROM sc
GROUP BY sc.sno
HAVING avg_score > 60 AND avg_score < 80;

-- 8. 請依照年紀，統計已畢業跟在學的人數，以22歲(含)為判斷在學依據
SELECT 
    SUM(CASE WHEN sage <= 22 THEN 1 ELSE 0 END) AS studying,
    SUM(CASE WHEN sage > 22 THEN 1 ELSE 0 END) AS graduated
FROM student;

-- 9. 請找出名字中有 "蕭" 的同學
SELECT sno, sname
FROM student
WHERE sname LIKE '%蕭%';
