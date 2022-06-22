DROP TABLE replenishment_event cascade;
DROP TABLE responsible_for cascade;
DROP TABLE retailer cascade;
DROP TABLE planogram cascade;
DROP TABLE shelve cascade;
DROP TABLE installed_at cascade;
DROP TABLE point_of_retail cascade;
DROP TABLE ivm cascade;
DROP TABLE has_category cascade;
DROP TABLE product cascade;
DROP TABLE has_other cascade;
DROP TABLE simple_category cascade;
DROP TABLE super_category cascade;
DROP TABLE category cascade;


----------------------------------------
-- Table Creation
----------------------------------------

-- Named constraints are global to the database.
-- Therefore the following use the following naming rules:
--   1. pk_table for names of primary key constraints
--   2. fk_table_another for names of foreign key constraints

CREATE TABLE category (
    category_name   varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_category PRIMARY KEY (category_name)
);

CREATE TABLE simple_category (
    category_name   varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_simple_category PRIMARY KEY (category_name),
    CONSTRAINT fk_simple_category_name FOREIGN KEY (category_name) REFERENCES category(category_name)
);

CREATE TABLE super_category (
    category_name   varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_super_category PRIMARY KEY (category_name),
    CONSTRAINT fk_super_category_name FOREIGN KEY (category_name) REFERENCES category(category_name)
);

CREATE TABLE has_other (
    super_category  varchar(50) NOT NULL,
    category        varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_has_other_category PRIMARY KEY (category),
    CONSTRAINT fk_has_other_super_category FOREIGN KEY (super_category) REFERENCES super_category(category_name),
    CONSTRAINT fk_has_other_category FOREIGN KEY (category) REFERENCES category(category_name)
);

CREATE TABLE product (
    ean     numeric(13, 0)              NOT NULL UNIQUE,
    descr   varchar(100)                NOT NULL,
    category_name     varchar(100)      NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (ean),
    CONSTRAINT fk_product_cat   FOREIGN KEY (category_name) REFERENCES category(category_name)
);

-- pus primary key
CREATE TABLE has_category (
    ean             numeric(13,0)   NOT NULL,
    category_name   varchar(50)     NOT NULL,
    CONSTRAINT pk_has_category PRIMARY KEY (ean, category_name),
    CONSTRAINT  fk_has_category_ean FOREIGN KEY (ean) REFERENCES product(ean),
    CONSTRAINT fk_has_category_cname FOREIGN KEY (category_name) REFERENCES category(category_name)  
);

CREATE TABLE ivm (
    serial_nr   serial  NOT NULL UNIQUE,
    manuf       varchar(50) NOT NULL,
    CONSTRAINT pk_ivm PRIMARY KEY (serial_nr, manuf)
);

CREATE TABLE point_of_retail (
    point_of_retail_name    varchar(100)    NOT NULL UNIQUE,
    district                varchar(50)     NOT NULL,
    county                  varchar(50)     NOT NULL,
    CONSTRAINT pk_point_of_retail PRIMARY KEY (point_of_retail_name)
);

CREATE TABLE installed_at (
    serial_nr               serial          NOT NULL UNIQUE,
    manuf                   varchar(50)     NOT NULL,
    point_of_retail_name    varchar(100)    NOT NULL,
    CONSTRAINT pk_installed_at  PRIMARY KEY (serial_nr, manuf),
    CONSTRAINT fk_installed_at_ivm FOREIGN KEY (serial_nr, manuf) REFERENCES ivm(serial_nr, manuf),
    CONSTRAINT fk_installed_at_place FOREIGN KEY (point_of_retail_name) REFERENCES point_of_retail(point_of_retail_name)
);

CREATE TABLE shelve (
    nr              numeric         NOT NULL CHECK (nr > 0),
    serial_nr       serial          NOT NULL,
    manuf           varchar(50)     NOT NULL,
    height          numeric(10,2)   NOT NULL CHECK (height > 0),
    category_name   varchar(50)     NOT NULL,
    CONSTRAINT pk_shelve PRIMARY KEY (nr, serial_nr, manuf),
    CONSTRAINT fk_shelve_ivm FOREIGN KEY (serial_nr, manuf) REFERENCES ivm(serial_nr, manuf),
    CONSTRAINT fk_shelve_category FOREIGN KEY (category_name) REFERENCES category(category_name)
);

CREATE TABLE planogram (
    ean         numeric(13,0)   NOT NULL,
    nr          numeric         NOT NULL CHECK (nr > 0),
    serial_nr   serial          NOT NULL,
    manuf       varchar(50)     NOT NULL,
    faces       numeric         NOT NULL CHECK (faces > 0),
    nr_units    numeric         NOT NULL CHECK (nr_units > 0),
    loc         varchar(50)     NOT NULL,
    CONSTRAINT pk_planogram PRIMARY KEY (ean, nr, serial_nr, manuf),
    CONSTRAINT fk_planogram_product FOREIGN KEY (ean) REFERENCES product(ean),
    CONSTRAINT fk_planogram_shelve FOREIGN KEY (nr, serial_nr, manuf) REFERENCES shelve(nr, serial_nr, manuf)
);

CREATE TABLE retailer (
    tin             numeric         NOT NULL UNIQUE CHECK (tin > 0),
    retailer_name   varchar(50)     NOT NULL UNIQUE,
    CONSTRAINT pk_retailer PRIMARY KEY (tin)
);

-- pus primary key
CREATE TABLE responsible_for (
    category_name   varchar(50)     NOT NULL,
    tin             numeric         NOT NULL CHECK (tin > 0),
    serial_nr       serial          NOT NULL,
    manuf           varchar(50)     NOT NULL,
    CONSTRAINT pk_responsible_for PRIMARY KEY (category_name, tin, serial_nr, manuf),
    CONSTRAINT fk_responsible_for_category FOREIGN KEY (category_name) REFERENCES category(category_name),
    CONSTRAINT fk_responsible_for_tin FOREIGN KEY (tin) REFERENCES retailer(tin),
    CONSTRAINT fk_responsible_for_ivm FOREIGN KEY (serial_nr, manuf) REFERENCES ivm(serial_nr, manuf)

);

CREATE TABLE replenishment_event (
    ean         numeric(13,0)   NOT NULL,
    nr          numeric         NOT NULL CHECK (nr > 0),
    serial_nr   serial          NOT NULL,
    manuf       varchar(50)     NOT NULL,
    instant     timestamp(2)    NOT NULL,
    nr_units    numeric         NOT NULL CHECK (nr_units > 0),
    tin         numeric         NOT NULL CHECK (tin > 0),
    CONSTRAINT pk_replenishment_event PRIMARY KEY (ean, nr, serial_nr, manuf, instant),
    CONSTRAINT fk_replenishment_event_planogram FOREIGN KEY (ean, nr, serial_nr, manuf) REFERENCES planogram(ean, nr, serial_nr, manuf),
    CONSTRAINT fk_replenishment_event_retailer FOREIGN KEY (tin) REFERENCES retailer(tin)
);