class HelloJob
  include Sidekiq::Job

  def perform(user_id)
    puts user_id
  end

end
