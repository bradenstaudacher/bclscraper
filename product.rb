class Product
  attr_accessor :name, :volume, :country, :sku, :rating, :price, :units

  def initialize(name, volume, country, sku, rating, price, units)
    @name = name
    @volume = volume
    @country = country
    @sku = sku
    @rating = rating
    @price = price
    @units = units
  end
end