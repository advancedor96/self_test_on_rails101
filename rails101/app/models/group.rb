class Group < ActiveRecord::Base
	validates :title, presence: true

	belongs_to :owner, class_name: "user", foreign_key: "user_id"
	has_many :posts, dependent: :destroy
	has_many :group_users
	has_many :members, through: :group_users, source: :user

	def is_editable_by?(user)

		if user && user_id == user.id
			true
		else
			false
		end

	end

end
