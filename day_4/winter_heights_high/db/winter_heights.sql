DROP TABLE IF EXISTS student_subjects;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
  id SERIAL4 PRIMARY KEY,
  student_name VARCHAR(255)
);

CREATE TABLE subjects (
  id SERIAL4 PRIMARY KEY,
  subject_name VARCHAR(255),
  teacher_name VARCHAR(255)
);

CREATE TABLE student_subjects(
  id SERIAL4 PRIMARY KEY,
  student_id INT4 REFERENCES students(id) ON DELETE CASCADE,
  subject_id INT4 REFERENCES subjects(id) ON DELETE CASCADE
);
