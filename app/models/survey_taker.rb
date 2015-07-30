class SurveyTaker < ActiveRecord::Base

	def self.search(search)
		puts search.class
		where(number: search)
	end
end
