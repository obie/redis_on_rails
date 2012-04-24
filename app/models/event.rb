class Event < ActiveRecord::Base
	def description
	 rdb[:description].get
	end
	def description=(d)
	 rdb[:description].set d
	end
end