

namespace "z" do

	desc "Start a Resque worker"
	task :work => [:preload, :setup] do
		worker = Zuleikha::Worker.new
		worker.work()
	end

	task :setup => :environment do
	end

	desc "load app files for Rails"
	task :preload => :setup do
		if defined?(Rails) && Rails.respond_to?(:application)
			#Rails.application.eager_load! 
			require "#{Rails.root}/config/environment.rb"
			require "#{Rails.root}/lib/zuleikha/lib/zuleikha.rb"
		else
			puts "Zuleikha is only compatible with Rails applications for now"
		end
	end
end
