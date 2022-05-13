# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

@user1 = User.create(email: 'aedan@test.com', password: '123password', password_confirmation: '123password')
@user2 = User.create(email: 'brenda@test.com', password: 'password123', password_confirmation: 'password123')
@user3 = User.create(email: 'emily@test.com', password: 'plantconnect', password_confirmation: 'plantconnect')
@user4 = User.create(email: 'jerry@test.com', password: 'madprops', password_confirmation: 'madprops')
@user5 = User.create(email: 'katie_a@test.com', password: 'seedly', password_confirmation: 'seedly')
@user6 = User.create(email: 'katie_t@test.com', password: 'stemswap', password_confirmation: 'stemswap')
@user7 = User.create(email: 'paul@test.com', password: 'plantydropper', password_confirmation: 'plantydropper')
@user8 = User.create(email: 'steven@test.com', password: 'nogreenthumbs', password_confirmation: 'nogreenthumbs')
