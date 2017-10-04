require "pry-byebug"
require_relative "./models/album.rb"
require_relative "./models/artist.rb"

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'artist_name' => 'Genesis',
  })

artist1.save()

artist2 = Artist.new({
  'artist_name' => 'Roger Waters',
  })

artist2.save()



album1 = Album.new({
  'artist_id' => artist1.id,
  'album_name' => 'Three Sides Live',
  'genre' => 'Progressive Rock'
  })

album1.save()

album2 = Album.new({
  'artist_id' => artist1.id,
  'album_name' => 'Abacab',
  'genre' => 'Progressive Rock'
  })

album2.save()

album3 = Album.new({
  'artist_id' => artist2.id,
  'album_name' => 'Amused to Death',
  'genre' => 'Rock'
  })

album3.save()

album4 = Album.new({
  'artist_id' => artist2.id,
  'album_name' => 'Is This the Life We Really Want',
  'genre' => 'Rock'
  })

album4.save()

binding.pry

nil
