# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  customer_user_id :bigint
#  total            :float
#  status           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Transaction < ApplicationRecord
  belongs_to :customer_user, :class_name => 'User'

  validates :total, presence: true


  after_create :change_user_order_to_paid


  private

  def change_user_order_to_paid
    self.customer_user.user_customer.each do |order|
      order.update_order_to_paid
    end
  end
end
