class Account < ActiveRecord::Base
  enum role: [:admin, :broker, :employee, :error]

  # Role Helpers
  def admin?
    self.role == 'admin'
  end

  def admin!
    self.update(role: 'admin')
  end

  def broker?
    self.role == 'broker'
  end

  def broker!
    self.update(role: 'broker')
  end

  def employee?
    self.role == 'employee'
  end

  def employee!
    self.update(role: 'employee')
  end

  def error?
    self.role == 'error'
  end

  # Full Name
  def full_name
    self.fname + " " + self.lname
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable #, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable


end
