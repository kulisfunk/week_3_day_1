require_relative('../db/sql_runner.rb')
require_relative('../models/subject.rb')
require_relative('../models/student_subject.rb')

class Student

attr_reader :id
attr_accessor :student_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @student_name = options['student_name']
  end

  def self.delete_all()
    sql = 'DELETE FROM students'
    values = []
    SqlRunner.run(sql, values)

  end

  def save()
    sql = "INSERT INTO students
    (
      student_name
    )
      VALUES
    (
      $1
    )
    RETURNING id;"

    values = [@student_name]

    studes = SqlRunner.run(sql, values).first
    @id = studes['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM students;"
    values = []
    students = SqlRunner.run(sql, values)
    result = students.map { |student| Student.new( student ) }
    return result
  end

  def subjects()
    sql = "SELECT subjects.* FROM subjects INNER JOIN student_subjects ON student_subjects.subject_id = subjects.id WHERE student_id = $1;"
    values = [@id]
    subjects = SqlRunner.run(sql, values)
    return subjects.map{ |subjects| Subject.new(subjects) }
  end
end
