class EmployeeAcct < ActiveRecord::Base
  # Associations
  has_one :account, as: :meta, dependent: :destroy

  # Enumerations
  enum role: [:error, :underwriter, :reviewer, :manager]

  # Validations
  validates :role, presence: true
end
