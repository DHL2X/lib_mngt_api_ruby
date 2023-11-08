class Author < ApplicationRecord
    validates :fname, presence: true
    validates :lname, presence: true

    has_many :authors_books
    has_many :books, through: :authors_books
    
end