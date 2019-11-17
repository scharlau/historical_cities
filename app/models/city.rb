class City < ApplicationRecord
    def self.search(term)
        if term
          where('name LIKE ?', "%#{term}%")
        else
          all
        end
    end

    def self.countries
        City.order(:Country)
    end

end
