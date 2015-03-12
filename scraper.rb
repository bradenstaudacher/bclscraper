require "open-uri"
require "nokogiri"
require "pry"
require_relative "product"

website = "http://www.bcliquorstores.com/product-catalogue?type=wine&start=10"
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

def no_dollar_signs(string)
  if !!(string =~ /\$[\d]+\.[\d]{2}/)
    return /\$([\d]+\.[\d]{2})/.match(string)[1]
  end
end


#### ------- Comment Information Scrape ------------- ######
def get_products
  products = @doc.xpath("//ul[contains(@class, 'content')]/li")
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
  votes = grab_price(@doc.xpath("//div[contains(@class, 'product-info')]/div"))
end

get_price
binding.pry
