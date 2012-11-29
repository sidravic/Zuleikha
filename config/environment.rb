# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AsyncProcess::Application.initialize!
require "#{Rails.root}/lib/zuleikha/lib/zuleikha.rb"