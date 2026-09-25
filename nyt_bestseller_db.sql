#===========================================================#
#                      FINAL PROJECT 180                    #
#               ITN 180-2D DATABASE TECHNOLOGY              #
#                     FALL 2025 - SESSION 1                 #
#                   PROJECT: NYBESTELLERDB                  #
#===========================================================#

#===========================================================#
#                         PART 1                            #
#                 Database & Core Tables                    #
#===========================================================#

CREATE DATABASE IF NOT EXISTS NYTBestSellerDB;
USE NYTBestSellerDB;

CREATE TABLE IF NOT EXISTS Genre (
    genre_id   INT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Role (
    role_id   INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL,
    active    ENUM('Yes', 'No') DEFAULT 'Yes'
);

CREATE TABLE IF NOT EXISTS Members (
    member_id  INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    email      VARCHAR(100) UNIQUE NOT NULL,
    phone      VARCHAR(20),
    address    VARCHAR(255),
    is_active  BOOLEAN DEFAULT TRUE,
    role_id    INT,
    CONSTRAINT fk_members_role FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE IF NOT EXISTS Books (
    book_id        INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(200),
    author         VARCHAR(200),
    genre          VARCHAR(100),
    published_year INT,
    copies         INT DEFAULT 1,
    price          DECIMAL(5,2),
    is_fiction     BOOLEAN,
    genre_id       INT,
    CONSTRAINT fk_books_genre FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

CREATE TABLE IF NOT EXISTS BookCopy (
    copy_id          INT AUTO_INCREMENT PRIMARY KEY,
    book_id          INT NOT NULL,
    `condition`      ENUM('New', 'Good', 'Damaged') NOT NULL,
    status           ENUM('Available', 'Checked Out', 'Retired') NOT NULL,
    location         ENUM('Shelf', 'Storage', 'Inactive') NOT NULL,
    retired_date     DATE NULL,
    notes            ENUM('Damaged', 'Lost', 'Replaced', 'None') NOT NULL,
    replacement_date DATE NULL,
    CONSTRAINT fk_bookcopy_books FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE IF NOT EXISTS Checkouts (
    checkout_id    INT AUTO_INCREMENT PRIMARY KEY,
    book_id        INT NOT NULL,
    member_id      INT NOT NULL,
    checkout_date  DATE NOT NULL,
    due_date       DATE NOT NULL,
    status         ENUM('Pending', 'Returned', 'Overdue') NOT NULL,
    book_condition ENUM('Good', 'Fair', 'Damaged') NOT NULL,
    staff_id       INT,
    return_date    DATE,
    return_time    TIME,
    CONSTRAINT fk_checkouts_books FOREIGN KEY (book_id) REFERENCES Books(book_id),
    CONSTRAINT fk_checkouts_members FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE IF NOT EXISTS Fees (
    fee_id      INT AUTO_INCREMENT PRIMARY KEY,
    checkout_id INT NOT NULL,
    fee_type    ENUM('Late', 'Damage', 'Other') NOT NULL,
    amount      DECIMAL(5,2) NOT NULL,
    paid        ENUM('Yes', 'No') DEFAULT 'No',
    member_id   INT,
    CONSTRAINT fk_fees_checkouts FOREIGN KEY (checkout_id) REFERENCES Checkouts(checkout_id)
);

CREATE TABLE IF NOT EXISTS MemberRole (
    member_id INT NOT NULL,
    role_id   INT NOT NULL,
    PRIMARY KEY (member_id, role_id),
    CONSTRAINT fk_memberrole_members FOREIGN KEY (member_id) REFERENCES Members(member_id),
    CONSTRAINT fk_memberrole_role FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE IF NOT EXISTS RoleInfo (
    roleinfo_id  INT PRIMARY KEY AUTO_INCREMENT,
    member_id    INT NOT NULL,
    detail_type  VARCHAR(50) NOT NULL,
    detail_value VARCHAR(100) NOT NULL,
    CONSTRAINT fk_roleinfo_members FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

#===========================================================#
#                         PART 2                            #
#                  Sample Data Inserts                      #
#===========================================================#

INSERT INTO Members (member_id, first_name, last_name, email, phone, address, is_active, role_id) VALUES
(700000001, 'Alice', 'Johnson', 'alice.johnson@college.edu', '302-555-0101', '123 Main St', 1, 1),
(700000002, 'Bob', 'Smith', 'bob.smith@college.edu', '302-555-0102', '456 Elm St', 1, 1),
(700000003, 'Charlie', 'Brown', 'charlie.brown@college.edu', '302-555-0103', '789 Oak St', 1, 2),
(700000004, 'Dana', 'White', 'dana.white@college.edu', '302-555-0104', '321 Pine St', 1, 3),
(700000005, 'Eli', 'Martinez', 'eli.martinez@college.edu', '302-555-0105', '654 Maple St', 1, 1),
(700000006, 'Fiona', 'Clark', 'fiona.clark@college.edu', '302-555-0106', '987 Cedar St', 1, 3),
(700000007, 'George', 'Lee', 'george.lee@college.edu', '302-555-0107', '654 Walnut St', 1, 1),
(700000008, 'Hannah', 'Moore', 'hannah.moore@college.edu', '302-555-0108', '852 Birch St', 1, 1),
(700000009, 'Ian', 'Taylor', 'ian.taylor@college.edu', '302-555-0109', '963 Spruce St', 1, 1),
(700000010, 'Julia', 'Anderson', 'julia.anderson@college.edu', '302-555-0110', '147 Chestnut St', 1, 1),
(700000011, 'Kevin', 'Wright', 'kevin.wright@college.edu', '302-555-0111', '258 Poplar St', 1, 1),
(700000012, 'Laura', 'Hall', 'laura.hall@college.edu', '302-555-0112', '369 Willow St', 1, 1),
(700000013, 'Michael', 'Young', 'michael.young@college.edu', '302-555-0113', '741 Aspen St', 1, 1),
(700000014, 'Nina', 'King', 'nina.king@college.edu', '302-555-0114', '852 Sycamore St', 1, 1),
(700000015, 'Oscar', 'Scott', 'oscar.scott@college.edu', '302-555-0115', '963 Hickory St', 1, 1),
(700000016, 'Zara', 'Lopez', 'zara.lopez@college.edu', '302-555-0199', '999 Maple St', 0, 1),
(700000017, 'Daniel', 'Reed', 'daniel.reed@college.edu', '302-555-0115', '101 Willow St', 1, 1),
(700000018, 'Emily', 'Turner', 'emily.turner@college.edu', '302-555-0116', '202 Sycamore St', 1, 1),
(700000019, 'Frank', 'Bennett', 'frank.bennett@college.edu', '302-555-0117', '303 Cypress St', 1, 1),
(700000020, 'Grace', 'Morgan', 'grace.morgan@college.edu', '302-555-0118', '404 Magnolia St', 1, 1),
(700000021, 'Henry', 'Perry', 'henry.perry@college.edu', '302-555-0119', '505 Hickory St', 1, 1),
(700000022, 'Isla', 'Brooks', 'isla.brooks@college.edu', '302-555-0120', '606 Redwood St', 1, 1),
(700000023, 'Jack', 'Foster', 'jack.foster@college.edu', '302-555-0121', '707 Fir St', 1, 1),
(700000024, 'Kara', 'Gibson', 'kara.gibson@college.edu', '302-555-0122', '808 Alder St', 1, 1),
(700000025, 'Leo', 'Hughes', 'leo.hughes@college.edu', '302-555-0123', '909 Beech St', 1, 1),
(700000026, 'Mia', 'Stewart', 'mia.stewart@college.edu', '302-555-0124', '111 Hemlock St', 1, 1),
(700000027, 'Noah', 'Coleman', 'noah.coleman@college.edu', '302-555-0125', '222 Larch St', 1, 1),
(700000028, 'Olivia', 'Ross', 'olivia.ross@college.edu', '302-555-0126', '333 Juniper St', 1, 1),
(700000029, 'Paul', 'Murphy', 'paul.murphy@college.edu', '302-555-0127', '444 Dogwood St', 1, 1),
(700000030, 'Quinn', 'Bailey', 'quinn.bailey@college.edu', '302-555-0128', '555 Willow St', 1, 1),
(700000031, 'Ruby', 'Cox', 'ruby.cox@college.edu', '302-555-0129', '666 Sycamore St', 1, 1),
(700000032, 'Sam', 'Diaz', 'sam.diaz@college.edu', '302-555-0130', '777 Cypress St', 1, 1),
(700000033, 'Tina', 'Evans', 'tina.evans@college.edu', '302-555-0131', '888 Magnolia St', 1, 1),
(700000034, 'Umar', 'Flores', 'umar.flores@college.edu', '302-555-0132', '999 Hickory St', 1, 1),
(700000035, 'Vera', 'Gonzalez', 'vera.gonzalez@college.edu', '302-555-0133', '121 Redwood St', 1, 1),
(700000036, 'Will', 'Harrison', 'will.harrison@college.edu', '302-555-0134', '131 Fir St', 1, 1),
(700000037, 'Xavier', 'Nelson', 'xavier.nelson@college.edu', '302-555-0135', '141 Alder St', 1, 1),
(700000038, 'Yara', 'Price', 'yara.price@college.edu', '302-555-0136', '151 Beech St', 1, 1),
(700000039, 'Zane', 'Ramirez', 'zane.ramirez@college.edu', '302-555-0137', '161 Cedar St', 1, 1),
(700000040, 'Abigail', 'Sanders', 'abigail.sanders@college.edu', '302-555-0138', '171 Chestnut St', 1, 1),
(700000041, 'Brandon', 'Torres', 'brandon.torres@college.edu', '302-555-0139', '181 Dogwood St', 1, 1),
(700000042, 'Chloe', 'Edwards', 'chloe.edwards@college.edu', '302-555-0140', '191 Elm St', 1, 1),
(700000043, 'Dylan', 'Fisher', 'dylan.fisher@college.edu', '302-555-0141', '201 Fir St', 1, 1),
(700000044, 'Ella', 'Gray', 'ella.gray@college.edu', '302-555-0142', '211 Hickory St', 1, 1),
(700000045, 'Felix', 'Howard', 'felix.howard@college.edu', '302-555-0143', '221 Juniper St', 1, 1),
(700000046, 'Gabriella', 'James', 'gabriella.james@college.edu', '302-555-0144', '231 Larch St', 1, 1),
(700000047, 'Hugo', 'Kelly', 'hugo.kelly@college.edu', '302-555-0145', '241 Magnolia St', 1, 1),
(700000048, 'Isabella', 'Long', 'isabella.long@college.edu', '302-555-0146', '251 Maple St', 1, 1),
(700000049, 'Jacob', 'Martinez', 'jacob.martinez@college.edu', '302-555-0147', '261 Oak St', 1, 1),
(700000050, 'Kayla', 'Nguyen', 'kayla.nguyen@college.edu', '302-555-0148', '271 Pine St', 1, 1),
(700000051, 'Liam', 'Ortiz', 'liam.ortiz@college.edu', '302-555-0149', '281 Poplar St', 1, 1),
(700000052, 'Maya', 'Patel', 'maya.patel@college.edu', '302-555-0150', '291 Redwood St', 1, 1),
(700000053, 'Nathan', 'Quinn', 'nathan.quinn@college.edu', '302-555-0151', '301 Spruce St', 1, 1),
(700000054, 'Olga', 'Reyes', 'olga.reyes@college.edu', '302-555-0152', '311 Sycamore St', 1, 1),
(700000055, 'Peter', 'Scott', 'peter.scott@college.edu', '302-555-0153', '321 Walnut St', 1, 1),
(700000056, 'Queenie', 'Thomas', 'queenie.thomas@college.edu', '302-555-0154', '331 Willow St', 1, 1),
(700000057, 'Ryan', 'Upton', 'ryan.upton@college.edu', '302-555-0155', '341 Aspen St', 1, 1),
(700000058, 'Sophia', 'Vargas', 'sophia.vargas@college.edu', '302-555-0156', '351 Birch St', 1, 1),
