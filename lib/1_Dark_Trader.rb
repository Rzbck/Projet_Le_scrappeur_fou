require 'rubygems'
require 'nokogiri'
require 'rest-client'


url = "https://coinmarketcap.com/all/views/all/"
page = Nokogiri::HTML(RestClient.get(url))   
#puts page.class   # => Nokogiri::HTML::Document

symbol_tags = page.xpath("//tbody//tr//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol']//div/text()").collect(&:text)
price_tags = page.xpath("//tbody//tr//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']//a[@class='cmc-link']//text()").collect(&:text)

zip_tags = symbol_tags.zip(price_tags)

l = []
zip_tags.each { |v,k|
    h = {}
    h.store(v,k)
    l << h
}

p l
