class Story < ActiveRecord::Base
  belongs_to :user

  validates :body, :title, :user_id, presence: true
end
