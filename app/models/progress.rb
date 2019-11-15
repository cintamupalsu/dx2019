class Progress < ApplicationRecord
  belongs_to :status
  belongs_to :report
  belongs_to :user
end
