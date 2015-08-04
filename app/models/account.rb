class Account < ActiveRecord::Base
  before_save :set_role!

  attr_accessor :full_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable #, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

  # Enumerations
  enum role: [:error, :admin, :broker, :employee]

  # Associations
  belongs_to :meta, polymorphic: true # Polymorphic association for Accounts + Broker/Employee

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
