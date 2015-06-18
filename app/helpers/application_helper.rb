module ApplicationHelper
	def count_votes user
		polls = Poll.where(user_id: user)
		votes = 0
		
		polls.each do |poll|
			votes = votes + poll.votes
		end
		votes
	end

	def verify_telstra_api
		RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=#{Rails.application.secrets.telstra_public_key}&client_secret=#{Rails.application.secrets.telstra_private_key}&grant_type=client_credentials&scope=SMS"
	end
end
