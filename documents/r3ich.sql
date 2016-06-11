#create new schema
#DROP SCHEMA IF EXISTS r3ich;
CREATE SCHEMA IF NOT EXISTS r3ich;
USE r3ich;

#create staff table
CREATE TABLE STAFF(
Nric VARCHAR(9) NOT NULL PRIMARY KEY,
Salutation VARCHAR(4) NOT NULL,
Name VARCHAR(255) NOT NULL,
Classes VARCHAR(255),
PasswordHash VARCHAR(255) NOT NULL,
Last_Updated DATE NOT NULL
);

#create users table
CREATE TABLE USERS(
Nric VARCHAR(9) NOT NULL PRIMARY KEY,
Name VARCHAR(255) NOT NULL,
`Class` VARCHAR(255) NOT NULL,
`Group` VARCHAR(255) NOT NULL,
Respect_Level INT NOT NULL,
Resilience_Level INT NOT NULL,
Responsibility_Level INT NOT NULL,
Integrity_Level INT NOT NULL,
Care_Level INT NOT NULL,
Harmony_Level INT NOT NULL
);

/*
#create user_levels table
CREATE TABLE USER_LEVELS{
User_Nric VARCHAR(9) NOT NULL,
Skill_Class VARCHAR(255) NOT NULL,
Skill_Class_Level INT NOT NULL,
CONSTRAINT USER_LEVELS_PK PRIMARY KEY (User_Nric,Skill_Class),
CONSTRAINT USER_LEVELS_FK1 FOREIGN KEY (User_Nric) REFERENCES USERS(Nric),
};
*/

#create transaction_details table
CREATE TABLE TRANSACTION_DETAILS(
Staff VARCHAR(9) NOT NULL,
`User` VARCHAR(9) NOT NULL,
Delta INT NOT NULL,
Reason VARCHAR(255),
Transaction_DateTime DATETIME NOT NULL,
CONSTRAINT TRANSACTION_DETAILS_PK PRIMARY KEY (Staff,`User`,Transaction_DateTime),
CONSTRAINT TRANSACTION_DETAILS_FK1 FOREIGN KEY (Staff) REFERENCES STAFF(Nric),
CONSTRAINT TRANSACTION_DETAILS_FK2 FOREIGN KEY (`User`) REFERENCES USERS(Nric)
);

#create skills table
CREATE TABLE SKILLS(
Skill_Class VARCHAR(255) NOT NULL,
Skill_Class_Level INT NOT NULL,
Skill_Description VARCHAR(255) NOT NULL,
CONSTRAINT SKILLS_PK PRIMARY KEY (Skill_Class,Skill_Class_Level)
);

#load administrator
INSERT INTO STAFF VALUES('S9231712I', 'Mr.', 'Chia Chong Cher', '2-2', '$2a$08$9zATpWilJIcUD6ljSScg6.yAgbBIT0bcMtx/fQJh8AO8ju6AxIIQS', '2016-06-09');

#load skills into skills table
INSERT INTO skills VALUES('Respect', 1, 'Reduce the amount of points required to activate skills by 5%');
INSERT INTO skills VALUES('Respect', 2, 'Reduce the amount of points to level up a skill by 50%');
INSERT INTO skills VALUES('Respect', 3, 'Able to talk to 1 person for 5 seconds during any class quiz');
INSERT INTO skills VALUES('Resilience', 1, 'Remove 1 option from an MCQ question during a class quiz');
INSERT INTO skills VALUES('Resilience', 2, 'Gain an additional 5% of your total score in any quiz');
INSERT INTO skills VALUES('Resilience', 3, 'Able to bring a A10 (1.5 x 1.0 inch) cheatsheet into any class quiz');
INSERT INTO skills VALUES('Responsibility', 1, 'Gain the ability to listen to music for 3 minutes (~1 song) during individual work');
INSERT INTO skills VALUES('Responsibility', 2, 'Gain the ability select your own groupmates for 1 assignment');
INSERT INTO skills VALUES('Responsibility', 3, 'Gain the ability to have a 1 minute break from class work for yourself');
INSERT INTO skills VALUES('Integrity', 1, 'Gain the ability to use your phone for 30 seconds in class');
INSERT INTO skills VALUES('Integrity', 2, 'Gain the ability to submit 1 piece of homework before 6pm instead of during class');
INSERT INTO skills VALUES('Integrity', 3, 'Able to check with examiner if the answer to any MCQ quiz question is correct - Examiner only answers Yes/No/Partly');
INSERT INTO skills VALUES('Care', 1, 'Be able to eat 1 food item in class - maximum 50 grams!');
INSERT INTO skills VALUES('Care', 2, 'Work with a friend during an individual class assignment');
INSERT INTO skills VALUES('Care', 3, '1 minute of break time for the entire class');
INSERT INTO skills VALUES('Harmony', 1, 'Reduce the points required for a classmate to activate skills by 10%');
INSERT INTO skills VALUES('Harmony', 2, 'Answer for 1 MCQ quiz question will be the class’s most common answer');
INSERT INTO skills VALUES('Harmony', 3, 'Duplicate the reward activated by another classmate');