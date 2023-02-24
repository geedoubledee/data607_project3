CREATE DATABASE IF NOT EXISTS dat_sci_jobs;

DROP TABLE IF EXISTS _Sites;
DROP TABLE IF EXISTS _Jobs;

CREATE TABLE _Sites
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
	(977141, "Python Job Board", "https://www.python.org/jobs/");
    
CREATE TABLE _Jobs
(
	Job_id int NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    Job_title varchar(255) NOT NULL,
    Job_url varchar(255) NOT NULL,
    Site_id int REFERENCES _Sites(Site_id),
    Job_complete boolean
);