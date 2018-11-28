require('pry')
require_relative('models/bounty.rb')
Bounty.delete_all


bounty1 = Bounty.new({
  'name' => 'Darth Vader',
  'bounty_value' => '5000',
  'last_known_location' => 'Glasgow',
  'favourite_weapon' => 'Lightsaber'
  })

bounty2 = Bounty.new({
  'name' => 'Charles Manson',
  'bounty_value' => '10000',
  'last_known_location' => 'Edinburgh',
  'favourite_weapon' => 'Knife'
  })

bounty3 = Bounty.new({
  'name' => 'Satan',
  'bounty_value' => '20000',
  'last_known_location' => 'Inverness',
  'favourite_weapon' => 'Flame Thrower'
  })


bounty1.save()
bounty2.save()
bounty3.save()

bounty1.bounty_value = '7000'
bounty1.update()

bounty3.delete_one

found_bounty = Bounty.find_by_name('Darth Vader')
found_bounty_two = Bounty.find_by_name('Satan')

found_bounty_id = Bounty.find_by_id('5')
found_bounty_id_two = Bounty.find_by_id('1')

all_bounties = Bounty.all

binding.pry
nil
