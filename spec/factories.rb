Factory.define :user do |user|
  user.name                   "Frank Sinatra"
  user.email                  "frank.sinatra@utoronto.ca"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :job do |job|
  job.name "default"
  job.association :user
end

Factory.define :pay_period do |pay_period|
  pay_period.end_date PayPeriod.gen_next_pay_period_end_date
end

Factory.define :pay_sheet do |pay_sheet|
  pay_sheet.association :pay_period
  pay_sheet.association :job
end

Factory.define :shift do |shift|
  shift.associate :pay_sheet
  shift.date  :today
  shift.shift "9-12"
  shift.hours 3
  
end