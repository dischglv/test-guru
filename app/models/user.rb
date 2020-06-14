require 'digest/sha1'

class User < ApplicationRecord

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test",
  dependent: :nullify, foreign_key: "author_id"
  
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable

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
    return email unless first_name.present?
    return first_name unless last_name.present?

    "#{last_name} #{first_name}"    
  end

end
