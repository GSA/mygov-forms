class User < ActiveRecord::Base
  rolify

  validates_presence_of :name

  after_create :add_roles
  attr_accessible :email, :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.email = auth['info']['email'] || ""
         user.name = auth['info']['name'] || user.email
      end
    end
  end

  def add_roles
    self.add_role :admin if User.count == 1 # make the first user an admin

    self.add_role :agency if %w{ .gov .mil }.any? {|d| self.email.end_with?(d)}
  end
end
