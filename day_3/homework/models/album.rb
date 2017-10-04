require_relative '../db/sql_runner'
require_relative 'artist'


class Album

attr_accessor :album_name, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @album_name = options['album_name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "INSERT INTO albums (
    album_name, genre, artist_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id;
    "
    values = [@album_name, @genre, @artist_id]
    result = SqlRunner.run(sql, "save_artist", values)
    @id = result[0]['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    values = []
    result = SqlRunner.run(sql, "delete_all", values)
  end

  def self.show_albums()
    sql = "SELECT * FROM albums"
    values = []
    list = SqlRunner.run(sql, "show_albums", values)
    return list.map { |albums| Album.new(albums) }
  end

  def album_artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    artists = SqlRunner.run(sql, "album_artist", values)
    return artists.map { |artists| Artist.new(artists)} #because there are multiple hashes returned
  end

  def update()
    sql = "UPDATE albums SET (
    album_name, genre, artist_id
    ) = (
      $1, $2, $3
    ) WHERE id = $4
    ;
    "
    values = [@album_name, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, "update_album", values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE ID=$1"
    values = [@id]
    result = SqlRunner.run(sql, "delete_albums", values)
  end

end
