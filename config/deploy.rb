# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p0'
set :rvm_type, :user  # Don't use system-wide RVM

# bundler bootstrap
require 'bundler/capistrano'

# main details
set :application, "library-test.vulcan.lan"
role :web, "library-test.vulcan.lan"
role :app, "library-test.vulcan.lan"
role :db,  "library-test.vulcan.lan", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/part-time-pay"
set :deploy_via, :remote_cache
set :user, "jackson"
set :use_sudo, false

# repo details
set :scm, :git
set :scm_username, "william.jackson@utoronto.ca"
set :repository, "git://github.com/williamjackson/student_pay.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end