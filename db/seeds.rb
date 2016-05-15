unless User.where(email: 'admin@example.com').first
  User.create_without_confirmation(
    email: 'admin@example.com', password: 'password', role: 'admin',
    customer_code: 'hs0001'
  )
  puts 'Created a admin user. Please log in with admin@example.com!'
end
