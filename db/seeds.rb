# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'admin 1', email: 'admin1@yopmail.com', password: 'admin@123', role: 'admin')
User.create(name: 'admin 2', email: 'admin2@yopmail.com', password: 'admin@123', role: 'admin')