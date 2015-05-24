module PollsHelper
	def days_left due_date
		if (due_date - Date.today).to_i <= 0
			"Complete"
		elsif due_date != nil
			return (due_date - Date.today).to_i.to_s + " days"
		else
			return "Indefinite"
		end
  	end

  	def percentage due_date, created_date
  		if (due_date - Date.today).to_i <= 0
  			"100%"
  		else
  			total_duration = (due_date - created_date.to_date).to_i
  			progress = (Date.today - created_date.to_date).to_i

  			percentage =  (progress.to_f / total_duration.to_f) * 100.0
  			percentage.to_s + "%"
  		end
  	end

end
