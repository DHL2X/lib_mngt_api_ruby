module Api
    class BookController < ApplicationController
        before_action :authenticate_user!, except: [:index, :show]
        
        # Get /api/book
        def index
            books = Book.all
            book_json_array = books.map { |book| BookRepresenter.new(book).as_json }
            render json: book_json_array
        rescue => e
            p "Error: #{e.full_message}"
        end

        # Get /api/book/:id
        def show
            book = Book.find(params[:id])
            render json: BookRepresenter.new(book).as_json
        rescue => e
            p "Error: #{e.full_message}"
        end

        # Post /api/book
        def create
            if current_user.admin?
                @author = Author.find_or_create_by(author_params)
                @book = Book.find_or_create_by(book_params)

                unless AuthorsBook.exists?(book: @book, author: @author)
                    authors_books = AuthorsBook.new(book: @book, author: @author)

                    if authors_books.save
                        render json: BookRepresenter.new(@book).as_json, status: :created
                    else
                        render json: {
                            error: 'Failed to create the association',
                            errors: authors_books.errors.full_messages
                            }, status: :unprocessable_entity
                    end
                else
                    render json: {message: 'Association already exists'}, status: :ok
                end

            else
                render json: { error: "User aren't admin" }, status: :unauthorized
                new_user_session_path
            end
        end

        #PUT/PATCH /api/book/:id
        def update
            if current_user.admin?
                @book = Book.find(params[:id])

                if @book.update(book_params)
                    render json: BookRepresenter.new(@book).as_json, status: :ok
                else
                    render json: {errors: @book.errors.full_messages}, status: :unprocessable_entity
                end
            else
                render json: {message: "User aren't admin"}, status: :ok
            end
        end

        # DELETE /api/book/:id
        def destroy
            if current_user.admin?
                @book = Book.find(params[:id])
                @book.authors.clear
                if @book.destroy
                    render json: {message: 'Book deleted'}, status: :ok
                else
                    render json: {errors: @book.errors.full_messages}, status: :unprocessable_entity
                end
            else
                render json: {message: "User aren't admin"}, status: :ok
            end
        end

        private
        def author_params
            params.require(:author).permit(:fname, :lname)
        end

        def book_params
            params.require(:book).permit(:title, :publication_year, :quantity, :server_id)
        end

        
    end
end
