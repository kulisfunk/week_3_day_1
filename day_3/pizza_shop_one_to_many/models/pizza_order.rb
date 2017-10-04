require_relative '../db/sql_runner'
require_relative 'customer'

class PizzaOrder
  attr_accessor :customer_id, :topping, :quantity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i()
    @topping = options['topping']
    @quantity = options['quantity'].to_i
  end

  def save()
    sql = "INSERT INTO pizza_orders
    (
      customer_id,
      topping,
      quantity
      )
      VALUES
      (
        $1, $2, $3
        )
        RETURNING *
        ;
        "
        values = [ @customer_id, @topping, @quantity]

        @id = SqlRunner.run(sql,"save", values)[0]['id'].to_i
  end

  def self.find(topping)
    sql = "SELECT * FROM pizza_orders WHERE topping=$1;"
    values = [topping]
    perps = SqlRunner.run(sql, "find", values)[0]
    return perps.map { |perp_hash| PizzaOrder.new(perp_hash) }
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders;"
    values = []
    orders = SqlRunner.run(sql, "all", values)
    return orders.map { |order_hash| PizzaOrder.new(order_hash) }
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders;" #also TRUNCATE TABLE
    values = []
    SqlRunner.run(sql, "delete_all", values)
  end

  def delete()
    sql = "DELETE FROM pizza_orders WHERE ID=$1"
    values = [@id]
    SqlRunner.run(sql, "delete", values)
  end

  def update()
    sql = "UPDATE pizza_orders
    SET
    (
      customer_id,
      topping,
      quantity
      ) = (
        $1, $2, $3
      ) WHERE id = $4;"
    values = [@customer_id, @topping, @quantity, @id]
    SqlRunner.run(sql, "update", values)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@customer_id]
    results = SqlRunner.run(sql, "get_customer", values)
    customer = results[0]
    return Customer.new(customer)
  end



end
