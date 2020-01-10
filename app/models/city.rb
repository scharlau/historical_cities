class City < ApplicationRecord
    def self.search(term)
        if term
          where('cities.name LIKE ?', "%#{term}%").order(:year)
        else
          all
        end
    end

    def self.year
      all.order(:year)
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
