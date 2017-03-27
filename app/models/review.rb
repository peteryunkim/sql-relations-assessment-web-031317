class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id



  def customer
    sql = <<-SQL
      SELECT customers.name
      FROM reviews
      INNER JOIN customers
      ON reviews.customer_id = customers.id
      WHERE reviews.customer_id = ?
      SQL

      self.class.db.execute(sql, self.id)
  end

  def restaurant
    sql = <<-SQL
      SELECT restaurants.name
      FROM reviews
      INNER JOIN restaurants
      ON reviews.restaurant_id = restaurants.id
      WHERE reviews.id = ?
      SQL

      self.class.db.execute(sql, self.id)
  end

end
