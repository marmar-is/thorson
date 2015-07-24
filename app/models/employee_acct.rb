class EmployeeAcct < ActiveRecord::Base
  # Associations
  has_one :account, as: :meta, dependent: :destroy

  # Enumerations
  enum role: [:error, :underwriter, :reviewer, :manager]

  # Validations
  validate :role, presence: true
end
