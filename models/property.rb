require('pg')

class Property

  attr_accessor :address, :value, :year_built, :build
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value']
    @year_built = options['year_built']
    @build = options['build']
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "INSERT INTO property_tracker
           (
            address,
            value,
            year_built,
            build
            )
            VALUES
            (
              $1,
              $2,
              $3,
              $4
              )
              RETURNING *
              ";
    values = [@address, @value, @year_built, @build]

    db.prepare("save", sql)

    @id = db.exec_prepared("save", values)[0]["id"].to_i

    db.close()
  end

  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "UPDATE property_tracker SET
          (address,
           value,
           year_built,
           build) =
           (
             $1, $2, $3, $4
             )
             WHERE id = $5
             "
    values = [@address, @value, @year_built, @build, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "DELETE FROM property_tracker WHERE id = $1"
    values = [@id]
    db.prepare("delete_property", sql)
    db.exec_prepared("delete_property", values)
    db.close
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "SELECT * FROM property_tracker WHERE address = $1 LIMIT 1;"

    values = [address]

    db.prepare("find_property_by_address", sql)

    found_property_by_address = db.exec_prepared("find_property_by_address", values)

    db.close

    return found_property_by_address.map {|property| Property.new(property)}
  end

  def Property.find(id)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "SELECT * FROM property_tracker WHERE id = $1"

    values = [id]

    db.prepare("find_property", sql)

    found_property = db.exec_prepared("find_property", values)

    db.close

    return found_property.map {|property| Property.new(property)}
  end

  def Property.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "SELECT * FROM property_tracker"

    db.prepare("view_all", sql)

    properties = db.exec_prepared("view_all")

    db.close
    return properties.map {|property| Property.new(property)}
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql = "DELETE FROM property_tracker"

    db.prepare("delete_all", sql)

    db.exec_prepared("delete_all")

    db.close()
  end
end
