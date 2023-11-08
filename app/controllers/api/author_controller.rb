module Api
    class AuthorController < ApplicationController
        before_action :authenticate_user!, except: [:index, :show]
        before_action :set_author, only: [:show]

        # Get /api/author
        def index
            @authors = Author.all
            render json: @authors
        end

        # Get /api/author/:id
        def show
            render json: AuthorRepresenter.new(@author).as_json
        rescue => e
            p "Error: #{e.message}"
        end

        # Post /api/author
        def create
            if current_user.admin?
                author = Author.new(author_params)
                if author.save!
                render json: author, status: :created
                else
                render json: { errors: author.errors.full_messages.to_sentence }, status: :unprocessable_entity
                end
            else
                render json: { error: 'User not signed in' }, status: :unauthorized
                new_user_session_path
            end
        end

        def destroy
            if current_user.admin?
                @author = Author.find(params[:id])
                @author.books.clear
                if @book.destroy
                    render json: {message: 'Author deleted'}, status: :ok
                else
                    render json: {errors: @author.errors.full_messages}, status: :unprocessable_entity
                end
            else
                render json: {message: "User aren't admin"}, status: :ok
            end
        end

        private
        def author_params
            params.require(:author).permit(:fname, :lname)
        end

        def set_author
            @author = Author.find(params[:id])
        end
    end
end