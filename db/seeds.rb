# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new.tap do |admin|
  admin.email = Rails.application.credentials.default_admin_email!
  admin.password = Rails.application.credentials.default_admin_pass!
  admin.bf_api_token = Other::TokenGenerator.call(6).value_or("123456")
  admin.is_admin = true
  admin.skip_confirmation!
  admin.save!
end
