require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')

class Customer


attr_reader :id
attr_accessor :customer_name, :customer_funds

def initialize(options)
  @id = options['id'].to_i if options['id'].to_i
  @customer_name = options['customer_name']
  @customer_funds = options['customer_funds'].to_i
end

def self.delete_all()
  sql = "DELETE FROM customers;"
  values = []
  SqlRunner.run(sql, "delete_all", values)
end

def save()
  sql = "INSERT INTO customers
  (
    customer_name, customer_funds
  )
  VALUES
  (
    $1, $2
  )
  RETURNING id;
  "
  values = [@customer_name, @customer_funds]
  result = SqlRunner.run(sql, "save_all", values).first
  @id = result['id'].to_i
end

def self.all()
  sql = "SELECT * FROM customers;"
  values = []
  customers = SqlRunner.run(sql, "list_all", values)
  result = customers.map{|customers| Customer.new(customers)}
  return result
end

def delete()
  sql = "DELETE FROM customers WHERE ID=$1"
  values = [@id]
  SqlRunner.run(sql, "customer_delete", values)
end

def update()
  sql = "UPDATE customers
  SET
  (
    customer_name,
    customer_funds
    ) = (
      $1, $2
    ) WHERE id = $3;"
  values = [@customer_name, @customer_funds, @id]
  SqlRunner.run(sql, "customer_update", values)
end

def films_per_customer()
  sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1;"
  values = [@id]
  films = SqlRunner.run(sql, "films_per_customer", values)
  return films.map{ |films| Film.new(films)}
end

end
