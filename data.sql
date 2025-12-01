
CREATE DATABASE HR_Management_System;
USE HR_Management_System;


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('HR_Admin', 'Internal_Employee', 'External_Candidate') NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE HR_Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    department VARCHAR(100),
    contact_number VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Internal_Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    position VARCHAR(100),
    department VARCHAR(100),
    date_hired DATE,
    manager_id INT DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES Internal_Employees(employee_id)
        ON DELETE SET NULL
);


CREATE TABLE External_Candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    resume_link VARCHAR(255),
    skills TEXT,
    experience_years INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Job_Postings (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    posted_by INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    department VARCHAR(100),
    location VARCHAR(100),
    salary_range VARCHAR(50),
    posting_date DATE DEFAULT CURRENT_DATE,
    closing_date DATE,
    FOREIGN KEY (posted_by) REFERENCES HR_Admin(admin_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    applicant_user_id INT NOT NULL,
    application_date DATE DEFAULT CURRENT_DATE,
    status ENUM('Pending', 'Reviewed', 'Interview', 'Hired', 'Rejected') DEFAULT 'Pending',
    notes TEXT,
    FOREIGN KEY (job_id) REFERENCES Job_Postings(job_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (applicant_user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Performance_Records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    evaluation_period VARCHAR(50),
    performance_score DECIMAL(5,2),
    feedback TEXT,
    evaluated_by INT,
    evaluation_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (employee_id) REFERENCES Internal_Employees(employee_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (evaluated_by) REFERENCES HR_Admin(admin_id)
        ON DELETE SET NULL
);


CREATE TABLE Succession_Plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    potential_role VARCHAR(100),
    readiness_level ENUM('High', 'Medium', 'Low'),
    development_plan TEXT,
    created_by INT,
    created_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (employee_id) REFERENCES Internal_Employees(employee_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (created_by) REFERENCES HR_Admin(admin_id)
        ON DELETE SET NULL
);
