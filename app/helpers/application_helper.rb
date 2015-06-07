module ApplicationHelper

	def count_votes user
		votes = 0
		polls = Poll.where(user_id: user)
		polls.each do |poll|
			votes = votes + poll.votes
		end
		votes
	end
end
