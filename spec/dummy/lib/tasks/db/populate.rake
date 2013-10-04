# encoding: utf-8
namespace :db do
  desc 'Create some foos'
  task :populate => [:environment] do
    50.times do
      Foo.create!(
        name: Faker::Name.name,
        category: Faker::Name.name,
        published: (rand(10)%2 == 0)
      )
    end
    5.times do
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        admin: (rand(10)%2 == 0),
        password: 'password'
      )
    end
  end
end
