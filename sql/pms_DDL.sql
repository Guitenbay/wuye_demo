DROP TABLE IF EXISTS community;
DROP TABLE IF EXISTS residence;
DROP TABLE IF EXISTS residence_record;
DROP TABLE IF EXISTS resident;
DROP TABLE IF EXISTS property_record;
DROP TABLE IF EXISTS parking_space;
DROP TABLE IF EXISTS temporary_pks;
DROP TABLE IF EXISTS rented_pks;
DROP TABLE IF EXISTS purchased_pks;
DROP TABLE IF EXISTS vehicle;
DROP TABLE IF EXISTS payment_record;
DROP TABLE IF EXISTS property_fee_record;
DROP TABLE IF EXISTS pks_fee_record;
DROP TABLE IF EXISTS pks_management_fee_record;
DROP TABLE IF EXISTS pks_resident;
DROP TABLE IF EXISTS equipment_info;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS equipment_record;
DROP TABLE IF EXISTS repair_order;
DROP TABLE IF EXISTS inspect_record;
DROP TABLE IF EXISTS maintenance_record;
DROP TABLE IF EXISTS complaint_order; 

CREATE TABLE community (
	community_id		varchar(8) NOT NULL,
	community_name		varchar(64) NOT NULL,
	pks_purchase_fee	numeric(10, 2) CHECK (pks_purchase_fee >= 0),
	pks_rental_fee		numeric(8, 2) CHECK (pks_rental_fee >= 0),
	residence_price		numeric(8, 2) CHECK (residence_price >= 0),
	PRIMARY KEY (community_id)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic; 

CREATE TABLE residence (
	residence_id	varchar(8) NOT NULL,
	floor_num	numeric(3, 0) NOT NULL,
	unit_num	numeric(4, 0) CHECK (unit_num > 0),
	room_num	numeric(5, 0) CHECK (room_num > 0),
	area		numeric(6, 2) CHECK (area > 0),
	PRIMARY KEY (residence_id)
);

CREATE TABLE residence_record (
	community_id	varchar(8) NOT NULL,
	residence_id	varchar(8) NOT NULL,
	residence_state	varchar(3) CHECK (residence_state IN ('YES', 'NO')),
	PRIMARY KEY (community_id, residence_id),
	FOREIGN KEY (community_id) REFERENCES community(community_id) ON DELETE SET cascade,
	FOREIGN KEY (residence_id) REFERENCES residence(residence_id) ON DELETE SET NULL
);

CREATE TABLE resident (
	resident_id	varchar(8) NOT NULL,
	resident_name	varchar(20) NOT NULL,
	phonenumber	varchar(22),
	PRIMARY KEY (resident_id)
);

CREATE TABLE property_record (
	resident_id	varchar(8) NOT NULL,
	residence_id	varchar(8) NOT NULL,
	issue_date	timestamp NOT NULL,
	purchased_fee	numeric(8, 2) CHECK (purchased_fee >= 0),
	PRIMARY KEY (resident_id, residence_id),
	FOREIGN KEY (resident_id) REFERENCES resident(resident_id) ON DELETE SET cascade,
	FOREIGN KEY (residence_id) REFERENCES residence(residence_id) ON DELETE SET cascade
);

CREATE TABLE parking_space (
	pks_id		varchar(6) NOT NULL,
	community_id	varchar(8) NOT NULL,
	pks_state	varchar(5) CHECK (pks_state IN ('IDLE', 'BUSY')),
	pks_type	varchar(5) CHECK (pks_type IN ('TEMPORARY', 'RENTED', 'PURCHASED')),
	PRIMARY KEY (pks_id, community_id),
	FOREIGN KEY (community_id) REFERENCES community(community_id) ON DELETE SET cascade
);

CREATE TABLE temporary_pks (
	pks_id		varchar(6) NOT NULL,
	PRIMARY KEY (pks_id)
);

CREATE TABLE rented_pks (
	pks_id		varchar(6) NOT NULL,
	man_fee		numeric(5, 2) CHECK (man_fee >= 0),
	PRIMARY KEY (pks_id)
);

CREATE TABLE purchased_pks (
	pks_id		varchar(6) NOT NULL,
	man_fee		numeric(5, 2) CHECK (man_fee >= 0),
	PRIMARY KEY (pks_id)
);

CREATE TABLE vehicle (
	license_plate	varchar(20) NOT NULL,
	owner_name	varchar(15) NOT NULL,
	PRIMARY KEY (license_plate)
);

CREATE TABLE payment_record (
	payment_id	varchar(6) NOT NULL,
	payment		numeric(5, 2) CHECK (payment >= 0),
	duration	numeric(3, 1) CHECK (duration > 0),
	start_time	timestamp NOT NULL,
	checked		varchar(3) CHECK (checked in ('YES', 'NO')),
	PRIMARY KEY (payment_id),
);

CREATE TABLE property_fee_record (
	payment_id	varchar(6) NOT NULL,
	resident_id	varchar(8) NOT NULL,
	PRIMARY KEY (payment_id, resident_id),
	FOREIGN KEY (payment_id) REFERENCES payment_record(payment_id),
	FOREIGN KEY (resident_id) REFERENCES resident(resident_id)
);

CREATE TABLE pks_fee_record (
	payment_id	varchar(6) NOT NULL,
	description	varchar(1024) NOT NULL,
	PRIMARY KEY (payment_id),
	FOREIGN KEY (payment_id) REFERENCES payment_record(payment_id),
);

CREATE TABLE pks_management_fee_record (
	payment_id	varchar(6) NOT NULL,
	pks_id		varchar(6) NOT NULL,
	PRIMARY KEY (payment_id, pks_id),
	FOREIGN KEY (payment_id) REFERENCES payment_record(payment_id),
	FOREIGN KEY (pks_id) REFERENCES parking_space(pks_id)
);
	
CREATE TABLE pks_resident (
	resident_id	varchar(8) NOT NULL,
	pks_id		varchar(6) NOT NULL,
	PRIMARY KEY (resident_id, pks_id),
	FOREIGN KEY (resident_id) REFERENCES resident(resident_id),
	FOREIGN KEY (pks_id) REFERENCES parking_space(pks_id)
);

CREATE TABLE equipment_info (
	category	varchar(6) CHECK (category IN ('OUTDOOR', 'INDOOR')),
	equipment_type	varchar(15) NOT NULL,
	check_period	numeric(2, 0) CHECK (check_period > 0),
	repair_fee	numeric(5, 2) CHECK (repair_fee >= 0),
	PRIMARY KEY (category, equipment_type)
);

CREATE TABLE equipment (
	equipment_id	varchar(6) NOT NULL,
	category	varchar(6) CHECK (category IN ('OUTDOOR', 'INDOOR')),
	PRIMARY KEY (equipment_id, category),
	FOREIGN KEY (category) REFERENCES equipment_info(category)
);

CREATE TABLE equipment_record (
	community_id	varchar(8) NOT NULL,
	equipment_id	varchar(6) NOT NULL,
	PRIMARY KEY (community_id, equipment_id),
	FOREIGN KEY (community_id) REFERENCES community(community_id),
	FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE repair_order (
	repair_id	varchar(6) NOT NULL,
	resident_id	varchar(8) NOT NULL,
	equipment_id	varchar(6) NOT NULL,
	issue_date	timestamp NOT NULL,
	repair_reason	varchar(1024),
	processing	varchar(12) CHECK (processing in ('TOBE', 'PROCESSING', 'DONE')),
	process_result	varchar(1024),
	PRIMARY KEY (repair_id, resident_id, equipment_id),
	FOREIGN KEY (resident_id) REFERENCES resident(resident_id),
	FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE inspect_record (
	equipment_id		varchar(6) NOT NULL,
	issue_date		timestamp NOT NULL,
	inspector		varchar(20) NOT NULL,
	waiting_for_repair	varchar(3) CHECK (waiting_for_repair IN ('YES', 'NO')),
	PRIMARY KEY (equipment_id, issue_date),
	FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE maintenance_record (
	equipment_id		varchar(6) NOT NULL,
	issue_date		timestamp NOT NULL,
	maintenance_worker	varchar(20) NOT NULL,
	maintenance_result	varchar(1024),
	PRIMARY KEY (equipment_id, issue_date),
	FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE complaint_order (
	complaint_id	varchar(6) NOT NULL,
	residence_id	varchar(8) NOT NULL,
	category	varchar(22),
	issue_date	timestamp NOT NULL,
	complaint_result varchar(1024),
	PRIMARY KEY (complaint_id, residence_id),
	FOREIGN KEY (residence_id) REFERENCES residence(residence_id)
);
