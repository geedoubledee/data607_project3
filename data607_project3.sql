CREATE DATABASE IF NOT EXISTS dat_sci_jobs;

CREATE TABLE IF NOT EXISTS _Sites
(
	Site_id int NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    Site varchar(50) NOT NULL,
    Site_url varchar(255) NOT NULL UNIQUE
);

INSERT INTO _Sites(Site_id, Site, Site_url)
VALUES
	(2593879, "Indeed", "https://www.indeed.com/"),
    (2594160, "ai-jobs.net", "https://ai-jobs.net/"),
	(2594162, "CareerCast IT & Engineering", "https://it.careercast.com/"),
	(2594166, "Open Data Science Job Portal", "https://jobs.opendatascience.com/"),
	(1378327, "Jobs for R-Users", "https://www.r-users.com/"),
	(2594174, "MLconf Job Board", "https://mlconf.com/jobs/"),
	(977141, "Python Job Board", "https://www.python.org/jobs/"),
    (1001, "LinkedIn", "https://www.linkedin.com/jobs/");
    
CREATE TABLE IF NOT EXISTS _Jobs
(
	Job_id int NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    Job_title varchar(255) NOT NULL,
    Job_url varchar(255) NOT NULL,
    Site_id int REFERENCES _Sites(Site_id),
    Job_complete boolean
);

ALTER TABLE _Jobs ADD COLUMN Job_company varchar(100) AFTER Job_url;
ALTER TABLE _Jobs ADD COLUMN Job_location varchar(75) AFTER Job_company;