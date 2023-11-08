class AuthorRepresenter
    def initialize(author)
        @author = author
    end

    def as_json
        {   
            id: author.id,
            name: "#{author.fname} #{author.lname}",
            books: book_name(author)
        }
    end
    
    private
    attr_reader :author
    def book_name(author)
        book_names = author.books.map { |book| "#{book.title}" }
        book_names.join(', ')
    end
end