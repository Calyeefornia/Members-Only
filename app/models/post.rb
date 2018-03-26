class Post < ApplicationRecord
	belongs_to :user
	validates :body, presence: true, length: { maximum: 500 }
	validates :title, presence: true, length: { maximum: 200 }
	validates :user_id, presence: true
end
