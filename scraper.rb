require "open-uri"
require "nokogiri"
require "pry"
require_relative "product"

website = "http://www.bcliquorstores.com/product-catalogue"
begin
@doc = Nokogiri::HTML(open(website))
rescue
  puts "Invalid URL"
end

##### ------- Scrap Helper Methods ------------- ######
def grab_text(arr)
array_of_blank = []
  arr.each do |content|
    array_of_blank << content.text()
  end
  return array_of_blank
end

def grab_num(arr)
array_of_blank = []
  arr.each do |content|
    array_of_blank << content.text().delete("^0-9").to_i
  end
  return array_of_blank
end

def grab_float(arr)
array_of_blank = []
  arr.each do |content|
    array_of_blank << content.text().to_f
  end
  return array_of_blank
end

def grab_price(arr)
  array_of_blank = []
  arr.each do |content|
    array_of_blank << no_dollar_signs(content.text())
  end
  return array_of_blank.compact
end

def grab_units(arr)
array_of_blank = []
  arr.each do |content|
    array_of_blank << grab_units_from_string(content.text())
  end
  return array_of_blank
end

def grab_stores(arr)
array_of_blank = []
  arr.each do |content|
    array_of_blank << grab_stores_from_string(content.text())
  end
  return array_of_blank
end

def no_dollar_signs(string)
  if !!(string =~ /\$[\d]+\.[\d]{2}/)
    return /\$([\d]+\.[\d]{2})/.match(string)[1]
  end
end

def grab_units_from_string(string)
  return /([\d]+).* ([\d]+)/.match(string)[1]
end

def grab_stores_from_string(string)
  return /([\d]+).* ([\d]+)/.match(string)[2]
end


#### ------- Comment Information Scrape ------------- ######

def get_names
  units = grab_text(@doc.xpath("//div[contains(@class, 'productlistdetail')]/h3"))
end

def get_volume
  volumes = grab_text(@doc.xpath("//li[contains(@class, 'product-detail-item Volume')]"))
end

def get_country
  countries = grab_text(@doc.xpath("//li[contains(@class, 'product-detail-item Country')]"))
end

def get_skus
  skus = grab_text(@doc.xpath("//li[contains(@class, 'product-detail-item SKU')]"))
end

def get_ratings
  ratings = grab_float(@doc.xpath("//div[contains(@class, 'description')]/div/span[1]"))
end

def get_number_of_votes
  votes = grab_num(@doc.xpath("//div[contains(@class, 'description')]/div/span[2]"))
end

def get_price
  price = grab_price(@doc.xpath("//div[contains(@class, 'product-info')]/div"))
end

def get_units
  units = grab_units(@doc.xpath("//div[contains(@class, 'inventory')]"))
end

def get_stores
  units = grab_stores(@doc.xpath("//div[contains(@class, 'inventory')]"))
end

############ -------------- Product Creator ------------------ ##############
def generate_product_array
  product_full = get_names.zip(get_volume,get_country,get_skus,get_ratings,get_number_of_votes,get_price,get_units,get_stores)
end

def populate_products
  productarr = []
  generate_product_array.each do |attribute|
    productarr << Product.new(attribute[0],attribute[1],attribute[2],attribute[3],attribute[4],attribute[5],attribute[6],attribute[7],attribute[8])
  end
  return productarr
end


binding.pry
