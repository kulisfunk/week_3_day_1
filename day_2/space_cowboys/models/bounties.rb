require "pg"

class Bounties

attr_accessor :name, :bounty, :homeworld, :favourite_weapon

def initialize(params)
  @id = params['id'].to_i() if params['id']
  @name = params['name']
  @bounty = params['bounty'].to_i()
  @homeworld = params['homeworld']
  @favourite_weapon = params['favourite_weapon']
end

def save()
  db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  sql = "INSERT INTO bounty_list
  (
    name,
    bounty,
    homeworld,
    favourite_weapon
    )
    VALUES
    (
      $1, $2, $3, $4
      )
      RETURNING *
      ;
      "
      values = [@name, @bounty, @homeworld, @favourite_weapon]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i
      db.close
end

def self.delete_all()
  db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  sql = "DELETE FROM bounty_list;"
  values = []
  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all", values)
  db.close
end


def delete()
  db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  sql = "DELETE FROM bounty_list WHERE id=$1;"
  values = [@id]
  db.prepare("delete", sql)
  db.exec_prepared("delete", values)
  db.close
end

def update()
  db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
  sql = "UPDATE bounty_list
  SET
  (
    name,
    bounty,
    homeworld,
    favourite_weapon
  ) = (
    $1, $2, $3, $4
    ) WHERE id = $5;"
    values = [@name, @bounty, @homeworld, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def self.find(homeworld) #called by Bounties.find
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounty_list WHERE homeworld=$1;"
    values = [homeworld]
    db.prepare("find", sql)
    perps = db.exec_prepared("find", values)
    db.close
    return perps.map { |perp_hash| Bounties.new(perp_hash) }
  end




end
