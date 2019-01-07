class User < ApplicationRecord
    attr_accessor :remember_token

    before_create :create_remember_digest 

    validates :name, presence: true
    validates :email, presence: true,
                      uniqueness: { case_sensitive: false }
    
    has_secure_password
    validates :password, presence: true,
                         length: { minimum: 6 }

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    

    def create_remember_digest
        self.remember_token = User.new_token
    end
end
