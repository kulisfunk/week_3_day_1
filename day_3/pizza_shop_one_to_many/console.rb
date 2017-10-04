require "pry-byebug"
require_relative "./models/pizza_order.rb"
require_relative "./models/customer.rb"

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'first_name' => 'Luke',
  'last_name' => 'Skywalker'
  })

  customer1.save()

  customer1.first_name = "Leia"
  customer1.update()



order1 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'topping' => 'Pepperoni',
  'quantity' => 2
  })

  order1.save()

order2 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'topping' => 'Hawaii',
  'quantity' => 2
  })

  order2.save()

  binding.pry

  nil
