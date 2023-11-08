# README

bundle install

rspec spec/

details testing with postman:

localhost,lvh.me is public tenant
vn.lvh.me is vn tenant
eu.lvh.me is eu tenant

header("Api"=>"v001") for versionist

POST http://localhost:3000/login //login(admin: long@gmail.com)
{
    "user": {
        "email": "long@gmail.com",
        "password": "Password@123"
    }
}

POST eu.lvh.me:3000/signup or vn.lvh.me:3000/signup //signup to separate server
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
