module Zuleikha
	class Worker
		include Zuleikha::Helpers

		def work
			loop do				
				pid = fork do					
					redis.client.reconnect
					job = fetch_job		
					puts "#{job.inspect}"		
					exit if job.nil?
					klass = job["class"]
					args = job["args"]
					klass.constantize.perform(*args)
				end
				Process.wait(pid)
				puts "Sleeping...."
				sleep(5)
			end
		end

		def fetch_job
			Zuleikha.fetch_job
		end
	end
end