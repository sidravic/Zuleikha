class DobCreator
	def self.perform(user_id)
		user = User.find(user_id)
		user.dob =  Date.today - user.age.years
		user.save
	end
end