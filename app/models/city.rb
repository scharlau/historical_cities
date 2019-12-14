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
      City.select("SELECT DISTINCT ON (name) * FROM public.cities ORDER BY (name) ASC")
    end

end
