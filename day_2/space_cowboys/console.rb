require "pry-byebug"
require_relative "./models/bounties.rb"

Bounties.delete_all()

perp1 = Bounties.new({
  'name' => 'Boba Fett',
  'bounty' => 2000,
  'homeworld' => 'Floaty Blue',
  'favourite_weapon' => 'stink bomb'
  })

perp1.save()


perp2 = Bounties.new({
  'name' => 'Guido',
  'bounty' => 1000,
  'homeworld' => 'Tatooine',
  'favourite_weapon' => 'hesitation'
  })

perp2.save()


binding.pry
nil
