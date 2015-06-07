module ApplicationHelper
	def count_votes user
		polls = Poll.where(user_id: user)
		votes = 0
		polls.each do |poll|
			votes = votes + poll.votes
		end
		votes
	end
end
