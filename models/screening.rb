require_relative("../db/sql_runner")
require_relative("film.rb")

class Screening

  attr_reader :id
  attr_accessor :tfilm_id, :show_date, :time, :capacity

  def initialize( options )
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @show_date = options['show_date']
    @time = options['time']
    @capacity = options["capacity"].to_i
  end

  def save()
    sql = "INSERT INTO screenings (film_id, show_date, time, capacity) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@film_id, @show_date, @time, @capacity]
    screening = SqlRunner.run( sql, values ).first
    @id = screening['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screening = SqlRunner.run(sql, values)
    result = Screening.map_screenings(screening)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.map_screenings(screenings_data)
    return screenings_data.map{|screening| Screening.new(screening)}
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN screenings ON films.id = screenings.film_id WHERE screenings.film_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Film.map_films(films)
    return result
  end


end
