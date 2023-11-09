# Use an official Ruby runtime as a parent image
FROM ruby:3.0.2

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Rails dependencies
RUN bundle install

# Copy the rest of your application's code into the container
COPY . .

# Expose a port to access your Rails application
EXPOSE 3000

# Start your Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]

