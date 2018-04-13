require_relative( 'models/customer' )
require_relative( 'models/ticket' )
require_relative( 'models/film' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({"name" => "Kelsie",
                      "funds" => 30})
customer1.save()
customer2 = Customer.new({"name" => "Stewart",
                      "funds" => 20}
customer2.save()
customer3 = Customer.new({"name" => "Claire",
                      "funds" => 40}
customer3.save()
customer4 = Customer.new({"name" => "Fraser",
                      "funds" => 50}
customer4.save()

film1 = Film.new({"title" => "Black Panther",
                  "price" => 5})
film1.save()
film2 = Film.new({"title" => "Avengers: Infinity War",
                  "price" => 5})
film2.save()
film3 = Film.new({"title" => "Solo: A Star Wars Story",
                  "price" => 5})
film3.save()

ticket1 = Ticket.new({"customer_id" => customer1.id,
                      "film_id" => film1.id})
ticket1.save()
ticket2 = Ticket.new({"customer_id" => customer2.id,
                      "film_id" => film3.id})
ticket2.save()
ticket3 = Ticket.new({"customer_id" => customer1.id,
                      "film_id" => film1.id})
ticket3.save()
ticket4 = Ticket.new({"customer_id" => customer3.id,
                      "film_id" => film2.id})
ticket4.save()
ticket5 = Ticket.new({"customer_id" => customer4.id,
                      "film_id" => film2.id})
ticket5.save()
ticket6 = Ticket.new({"customer_id" => customer4.id,
                      "film_id" => film1.id})
ticket6.save()
ticket7 = Ticket.new({"customer_id" => customer2.id,
                      "film_id" => film1.id})
ticket7.save()
ticket8 = Ticket.new({"customer_id" => customer2.id,
                      "film_id" => film3.id})
ticket8.save()
ticket9 = Ticket.new({"customer_id" => customer1.id,
                      "film_id" => film2.id})
ticket9.save()
ticket10 = Ticket.new({"customer_id" => customer3.id, 
                      "film_id" => film1.id})
ticket10.save()
binding.pry
nil
