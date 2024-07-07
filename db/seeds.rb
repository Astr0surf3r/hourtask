# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by(email: 'astr0surf3r@gmail.com') do |u|
    u.password = 'password'
    u.password_confirmation = 'password'
end

# Ensure the user was created successfully
unless user.persisted?
    raise 'Failed to create user'
else
    puts 'Created the first User successfully'
end 

# Create companies
company1 = Company.find_or_create_by!(name: 'Company 1') do |company|
    company.user_id = user.id
end
  
company2 = Company.find_or_create_by!(name: 'Company 2') do |company|
    company.user_id = user.id
end

puts 'created company 1 and company 2'

# Create a few projects

project1 = Project.find_or_create_by(name: 'Project 1', company: company1) do |project|
    project.hourly_rate = 100
    project.currency = 'USD'
    project.previous_hours_worked = 0
    project.previous_hours_paid = 0
    project.user_id = user.id
end

puts 'created project 1'

project2 = Project.find_or_create_by(name: 'Project 2', company: company1) do |project|
    project.hourly_rate = 80
    project.currency = 'USD'
    project.previous_hours_worked = 0
    project.previous_hours_paid = 0
    project.user_id = user.id
end

puts 'created project 2'

task1 = Task.find_or_create_by(description: 'Task 1', project: project1) do |task|
    task.day = Date.today
    task.start_time = Time.now
    task.end_time = Time.now + 1.hour    
    task.project = project1
    task.user_id = user.id
end

task2 = Task.find_or_create_by(description: 'Task 2', project: project1) do |task|
    task.day = Date.today
    task.start_time = Time.now
    task.end_time = Time.now + 1.hour
    task.project = project1
    task.user_id = user.id
end

puts 'created tasks for project 1'

task3 = Task.find_or_create_by(description: 'Task 1', project: project2) do |task|
    task.day = Date.today
    task.start_time = Time.now
    task.end_time = Time.now + 1.hour    
    task.project = project2
    task.user_id = user.id
end

task4 = Task.find_or_create_by(description: 'Task 2', project: project2) do |task|
    task.day = Date.today
    task.start_time = Time.now
    task.end_time = Time.now + 1.hour
    task.project = project2
    task.user_id = user.id
end

puts 'created tasks for project 2'
puts 'Database seeding completed successfully!'