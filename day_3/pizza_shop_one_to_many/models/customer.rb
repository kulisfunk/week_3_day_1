require_relative '../db/sql_runner'
require_relative 'pizza_order'


class Customer

attr_accessor :first_name, :last_name
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO customers (
    first_name, last_name
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id;
    "
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, "save_customer", values)
    @id = result[0]['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    values = []
    result = SqlRunner.run(sql, "delete_all", values)
  end

  def update()
    sql = "UPDATE customers SET (
    first_name, last_name
    ) = (
      $1, $2
    ) WHERE id = $3
    ;
    "
    values = [@first_name, @last_name, @id]
    result = SqlRunner.run(sql, "update_customer", values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE ID=$1"
    values = [@id]
    result = SqlRunner.run(sql, "delete_customer", values)
  end

  def self.find(first_name)
    sql = "SELECT * FROM customers WHERE first_name = $1"
    values = [first_name]
    custs = SqlRunner.run(sql, "delete_all", values)# add [0] if not using .map
    return custs.map { |cust_hash| Customer.new(cust_hash) }
  end

  def orders()
    sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
    values = [@id]
    orders = SqlRunner.run(sql, "orders", values)
    return orders.map { |orders| PizzaOrder.new(orders)} #because there are multiple hashes returned

  end


end
