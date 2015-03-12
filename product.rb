class Product
  attr_accessor :name, :volume, :country, :sku, :rating, :number_of_votes, :price, :units, :stores

  def initialize(name, volume, country, sku, rating, number_of_votes, price, units, stores)
    @name = name
    @volume = volume
    @country = country
    @sku = sku
    @rating = rating
    @number_of_votes = number_of_votes
    @price = price
    @units = units
    @stores = stores
  end
end