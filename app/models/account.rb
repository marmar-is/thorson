class Account < ActiveRecord::Base
  # ActiveRecord Callbacks
  before_save :set_role!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable #, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

  # Enumerations
  enum role: [:error, :admin, :broker, :employee]

  # Associations
  belongs_to :meta, polymorphic: true # Polymorphic association for Accounts + Broker/Employee

  # Accessors
  attr_accessor :full_role

  # Methods
  # get Full Name
  def full_name
    self.fname + " " + self.lname
  end

  private
  def set_role!
    self.role = self.full_role.split('_')[1]
  end

end
