require 'clockwork'
module Clockwork

  handler do |job|
    puts "Running #{job}"
  end

  every(10.seconds, 'testing.job') do
    puts 'lmao'
    # HelloJob.perform_async('lmeo')
  end

  # every(1.day, 'daily.job', at:'00:00') do
  # puts 'daily job here'
  # end
end