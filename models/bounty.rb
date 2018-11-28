require('pg')
require('pry')

class Bounty

  attr_accessor :name, :bounty_value, :last_known_location, :favourite_weapon

  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i()
    @last_known_location = options['last_known_location']
    @favourite_weapon = options['favourite_weapon']
  end

  def save()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO bounties(name, bounty_value, last_known_location, favourite_weapon)
    VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@name, @bounty_value, @last_known_location, @favourite_weapon]
    db.prepare('save', sql)
    @id = db.exec_prepared('save', values)[0]['id'].to_i
    db.close()
  end

  def Bounty.all
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties"
    db.prepare('all', sql)
    bounties = db.exec_prepared('all')
    db.close()
    return bounties.map {|bounty| Bounty.new(bounty)}
  end

  def Bounty.delete_all
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties"
    db.prepare('delete_all', sql)
    db.exec_prepared('delete_all')
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "UPDATE bounties SET (name, bounty_value, last_known_location, favourite_weapon) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name, @bounty_value, @last_known_location, @favourite_weapon, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

  def delete_one()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare('delete_one', sql)
    db.exec_prepared('delete_one', values)
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [name]
    db.prepare('find_by_name', sql)
    results_array = db.exec_prepared('find_by_name', values)
    db.close()

    if results_array.count > 0
      bounty_hash = results_array[0]
    else
      return nil
    end

    return Bounty.new(bounty_hash)

    # found_bounty = db.exec_prepared('find_by_name', values)
    # db.close
    # return Bounty.new(found_bounty.first)
    # this way does not return nil if name not found
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"
    values = [id]
    db.prepare('find_by_id', sql)
    results_array = db.exec_prepared('find_by_id', values)
    db.close()

    if results_array.count > 0
      bounty_hash = results_array[0]
    else
      return nil
    end

    return Bounty.new(bounty_hash)

    # bountys = db.exec_prepared('find_by_id', values)
    # db.close
    # return Bounty.new(bountys.first)
  end

end
