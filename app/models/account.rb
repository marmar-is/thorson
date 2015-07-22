class Account < ActiveRecord::Base
  enum role: [:admin, :broker, :employee, :error]
  after_initialize :set_role, if: :new_record?

  attr_accessor :string_role


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable #, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

  private
    def set_role
      puts string_role
      if string_role == "admin"
        self.role ||= :admin
      else
        self.role ||= :error
      end
    end
end
