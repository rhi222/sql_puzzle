DROP TABLE IF EXISTS FiscalYearTable1;
CREATE TABLE FiscalYearTable1 (
	fiscal_year INTEGER NOT NULL PRIMARY KEY,
	start_date DATE NOT NULL,
	CONSTRAINT valid_start_date
		CHECK ((EXTRACT(YEAR FROM start_date) = fiscal_year -1)
			AND (EXTRACT(MONTH FROM start_date) = 10)
			AND (EXTRACT(DAY FROM start_date) = 01)),
	end_date DATE NOT NULL,
	CONSTRAINT valid_end_date
		CHECK ((EXTRACT(YEAR FROM end_date) = fiscal_year)
			AND (EXTRACT(MONTH FROM end_date) = 09)
			AND (EXTRACT(DAY FROM end_date) = 30)),
	CONSTRAINT valid_interval
		--CHECK ((end_date - start_date) = INTERVAL '365 DAY')
		CHECK ((end_date - start_date) = '364'::int)
);


--正常データ
INSERT INTO FiscalYearTable1 VALUES(1995, '1994-10-01', '1995-09-30');
INSERT INTO FiscalYearTable1 VALUES(1997, '1996-10-01', '1997-09-30');
INSERT INTO FiscalYearTable1 VALUES(1998, '1997-10-01', '1998-09-30');
--エラーデータ
INSERT INTO FiscalYearTable1 VALUES(1996, '1995-10-01', '1996-08-30');  -- 終了日が8月
INSERT INTO FiscalYearTable1 VALUES(1999, '1998-10-02', '1999-09-30');  -- 開始日が2日
