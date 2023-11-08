class LeaseRepresenter
    def initialize(lease)
        @lease = lease
        @book = lease.book
    end

    def as_json
        {   
            lease_id: @lease.id,
            book_id: @book.id,
            name: @book.title,
            year: @book.publication_year,
            authors: authors_name(@book),
            exp_date: @lease.end_date
        }
    end
    private
    attr_reader :book
    def authors_name(book)
        authors_names = book.authors.map { |author| "#{author.fname} #{author.lname}"}
        authors_names.join(', ')
    end
end