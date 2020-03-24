require('pry-byebug')

require_relative('models/property')

property1 = Property.new({'address' => '1 Green Street',
                          'value' => 100_000,
                          'year_built' => 1999,
                          'build' => 'flat'})

property2 = Property.new({'address' => '2 Brown Street',
                          'value' => 130_000,
                          'year_built' => 2005,
                          'build' => 'house'})

property3 = Property.new({'address' => '100 Yellow Street',
                          'value' => 900_000,
                          'year_built' => 2050,
                          'build' => 'cyber-home'})
# property1.save()
# property2.save()
# property3.save()
# property1.save()
# property1.value = 150000
# property1.update()
# property1.delete()

properties = Property.all()

found_property = Property.find(35)

found_property_by_address = Property.find_by_address('2 Brown Street')
found_property_by_address = Property.find_by_address('50 Brown Street')

# Property.delete_all()

binding.pry
nil
