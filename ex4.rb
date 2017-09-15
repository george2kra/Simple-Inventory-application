cars = 100 #number of cars
space_in_a_car = 4.0 #space in a cars
drivers = 30 #number of drivers
passengers = 90 # number of passengers
cars_not_driven = cars - drivers #number of dars not driven
cars_driven = drivers # drivers = cars in use
carpool_capacity = cars_driven * space_in_a_car # the number of possible passengers
average_passengers_per_car = passengers / cars_driven #average passengers per car


puts "There are #{cars} cars available."
puts "There are only #{drivers} drivers available."
puts "There will be #{cars_not_driven} empty cars today."
puts "We can transport #{carpool_capacity} people today."
puts "We have #{passengers} to carpool today."
puts "We need to put about #{average_passengers_per_car} in each car."
