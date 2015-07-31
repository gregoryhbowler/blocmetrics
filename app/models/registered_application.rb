# == Schema Information
#
# Table name: registered_applications
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
