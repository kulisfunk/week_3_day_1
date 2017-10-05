require_relative('../db/sql_runner.rb')
require_relative('../models/student.rb')
require_relative('../models/student_subject.rb')

class Subject

  attr_reader :id
  attr_accessor :subject_name, :teacher_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @subject_name = options['subject_name']
    @teacher_name = options['teacher_name']
  end

  def self.delete_all()
    sql = 'DELETE FROM subjects;'
    values = []
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "INSERT INTO subjects
    (
      subject_name, teacher_name
    )
      VALUES
    (
      $1, $2
    )
    RETURNING id;"

    values = [@subject_name, @teacher_name]

    subjects = SqlRunner.run(sql, values).first
    @id = subjects['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM subjects;"
    values = []
    subjects = SqlRunner.run(sql, values)
    result = subjects.map { |subject| Subject.new( subject ) }
    return result
  end

  def students()
    sql = "SELECT students.* FROM students INNER JOIN student_subjects ON student_subjects.student_id = students.id WHERE subject_id = $1;"
    values = [@id]
    students = SqlRunner.run(sql, values)
    return students.map{ |students| Student.new(students) }
  end

end
