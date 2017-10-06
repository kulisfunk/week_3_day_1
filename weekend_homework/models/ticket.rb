require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')
require_relative('./film.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    values = []
    SqlRunner.run(sql, "dlete_all", values)
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id, film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id;"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, "save_all", values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    values = []
    tickets = SqlRunner.run(sql, "list_all", values)
    result = tickets.map{|tickets| Ticket.new(tickets)}
    return result
  end

  def delete()
    sql = "DELETE FROM tickets WHERE ID=$1"
    values = [@id]
    SqlRunner.run(sql, "ticket_delete", values)
  end

  def update()
    sql = "UPDATE tickets
    SET
    (
      customer_id,
      film_id
      ) = (
        $1, $2
      ) WHERE id = $3;"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, "ticket_update", values)
  end
end
