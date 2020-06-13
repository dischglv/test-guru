require 'digest/sha1'

class User < ApplicationRecord

  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test",
            dependent: :nullify, foreign_key: "author_id"

  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
  
  def tests_by_level(level)
    tests.where(level: level)
  end

  def admin?
    is_a? Admin
  end

  def nickname
    if first_name.present?
      if last_name.present?
        nickname = "#{last_name} #{first_name}"
      else
        nickname = first_name
      end
    else
      nickname = email
    end
  end

end
