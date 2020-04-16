require 'rubygems'
require 'nokogiri'
require 'rest-client'

def target(page,name,xpath)
    name = page.xpath(xpath).collect(&:text)
    name
end
def zip_and_store(a,b)
    zip_tags = a.zip(b)
    l = []
    zip_tags.each { |v,k|
        h = {}
        h.store(v,k)
        l << h
    }
p l   
end

url = "https://coinmarketcap.com/all/views/all/"
page = Nokogiri::HTML(RestClient.get(url))   

symbol_xpath = "//tbody//tr//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol']//div/text()"
price_xpath = "//tbody//tr//td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']//a[@class='cmc-link']//text()"
symbol_tags , price_tags = [] , []

symbol_tags = target(page,symbol_tags,symbol_xpath)
price_tags = target(page,price_tags,price_xpath)
zip_and_store(symbol_tags,price_tags)
