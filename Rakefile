# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rollbar/rake_tasks'
require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :environment do
  Rollbar.configure do |config|
    config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]
  end
end