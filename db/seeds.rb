# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.where(email: 'admin@example.com').first
  User.create_without_confirmation(
    email: 'admin@example.com', password: 'password', role: 'admin'
  )
end
