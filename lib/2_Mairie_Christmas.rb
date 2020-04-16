require 'rubygems'
require 'nokogiri'
require 'rest-client'

def target(page,name,xpath)
    name = page.xpath(xpath).collect(&:text)
end

def zip_and_store(a,b)
    zip_tags = a.zip(b)
    l = []
    zip_tags.each { |v,k|
        h = {}
        h.store(v,k)
        l << h
        p l
    } 
end

homepage_url = "http://annuaire-des-mairies.com/"
departement_page = Nokogiri::HTML(RestClient.get(homepage_url))
departement_number_name_xpath ="//td//a[@class='lientxt']/@title"
departement_number_name = target(departement_page,departement_number_name,departement_number_name_xpath)


all_departement_url_list =[]
departement_number_name.each do |i|
    number = i[0,3]
    name = i 
    all_departement_url_list<< homepage_url+number.delete(' ')+"/"
end


url_of_all_city = []
all_email = []
all_departement_url_list.each do |i|
    city_page = Nokogiri::HTML(RestClient.get(i))
    city_url_xpath ="//pre//a/@href"
    
    city = target(city_page,city,city_url_xpath)
    #p i 
    city.each do |k|
        #p i+k
        url_of_all_city << i+k
        url_of_all_city.each do |j|
            detail_page = Nokogiri::HTML(RestClient.get(j))
            city_url_xpath="/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]"
            email = target(detail_page,email,city_url_xpath)
            unless email.empty?
                all_email << email
            end
        end
    end

end

p all_email