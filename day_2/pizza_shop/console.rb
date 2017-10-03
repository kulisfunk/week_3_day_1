require "pry-byebug"
require_relative "./models/pizza_order.rb"

PizzaOrder.delete_all()

order1 = PizzaOrder.new({
  'first_name' => 'Luke',
  'last_name' => 'Skywalker',
  'topping' => 'SwampRat',
  'quantity' => 1
  })

  order1.save()

order2 = PizzaOrder.new({
  'first_name' => 'Darth',
  'last_name' => 'Vader',
  'topping' => 'Lard',
  'quantity' => 1
  })

  order2.save()

  binding.pry

  nil
