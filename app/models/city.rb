class City < ApplicationRecord
  has_one :country  
  
  def self.baseCity
    @cities = City.all
    @cities.each do |city|
      country = Country.find(city.country_id)
      city.countryName = country.name.to_s
    end
  end

  def self.search(term)
        if term
          where('cities.name LIKE ?', "%#{term}%").order(:year)
        else
          baseCity
        end
    end

    def self.year
      @cities = all.order(:year)
      @cities.each do |city|
        country = Country.find(city.country_id)
        city.countryName = country.name.to_s
      end
      return @cities

    end

    def self.countries
        all.order(:country)
    end

    def self.names
      all.select(:name).distinct.order(:name)
    end

    def self.citylist
      City.find_by_sql("SELECT * FROM (SELECT DISTINCT ON (name) * from public.cities ORDER BY (name)) t ORDER by (year)")
    end

end
