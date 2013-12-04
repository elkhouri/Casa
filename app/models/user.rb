class User < ActiveRecord::Base
  has_many :relationships, foreign_key: "parent_id", dependent: :destroy
  has_many :children, through: :relationships
  has_many :reverse_relationships, foreign_key: "child_id", 
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :parents, through: :reverse_relationships

  before_create :create_remember_token
  validates :name, presence:true
  validates :ID_num, presence:true, uniqueness:true
  has_secure_password
  validates :password, length: { minimum: 6 }
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def parents?(other_user)
    relationships.find_by(child_id: other_user.id)
  end

  def parents!(other_user)
    relationships.create!(child_id: other_user.id)
  end
  
  def unparent!(other_user)
    relationships.find_by(child_id: other_user.id).destroy!
  end
  private
  
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
  
  def self.inherited(child)
  child.instance_eval do
    def model_name
      User.model_name
    end
  end
  super
  end
end
