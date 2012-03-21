class Relationship < ActiveRecord::Base
	attr_accessible :friend2_id

	belongs_to :friend1, class_name: "User"
	belongs_to :friend2, class_name: "User"

	validates :friend1_id, presence: true
	validates :friend2_id, presence: true

end
