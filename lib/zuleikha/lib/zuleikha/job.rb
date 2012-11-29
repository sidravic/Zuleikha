module Zuleikha
	class Job
	    attr_reader :queue
	    
	    def initialize()
	      @queue = queue      
	    end

	    def self.create(klass, args)      
	      queue = :zu
	      Zuleikha.push(queue, {:class => klass, :args => args})
	    end
  	end
end