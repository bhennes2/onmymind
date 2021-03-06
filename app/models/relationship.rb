class Relationship < ActiveRecord::Base
	attr_accessible :friend2_id, :state_event

	belongs_to :friend1, class_name: "User"
	belongs_to :friend2, class_name: "User"

	validates :friend1_id, presence: true
	validates :friend2_id, presence: true

	state_machine :initial => :none do
		event :ignite do
			transition :none => :pending
		end
		event :ignite do
			transition :pending => :friends
		end
		event :ignite do
			transition :friends => :none
		end
	end
end
