class City < ApplicationRecord
    def self.search(term)
        if term
          where('cities.name LIKE ?', "%#{term}%").order(:year)
        else
          all
        end
    end

    def self.countries
        City.order(:country)
    end

    def self.citylist
      City.select("DISTINCT (name) ORDER BY (name) ASC")
    end

end
