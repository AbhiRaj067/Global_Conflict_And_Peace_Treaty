-- 1) Create database and use it
CREATE DATABASE IF NOT EXISTS global_treaties;
USE global_treaties;


-- 2) country involved in conflicts/treaties
CREATE TABLE country (
  country_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  iso_code CHAR(3),
  region VARCHAR(50)
) ENGINE=InnoDB;

-- 3) conflict -> store major conflicts/events that relate to treaties
CREATE TABLE conflict (
  conflict_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  start_date DATE,
  end_date DATE,
  description TEXT
) ENGINE=InnoDB;

-- 4) venue  -> where treaty negotiations/signings happened.
CREATE TABLE venue (
  venue_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  city VARCHAR(100),
  country_id INT,
  notes TEXT,
  FOREIGN KEY (country_id) REFERENCES country(country_id)
) ENGINE=InnoDB;

-- 5) organization -> international bodies involved (UN, NATO, EEC, Warsaw Pact, etc.)
CREATE TABLE organization (
  organization_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  founded_date DATE,
  description TEXT
) ENGINE=InnoDB;

-- 6) treaty core list of treaties (used 15 specific  treaties)
CREATE TABLE treaty (
  treaty_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  signed_date DATE,
  description TEXT,
  venue_id INT,
  organization_id INT,
  primary_country_id INT,
  conflict_id INT,
  FOREIGN KEY (venue_id) REFERENCES venue(venue_id),
  FOREIGN KEY (organization_id) REFERENCES organization(organization_id),
  FOREIGN KEY (primary_country_id) REFERENCES country(country_id),
  FOREIGN KEY (conflict_id) REFERENCES conflict(conflict_id)
) ENGINE=InnoDB;

-- 7) leader -> key leaders/negotiators associated with diplomatic events.
CREATE TABLE leader (
  leader_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  country_id INT,
  title VARCHAR(150),
  notes TEXT,
  FOREIGN KEY (country_id) REFERENCES country(country_id)
) ENGINE=InnoDB;

-- 8) agreement_term -> store short key clauses or terms of a treaty.
CREATE TABLE agreement_term (
  term_id INT AUTO_INCREMENT PRIMARY KEY,
  treaty_id INT NOT NULL,
  clause_short VARCHAR(255),
  clause_text TEXT,
  FOREIGN KEY (treaty_id) REFERENCES treaty(treaty_id)
) ENGINE=InnoDB;



