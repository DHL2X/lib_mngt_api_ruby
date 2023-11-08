class Book < ApplicationRecord
    validates :publication_year, numericality: {greater_than_or_equal_to: 0}
    validates :title, presence: true, uniqueness: true
    validates :quantity, presence: true, numericality: {greater_than: 0}

    has_many :authors_books
    has_many :authors, through: :authors_books

    has_many :leases
    has_many :users, through: :leases

    def active_leases_count
        leases.where("start_date <= ? AND end_date > ?", Date.today, Date.today).count
    end
    
end
