CREATE TABLE James_WGS_SNP_data
(
	chrid VARCHAR(2) NOT NULL,
	position VARCHAR(50) NOT NULL,
	snpid VARCHAR(50) NOT NULL,
	refallele VARCHAR(256),
	altallele VARCHAR(256),
	filter_dropme1 VARCHAR(1024),
	info_dropme2 VARCHAR(4096),
	format VARCHAR(50),
	results VARCHAR(50),
	PRIMARY KEY(chrid,position)
);