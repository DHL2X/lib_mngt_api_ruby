# README

bundle install (then bin/dev)

//pg_restore -U username -d new_database_name -1 -v "test_db_development.backup" to import DB if already have

sudo docker-compose build
sudo docker-compose up
sudo docker-compose run app rails db:create
sudo docker-compose run app rails db:migrate
sudo docker-compose run app rails db:seed
sudo docker-compose run app rails db:migrate

*details testing with postman:

header("Api"=>"v001") for versionist
header("Server"=>"vn") for change tenant ("eu","public")

POST http://localhost:3000/login //login(admin: long@gmail.com)
{
    "user": {
        "email": "long@gmail.com",
        "password": "Password@123"
    }
}

POST lvh.me:3000/signup //signup to separate server
{
    "user": {
        "email": "long8@gmail.com",
        "password": "Password@123",
        "password_confirmation": "Password@123"
    }
}

POST http://localhost:3000/api/book //create book
{
  "author": {
    "fname": "Long",
    "lname": "Do"
  },
  "book": {
    "title": "Sample 3",
    "publication_year": 2023,
    "quantity": 7,
    "server_id": 2
  }
}

PUT/PATCH http://localhost:3000/api/book/5 //update info book's
{
  "book": {
    "title": "Sample Book"
  }
}

POST http://localhost:3000/api/lease //create new lease with current user
{
  "book_id": 4
}

PATCH http://localhost:3000/api/lease/:id/return_book //return book