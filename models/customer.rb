require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("ticket.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    user = SqlRunner.run(sql, values).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = Customer.map_customers(customers)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_films(films)
  end

  def self.map_customers(customer_data)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  def buy(film)
    @funds -= film.price
  end

  def count_of_customers_tickets()
    return films.count
  end



end
