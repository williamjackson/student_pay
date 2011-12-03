namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do


    Rake::Task['db:reset'].invoke

    10.times do
      PayPeriod.create!(:end_date => PayPeriod.gen_next_pay_period_end_date)
    end

    current_pay_period = PayPeriod.current.id

    admin = User.create!(:name => "Sarah Gough",
                         :email => "s.gough@utoronto.ca",
                         :password => "william1",
                         :password_confirmation => "william1")
    admin.toggle!(:admin)

    readers = Department.create!(:name => "Reader Services")
    systems = Department.create!(:name => "Systems")
    doug = systems.users.create!(:name => "Douglas Fox",
                                 :email => "douglas.fox@utoronto.ca",
                                 :password => "william1",
                                 :password_confirmation => "william1")
    bev = readers.users.create!(:name => "Bev Branton",
                                :email => "bev.branton@utoronto.ca",
                                :password => "william1",
                                :password_confirmation => "william1")
    halyna = readers.users.create!(:name => "Halyna Kozar",
                                   :email => "halyna.kozar@utoronto.ca",
                                   :password => "william1",
                                   :password_confirmation => "william1")

    doug.toggle!(:supervisor)
    halyna.toggle!(:supervisor)
    bev.toggle!(:supervisor)

    jobs = [["Tech Desk", 2],
            ["E-classroom", 2],
            ["Circulation", 3],
            ["Supervisor", 3]]

    40.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@utoronto.ca"
      password = "password"
      user = User.create!(:name => name,
                          :email => email,
                          :password => password,
                          :password_confirmation => password)
      i = rand(4)
      k = rand(3)
      job = user.jobs.create!(:name => jobs[i][0], :department_id => jobs[i][1])
      if k == 0
        job.pay_sheets.create!(:pay_period_id => current_pay_period)
      elsif k == 1
        pay_sheet = job.pay_sheets.create!(:pay_period_id => current_pay_period)
        pay_sheet.toggle!(:approved)
      end
    end


  end

end