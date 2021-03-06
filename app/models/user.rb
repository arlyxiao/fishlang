class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :points
  # attr_accessible :title, :body

  validates :name, :format => {:with => /\A\w+\z/, :message => 'Incorrect format'},
                    :length => {:in => 4..20},
                    :presence => true,
                    :uniqueness => {:case_sensitive => false}

  validates :email, :uniqueness => {:case_sensitive => false}


  include UserExercise::UserMethods
  include SentenceReport::UserMethods
  include SentenceFailure::UserMethods
end
