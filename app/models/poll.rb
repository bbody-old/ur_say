class Poll < ActiveRecord::Base
  belongs_to :user
  belongs_to :user
  has_many :options
  has_many :message_sents

  def votes
  	votes = 0
  	self.options.each do |option|
  		votes = votes + option.votes
  	end
  	return votes
  end
end
