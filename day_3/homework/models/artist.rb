require_relative '../db/sql_runner'
require_relative 'album'


class Artist

attr_accessor :artist_name
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @artist_name = options['artist_name']
  end

  def save()
    sql = "INSERT INTO artists (
    artist_name
    )
    VALUES
    (
      $1
    )
    RETURNING id;
    "
    values = [@artist_name]
    result = SqlRunner.run(sql, "save_artist", values)
    @id = result[0]['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    values = []
    result = SqlRunner.run(sql, "delete_all", values)
  end

  def self.show_artists()
    sql = "SELECT * FROM artists"
    values = []
    list = SqlRunner.run(sql, "show_artists", values)
    return list.map { |artist| Artist.new(artist) }
  end

  def artist_albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, "artist_albums", values)
    return albums.map { |albums| Album.new(albums)} #because there are multiple hashes returned

  end

  def update()
    sql = "UPDATE artists SET (
    artist_name
    ) = (
      $1
    ) WHERE id = $2
    ;
    "
    values = [@artist_name, @id]
    result = SqlRunner.run(sql, "update_artist", values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE ID=$1"
    values = [@id]
    result = SqlRunner.run(sql, "delete_artist", values)
  end

  # def self.find(first_name)
  #   sql = "SELECT * FROM customers WHERE first_name = $1"
  #   values = [first_name]
  #   custs = SqlRunner.run(sql, "delete_all", values)# add [0] if not using .map
  #   return custs.map { |cust_hash| Customer.new(cust_hash) }
  # end
  #
  
  # end


end
