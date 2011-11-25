Factory.define :user do |user|
  user.name                   "Frank Sinatra"
  user.email                  "frank.sinatra@utoronto.ca"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end