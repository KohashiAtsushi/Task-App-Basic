class Task < ApplicationRecord
  belongs_to :user
  validates :index, presence: true ,length: { minimum: 5 }
  validates :contents,  presence: true, length: { maximum: 500 }
end
