-- CREATE TABLE
DROP TABLE IF EXISTS Personnel CASCADE;
CREATE TABLE Personnel (
	emp_id INTEGER NOT NULL
);
ALTER TABLE Personnel ADD PRIMARY KEY (emp_id);

DROP TABLE IF EXISTS Absenteeism;
CREATE TABLE Absenteeism (
	emp_id INTEGER NOT NULL,
	absent_date DATE NOT NULL,
	reason_code CHAR(40) NOT NULL,
	severity_points INTEGER NOT NULL,
	CONSTRAINT valid_serverity_points CHECK (severity_points BETWEEN 0 AND 4)
);
ALTER TABLE Absenteeism ADD PRIMARY KEY (emp_id, absent_date);
ALTER TABLE Absenteeism ADD FOREIGN KEY (emp_id) REFERENCES Personnel (emp_id);
--ALTER TABLE Absenteeism ADD CONSTRAINT emp_id FOREIGN KEY (emp_id) REFERENCES Personnel (emp_id);

/*
-- rule1
-- 罰点40以上の場合はクビ
SELECT
	emp_id,
	sum(severity_points)
FROM
	absenteeism
GROUP BY
	emp_id;
*/

/*
-- rule2
-- 2日目以降の欠勤は罰点がつかない
CREATE OR REPLACE FUNCTION update_severity_points
CREATE TRIGGER update_severity_points
	BEFORE UPDATE ON Absenteeism;
*/


-- set VALUES
INSERT INTO Personnel VALUES(1);
INSERT INTO Personnel VALUES(2);

INSERT INTO Absenteeism VALUES(1, '2007-05-01', 'ずる', 4);
INSERT INTO Absenteeism VALUES(1, '2007-05-02', '病気', 2);   --0になる
INSERT INTO Absenteeism VALUES(1, '2007-05-03', '病気', 2);   --0になる
INSERT INTO Absenteeism VALUES(1, '2007-05-05', 'ケガ', 1);
INSERT INTO Absenteeism VALUES(1, '2007-05-06', '病気', 3);   --0になる
INSERT INTO Absenteeism VALUES(2, '2007-05-01', 'ずる', 4);
INSERT INTO Absenteeism VALUES(2, '2007-05-03', '病気', 2);
INSERT INTO Absenteeism VALUES(2, '2007-05-05', 'サボリ', 2);
INSERT INTO Absenteeism VALUES(2, '2007-05-06', 'サボリ', 2); --0になる

-- rule1
-- 罰点40以上の場合はクビ
select
	emp_id,
	sum(severity_points)
from
	absenteeism
group by
	emp_id;




-- check data
TABLE Absenteeism;
