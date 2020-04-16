require 'rubygems'
require 'nokogiri'
require 'rest-client'


url = "http://annuaire-des-mairies.com/"
page = Nokogiri::HTML(RestClient.get(url))   
#puts page.class   # => Nokogiri::HTML::Document

def get_townhall_email(townhall_url)
end

def get_townhall_urls()