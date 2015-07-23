class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable #, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

  # Enumerations
  enum role: [:error, :admin, :broker, :employee]

  # Associations
  belongs_to :broker_acct

  # Methods
  # get Full Name
  def full_name
    self.fname + " " + self.lname
  end


end
