class Post < ActiveRecord::Base

	validates :content, presence: true
	belongs_to :group
	belongs_to :author, class_name: "User", foreign_key: "user_id"

	def is_editable_by?(user)
		if user && user_id == user.id
			true
		else
			false
		end
	end


end
