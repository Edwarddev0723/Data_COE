
-- 1. 將男同學的年齡統一增加1歲並更新於資料表中
UPDATE student
SET sage = sage + 1
WHERE ssex = '男';

-- 2. 刪除學號為 's013' 的學生資料
DELETE FROM student
WHERE sno = 's013';

-- 3. 查詢所有課程成績小於60 分的同學的學號、姓名
SELECT sc.sno, student.sname
FROM sc
JOIN student ON sc.sno = student.sno
WHERE sc.score < 60;

-- 4. 查詢老師 “諶燕” 所帶的課程數量
SELECT COUNT(*) AS course_count
FROM course
JOIN teacher ON course.tno = teacher.tno
WHERE teacher.tname = '諶燕';

-- 5. 查詢任何一門課程成績在70分以上的學生姓名、課程名稱和分數
SELECT student.sname, course.cname, sc.score
FROM sc
JOIN student ON sc.sno = student.sno
JOIN course ON sc.cno = course.cno
WHERE sc.score > 70;

-- 6. 查詢成績表所有成績的最低分、平均分、總分
SELECT MIN(score) AS lowest_score, AVG(score) AS average_score, SUM(score) AS total_score
FROM sc;

-- 7. 查詢所有學生的選課課程名稱
SELECT student.sname, course.cname
FROM sc
JOIN student ON sc.sno = student.sno
JOIN course ON sc.cno = course.cno;

-- 8. 查詢成績總和在100分以下的學生姓名、課程名稱和分數
SELECT student.sname, course.cname, sc.score
FROM sc
JOIN student ON sc.sno = student.sno
JOIN course ON sc.cno = course.cno
GROUP BY student.sname, course.cname, sc.score
HAVING SUM(sc.score) < 100;

-- 9. 檢索'c004'課程分數小於60, 按分數降序排列的同學學號
SELECT sc.sno
FROM sc
WHERE sc.cno = 'c004' AND sc.score < 60
ORDER BY sc.score DESC;

-- 10. 查詢年紀最小跟最大的學生名單
SELECT sname, sage
FROM student
WHERE sage = (SELECT MIN(sage) FROM student)
   OR sage = (SELECT MAX(sage) FROM student);
