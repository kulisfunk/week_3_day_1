require_relative('../db/sql_runner.rb')
require_relative('../models/student.rb')
require_relative('../models/subject.rb')

class StudentSubject

  attr_reader :id
  attr_accessor :student_id, :subject_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @student_id = options['student_id'].to_i
    @subject_id = options['subject_id'].to_i
  end

  def save()
    sql = "INSERT INTO student_subjects
    (
      student_id, subject_id
    )
      VALUES
    (
      $1, $2
    )
    RETURNING id;"

    values = [@student_id, @subject_id]

    subs = SqlRunner.run(sql, values).first
    @id = subs['id'].to_i
  end



  def self.delete_all()
    sql = "DELETE FROM student_subjects"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM student_subjects;"
    values = []
    subs = SqlRunner.run(sql, values)
    result = subs.map { |subs| StudentSubject.new( subs) }
    return result
  end
end
