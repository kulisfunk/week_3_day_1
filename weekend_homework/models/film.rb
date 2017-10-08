require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')
require_relative('./ticket.rb')

class Film

  attr_reader :id
  attr_accessor :film_title, :film_price

  def initialize(options)
    @id = options['id'].to_i if options['id'].to_i
    @film_title = options['film_title']
    @film_price = options['film_price']
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    values = []
    SqlRunner.run(sql, "delete_all", values)
  end

  def save()
    sql = "INSERT INTO films
    (
    film_title, film_price
    )
    VALUES
    (
    $1, $2
    )
    RETURNING id;"
    values = [@film_title, @film_price]
    result = SqlRunner.run(sql, "save_all", values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films;"
    values = []
    films = SqlRunner.run(sql, "list_all", values)
    result = films.map{|films| Film.new(films)}
    return result
  end

  def delete()
    sql = "DELETE FROM films WHERE ID=$1"
    values = [@id]
    SqlRunner.run(sql, "film_delete", values)
  end

  def update()
    sql = "UPDATE films
    SET
    (
      film_title, film_price
    ) = (
    $1, $2
    ) WHERE id = $3;"
    values = [@film_title, @film_price, @id]
    SqlRunner.run(sql, "film_update", values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, "customer_numbers", values)
    return customers.map{ |customers| Customer.new(customers)}
  end

end
