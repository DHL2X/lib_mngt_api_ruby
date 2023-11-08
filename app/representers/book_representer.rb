class BookRepresenter
    def initialize(book)
        @book = book
    end

    def as_json
        {   
            id: book.id,
            name: "#{book.title}",
            year: book.publication_year,
            authors: authors_name(book),
            rented: "#{book.active_leases_count} / #{book.quantity}"
        }
    end
    private
    attr_reader :book
    def authors_name(book)
        authors_names = book.authors.map { |author| "#{author.fname} #{author.lname}"}
        authors_names.join(', ')
    end
end