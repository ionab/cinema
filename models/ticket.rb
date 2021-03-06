require_relative("../db/sql_runner")
require_relative("customer.rb")
require_relative("film.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql,values).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = Ticket.map_tickets(tickets)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def film
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    films = SqlRunner.run(sql, values).first()
    return Film.new(films)

  end

  def customer
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customers = SqlRunner.run(sql, values).first()
    return Customer.new(customers)
  end

  def self.map_tickets(ticket_data)
    return ticket_data.map{|ticket| Ticket.new(ticket)}
  end

end
