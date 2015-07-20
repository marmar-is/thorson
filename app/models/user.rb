class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable
  devise :ldap_authenticatable, :registerable,
          :rememberable, :trackable, :validatable


  def ldap_before_save
   self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"email").first
  end

end
