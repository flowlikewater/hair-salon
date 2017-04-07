class Stylist


  attr_reader(:id, :name, :experience)
  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes.fetch(:name)
    @experience = attributes.fetch(:experience)
  end

  define_singleton_method(:all) do
    stylists = []
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    returned_stylists.each() do |stylist|
      id = stylist.fetch('id').to_i()
      name = stylist.fetch('name')
      experience = stylist.fetch('experience').to_i()
      stylists.push(Stylist.new({:id => id, :name => name, :experience => experience}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name, experience) VALUES ('#{@name}', #{@experience}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_stylist|
    (self.name() == another_stylist.name()) &&
    (self.id() == another_stylist.id()) &&
    (self.experience == another_stylist.experience())
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id == id
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @experience = attributes.fetch(:experience, @experience)
    DB.exec("UPDATE stylists SET name = '#{@name}', experience = #{@experience} WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_method(:clients) do
    clients = []
    results =  DB.exec("SELECT * FROM clients WHERE stylist_id=#{@id}")
    results.each() do |result|
      name = result.fetch('name')
      id = result.fetch('id').to_i()
      stylist_id = result.fetch('stylist_id').to_i()
      clients.push(Client.new(:name => name, :id => id, :stylist_id => stylist_id))
    end
    clients
  end


end
