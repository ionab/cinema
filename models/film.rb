require_relative("../db/sql_runner")
require_relative("customer.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = User.map_films(films)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.customer_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return Cumstomer.map_films(films)
  end

  def self.map_customers(films_data)
    return films_data.map{|film| Film.new(films)}
  end

end
