Apartment::Tenant.switch!('public')

eu_tenant_name = 'eu'
unless Apartment.tenant_names.sort.include?(eu_tenant_name)
  Apartment::Tenant.create(eu_tenant_name)
end

vn_tenant_name = 'vn'
unless Apartment.tenant_names.sort.include?(vn_tenant_name)
  Apartment::Tenant.create(vn_tenant_name)
end

Apartment::Tenant.switch!('eu')
book1=Book.find_or_create_by(title: "Sample1", publication_year:2020, quantity:4)
author1=Author.find_or_create_by(fname:"Long", lname:"Do")
unless book1.authors.include?(author1)
    book1.authors<<author1
end

user1=User.find_or_create_by(email:"long@gmail.com",role:1)
user1.password="Password@123"
user1.save

Apartment::Tenant.switch!('vn')
book2=Book.find_or_create_by(title: "Sample2", publication_year:2021, quantity:5)
author2=Author.find_or_create_by(fname:"Long", lname:"Do")
author3=Author.find_or_create_by(fname:"JP", lname:"Morgan")
unless book2.authors.include?(author2) || book2.authors.include?(author3)
    book2.authors<<author2
    book2.authors<<author3
end

user2=User.find_or_create_by(email:"long1@gmail.com",role:1)
user2.password="Password@123"
user2.save

