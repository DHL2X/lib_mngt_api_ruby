module Api
    class LeaseController < ApplicationController
        before_action :authenticate_user!

        def index
            HelloJob.perform_async(current_user.id)
            if current_user.admin?
                leases = Lease.where("end_date > ?", Date.today)
                leases_json_array = leases.map { |lease| LeaseRepresenter.new(lease).as_json }
                render json: leases_json_array
            else
                leases = Lease.where(user_id: current_user.id).where("end_date > ?", Date.today)
                leases_json_array = leases.map { |lease| LeaseRepresenter.new(lease).as_json }
                render json: leases_json_array
            end
        rescue => e
            p "Error: #{e.full_message}"
        end

        def return_book
            HelloJob.perform_async(current_user.id)
            begin
                lease = Lease.find(params[:id])
                if lease.user == current_user && lease.active?
                    if lease.update(end_date: Date.today)
                        render json: {message: "Book #{lease.book.title} returned successfully"}, status: :ok
                    else
                        render json: {error: "Unable to update lease in #{Date.today}, error: #{lease.errors.full_messages}"}, status: :unprocessable_entity
                    end
                else
                    render json: {error: "Unable to return book"}, status: :unprocessable_entity
                end
            rescue ActiveRecord::RecordNotFound
                render json: { error: "Lease not found"}, status: :unprocessable_entity
            rescue => e
                render json: { error: "#{e.full_message}"}, status: :unprocessable_entity
            end
        end

        def create
            HelloJob.perform_async(current_user.id)
            user = User.find(current_user.id)
            book = Book.find(params[:book_id])
            # same_server = user.server && book.server && user.server.id == book.server.id #no needed

            if Lease.is_valid_to_rent(user, book)# && same_server
                end_date = Date.today + 14.days
                lease = Lease.new(user: user, book: book, start_date: Date.today, end_date: end_date)
                if lease.save
                    render json: lease, status: :created
                else
                    render json: { errors: lease.errors.full_messages}, status: :unprocessable_entity
                end
            else
                render json: {error: "Cannot rent the book. An active lease already exists."}, status: :unprocessable_entity
            end
        end
    end
end
