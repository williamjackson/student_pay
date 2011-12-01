namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "jones",
                         :email => "jones@utoronto.ca",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    admin.toggle!(:supervisor)

    10.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@utoronto.ca"
      password = "password"
      user = User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      user.jobs.create!(:name => "default")
    end

    10.times do
        PayPeriod.create!(:end_date => PayPeriod.gen_next_pay_period_end_date)
    end
  end

end