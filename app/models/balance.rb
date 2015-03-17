class Balance < ActiveRecord::Base
  belongs_to :member
  has_many :balance_datas
end