-- 9) treaty_country (many-to-many) -> link many countries to many treaties (signatories, participants, observers).
CREATE TABLE treaty_country (
  id INT AUTO_INCREMENT PRIMARY KEY,
  treaty_id INT NOT NULL,
  country_id INT NOT NULL,
  role VARCHAR(100),
  notes TEXT,
  FOREIGN KEY (treaty_id) REFERENCES treaty(treaty_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
) ENGINE=InnoDB;



INSERT INTO country (name, iso_code, region) VALUES
('United States','USA','North America'),
('United Kingdom','GBR','Europe'),
('France','FRA','Europe'),
('Germany','DEU','Europe'),
('Italy','ITA','Europe'),
('Japan','JPN','Asia'),
('Soviet Union','SUN','Europe/Asia'),
('China','CHN','Asia'),
('Turkey','TUR','Asia/Europe'),
('Israel','ISR','Asia'),
('Egypt','EGY','Africa'),
('North Vietnam','NVN','Asia'),
('South Vietnam','SVN','Asia'),
('Belarus','BLR','Europe'),
('United Arab Emirates','ARE','Asia'),
('Romania','ROU','Europe'),
('Hungary','HUN','Europe'),
('Bulgaria','BGR','Europe'),
('Finland','FIN','Europe'),
('Canada','CAN','North America'),
('Australia','AUS','Oceania'),
('Poland','POL','Europe'),
('East Germany (GDR)','GDR','Europe'),
('Czechoslovakia','CSK','Europe'),
('Albania','ALB','Europe'),
('Belgium','BEL','Europe'),
('Netherlands','NLD','Europe'),
('Luxembourg','LUX','Europe'),
('Russia','RUS','Europe/Asia'),
('Ukraine','UKR','Europe'),
('Bahrain','BHR','Asia'),
('Austria','AUT','Europe'),
('Ottoman Empire','OTT','Europe/Asia');


SELECT country_id, name, iso_code, region FROM country ORDER BY country_id;

SELECT * FROM country;

INSERT INTO conflict (name, start_date, end_date, description) VALUES
('American Revolutionary War','1775-04-19','1783-09-03','Conflict between Great Britain and its thirteen American colonies resulting in US independence (ended by Treaty of Paris 1783).'),
('Napoleonic Wars','1803-05-18','1815-11-20','Series of wars involving Napoleonic France and various European powers; Congress of Vienna (1815) reorganized Europe after these wars.'),
('World War I','1914-07-28','1918-11-11','Global conflict precipitating the Treaty of Versailles and other settlement treaties.'),
('World War II','1939-09-01','1945-09-02','Global conflict that precipitated the United Nations and post-war treaties.'),
('Cold War','1947-03-12','1991-12-26','Geopolitical tension between Western powers and the Soviet bloc; influenced NATO/Warsaw Pact, NPT, and many treaties.'),
('Vietnam War','1955-11-01','1975-04-30','Conflict in Indochina region; Paris Peace Accords (1973) attempted to end US direct involvement.'),
('Dissolution of the USSR','1991-12-08','1991-12-26','Political event where Soviet republics declared independence; Belavezha Accords declared the USSR effectively dissolved.');




SELECT * FROM conflict ORDER BY conflict_id;



INSERT INTO venue (name, city, country_id, notes) VALUES
('Paris (General)','Paris',3,'Used for Treaty of Paris (1783) & other Paris events'),
('Congress of Vienna Venue','Vienna',32,'Venue for Congress of Vienna (1815) — in Austria'),
('Sèvres Palace','Sèvres',3,'Treaty of Sèvres (1920) signed here (near Paris)'),
('Versailles Palace','Versailles',3,'Hall of Mirrors — Treaty of Versailles (1919)'),
('Moscow Signing Hall','Moscow',7,'Molotov–Ribbentrop pact signing venue (1939)'),
('San Francisco Conference Center','San Francisco',1,'United Nations Charter & San Francisco Treaty (1951) related events'),
('Rome Diplomatic Forum','Rome',5,'Treaty of Rome (1957) signing venue'),
('White House (Washington)','Washington',1,'Abraham Accords signing ceremony (White House) — 2020'),
('Belavezha Conference Hall','Viskuli',14,'Belavezha Accords signed in Belarus (Viskuli/Belavezha Forest)'),
('Brussels NATO Council Chambers','Brussels',26,'NATO related meetings (not formal signing place for all treaties but used for reference)');




SELECT * FROM venue ORDER BY venue_id;



INSERT INTO organization (name, founded_date, description) VALUES
('United Nations','1945-06-26','International organization founded post-WWII to maintain peace and cooperation (Charter signed June 26, 1945; entered into force Oct 24, 1945).'),
('North Atlantic Treaty Organization','1949-04-04','Collective defense alliance (NATO).'),
('European Economic Community','1957-03-25','Treaty of Rome established EEC, precursor to the EU.'),
('Warsaw Pact Organization','1955-05-14','Soviet-led mutual defense pact among Eastern Bloc states (dissolved 1991).'),
('League of Nations','1920-01-10','Predecessor to the UN formed after WWI.');




SELECT * FROM organization ORDER BY organization_id;





INSERT INTO treaty (name, signed_date, description, venue_id, organization_id, primary_country_id, conflict_id) VALUES
('Treaty of Paris (1783)','1783-09-03','Ended the American Revolutionary War; Great Britain recognized US independence.',1,NULL,1,1),
('Congress of Vienna (1815)','1815-06-09','Conference that reorganized Europe after Napoleonic Wars; established balance of power.',2,NULL,32,2),
('Treaty of Sèvres (1920)','1920-08-10','Post-WWI treaty partitioning the Ottoman Empire (later largely superseded by Treaty of Lausanne).',3,NULL,33,3),
('Treaty of Versailles (1919)','1919-06-28','Peace treaty that ended World War I and imposed terms on Germany (reparations, territorial changes).',4,NULL,3,3),
('Molotov–Ribbentrop Pact (1939)','1939-08-23','Non-aggression pact between Nazi Germany and the Soviet Union, included secret protocols dividing spheres of influence.',5,NULL,7,4),
('United Nations Charter (1945)','1945-06-26','Founding charter of the United Nations; signed in San Francisco (entered into force Oct 24, 1945).',6,1,1,4),
('Paris Peace Treaties (1947)','1947-02-10','Series of treaties with former WWII Axis allies (Italy, Romania, Hungary, Bulgaria, Finland).',1,NULL,3,4),
('North Atlantic Treaty (1949)','1949-04-04','Treaty creating NATO (collective defense clause).',10,2,1,5),
('San Francisco Peace Treaty (1951)','1951-09-08','Treaty formally ending the state of war between Japan and Allied powers (post-WWII settlement).',6,NULL,6,4),
('Warsaw Pact (1955)','1955-05-14','Mutual defense treaty between the Soviet Union and several Eastern Bloc states (response to NATO).',5,4,7,5),
('Treaty of Rome (1957)','1957-03-25','Established the European Economic Community (EEC), a major step toward European integration.',7,3,5,5),
('Treaty on the Non-Proliferation of Nuclear Weapons (NPT) (1968)','1968-07-01','International treaty to prevent spread of nuclear weapons and promote peaceful use of nuclear energy.',NULL,NULL,1,5),
('Paris Peace Accords (1973)','1973-01-27','Agreement intended to establish peace in Vietnam and end active U.S. involvement in Vietnam (signed in Paris).',1,NULL,1,6),
('Belavezha Accords (1991)','1991-12-08','Agreement by leaders of Belarus, Russia and Ukraine that declared the USSR effectively dissolved, forming the CIS.',9,NULL,14,7),
('Abraham Accords (2020)','2020-09-15','Normalization agreements beginning between Israel and some Arab states (UAE, Bahrain), advancing diplomatic relations.',8,NULL,10,NULL);





SELECT treaty_id, name, signed_date, venue_id, organization_id, primary_country_id, conflict_id
FROM treaty ORDER BY signed_date;

SELECT * FROM treaty;



INSERT INTO leader (name, country_id, title, notes) VALUES
('George Washington',1,'Commander-in-Chief','US leader during Revolutionary era'),
('Klemens von Metternich',32,'Austrian Statesman','Key diplomat at Congress of Vienna'),
('Mustafa Kemal Atatürk',9,'Leader','Founder of modern Turkey — later related to post-Ottoman transitions (context)'),
('Woodrow Wilson',1,'President','US President influential during Paris/Versailles negotiations'),
('Joseph Stalin',7,'Soviet Leader','Soviet leader at WWII/post-WWII era'),
('Franklin D. Roosevelt',1,'President','US President during WWII (died before UN Charter signed)'),
('Richard Nixon',1,'President','US President during early 1970s (context for Vietnam/Paris Accords)'),
('Benjamin Netanyahu',10,'Prime Minister','Modern Israeli leader (context for Abraham Accords)');




SELECT * FROM leader ORDER BY leader_id;record



INSERT INTO agreement_term (treaty_id, clause_short, clause_text) VALUES
(1,'Sovereignty recognition','Great Britain recognizes the independence of the United States.'),
(4,'Reparations & territorial adjustments','Germany required to pay reparations and cede territories per Versailles terms.'),
(5,'Non-aggression & spheres','Germany and USSR agree not to attack each other; secret protocol divides spheres of influence.'),
(6,'Collective security','UN members pledge to maintain international peace via Security Council.'),
(8,'Collective defense (Article 5)','An armed attack against one NATO member is considered an attack against them all.'),
(11,'EEC internal market','Establish economic integration among member states (customs union, common market).'),
(12,'Non-proliferation duties','Parties agree not to transfer or assist other states in acquiring nuclear weapons; promote peaceful use.')
;




SELECT at.term_id, t.name, at.clause_short FROM agreement_term at JOIN treaty t ON at.treaty_id = t.treaty_id ORDER BY at.term_id;






-- Treaty of Paris (1783)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(1,1,'Signatory','United States - independence recognized'),
(1,2,'Signatory','Great Britain');

-- Congress of Vienna (1815) sample participants
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(2,32,'Participant','Austria (host)'),
(2,2,'Participant','United Kingdom'),
(2,29,'Participant','Russia');

-- Treaty of Sèvres (1920) sample signatories
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(3,2,'Signatory','United Kingdom'),
(3,3,'Signatory','France'),
(3,33,'Party','Ottoman Empire (subject to terms)');

-- Treaty of Versailles (1919)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(4,3,'Signatory','France'),
(4,2,'Signatory','United Kingdom'),
(4,1,'Signatory','United States'),
(4,4,'Subject','Germany');

-- Molotov–Ribbentrop Pact (1939)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(5,7,'Signatory','Soviet Union'),
(5,4,'Signatory','Germany');

-- United Nations Charter (1945) - selected
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(6,1,'Founding Signatory','United States'),
(6,2,'Founding Signatory','United Kingdom'),
(6,3,'Founding Signatory','France'),
(6,7,'Founding Signatory','Soviet Union'),
(6,8,'Founding Signatory','China');

-- Paris Peace Treaties (1947) - sample
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(7,5,'Signatory','Italy'),
(7,16,'Signatory','Romania'),
(7,17,'Signatory','Hungary'),
(7,18,'Signatory','Bulgaria'),
(7,19,'Signatory','Finland');

-- North Atlantic Treaty (1949) - selected founding members
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(8,1,'Founding Member','United States'),
(8,2,'Founding Member','United Kingdom'),
(8,3,'Founding Member','France'),
(8,5,'Founding Member','Italy'),
(8,20,'Founding Member','Canada');

-- San Francisco Peace Treaty (1951)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(9,6,'Signatory','Japan'),
(9,1,'Signatory','United States'),
(9,21,'Signatory','Australia');

-- Warsaw Pact (1955)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(10,7,'Founding Member','Soviet Union'),
(10,22,'Founding Member','Poland'),
(10,23,'Founding Member','East Germany (GDR)'),
(10,24,'Founding Member','Czechoslovakia'),
(10,17,'Founding Member','Hungary'),
(10,16,'Founding Member','Romania'),
(10,18,'Founding Member','Bulgaria'),
(10,25,'Founding Member','Albania');

-- Treaty of Rome (1957)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(11,3,'Signatory','France'),
(11,5,'Signatory','Italy'),
(11,4,'Signatory','Germany'),
(11,26,'Signatory','Belgium'),
(11,27,'Signatory','Netherlands'),
(11,28,'Signatory','Luxembourg');

-- NPT (1968) - selected signatories
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(12,1,'Signatory','United States'),
(12,2,'Signatory','United Kingdom'),
(12,7,'Signatory','Soviet Union'),
(12,3,'Signatory','France'),
(12,8,'Signatory','China');

-- Paris Peace Accords (1973)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(13,1,'Signatory','United States'),
(13,12,'Signatory','North Vietnam'),
(13,13,'Signatory','South Vietnam');

-- Belavezha Accords (1991)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(14,29,'Signatory','Russia (RSFSR)'),
(14,30,'Signatory','Ukraine'),
(14,14,'Signatory','Belarus');

-- Abraham Accords (2020)
INSERT INTO treaty_country (treaty_id, country_id, role, notes) VALUES
(15,10,'Signatory','Israel'),
(15,15,'Signatory','United Arab Emirates'),
(15,31,'Signatory','Bahrain');






SELECT tc.id, t.name AS treaty, c.name AS country, tc.role
FROM treaty_country tc
JOIN treaty t ON tc.treaty_id = t.treaty_id
JOIN country c ON tc.country_id = c.country_id
ORDER BY tc.treaty_id, tc.id;



SELECT treaty_id, name, DATE_FORMAT(signed_date, '%Y-%m-%d') AS signed_date, description
FROM treaty
ORDER BY signed_date;



-- INNER JOIN returns only matching rows across both tables.
SELECT t.name AS treaty, c.name AS signatory, tc.role
FROM treaty_country tc
INNER JOIN treaty t ON tc.treaty_id = t.treaty_id
INNER JOIN country c ON tc.country_id = c.country_id
WHERE t.name = 'United Nations Charter (1945)';




SELECT t.treaty_id, t.name AS treaty_name, v.name AS venue_name, v.city
FROM treaty t
LEFT JOIN venue v ON t.venue_id = v.venue_id
ORDER BY t.signed_date;



SELECT c.country_id, c.name AS country, t.name AS treaty, tc.role
FROM country c
RIGHT JOIN treaty_country tc ON c.country_id = tc.country_id
RIGHT JOIN treaty t ON tc.treaty_id = t.treaty_id
ORDER BY c.country_id, t.signed_date
LIMIT 20;



-- full outer join
SELECT t.treaty_id, t.name AS treaty, c.country_id, c.name AS country
FROM treaty t
LEFT JOIN treaty_country tc ON t.treaty_id = tc.treaty_id
LEFT JOIN country c ON tc.country_id = c.country_id

UNION

SELECT t.treaty_id, t.name AS treaty, c.country_id, c.name AS country
FROM treaty t
RIGHT JOIN treaty_country tc ON t.treaty_id = tc.treaty_id
RIGHT JOIN country c ON tc.country_id = c.country_id;



SELECT t.treaty_id, t.name,
       COUNT(tc.country_id) AS signatory_count
FROM treaty t
LEFT JOIN treaty_country tc ON t.treaty_id = tc.treaty_id
GROUP BY t.treaty_id, t.name
ORDER BY t.signed_date;





SELECT
  CASE
    WHEN YEAR(signed_date) < 1800 THEN 'Before 1800'
    WHEN YEAR(signed_date) BETWEEN 1800 AND 1899 THEN '1800s'
    WHEN YEAR(signed_date) BETWEEN 1900 AND 1949 THEN '1900-1949'
    WHEN YEAR(signed_date) BETWEEN 1950 AND 1999 THEN '1950-1999'
    ELSE '2000+' END AS era,
  COUNT(*) AS treaty_count
FROM treaty
GROUP BY era;




-- Find treaty rows with venue_id referencing a non-existent venue (should be 0)
SELECT t.* FROM treaty t
LEFT JOIN venue v ON t.venue_id = v.venue_id
WHERE t.venue_id IS NOT NULL AND v.venue_id IS NULL;



-- Show each treaty along with its venue name
SELECT 
    t.treaty_id,
    t.name,
    v.name
FROM treaty t
INNER JOIN venue v 
    ON t.venue_id = v.venue_id;

