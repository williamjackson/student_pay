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

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@utoronto.ca"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    pay_period_date = Date.today
    while !pay_period_date.sunday?
      pay_period_date + 1
    end
    10.times do
        PayPeriod.create!(:end_date => pay_period_date)
      pay_period_date + 14
    end
  end

end