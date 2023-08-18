# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  title      :string
#  content    :text
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :title, presence: true
  validates :content, presence: true
end
