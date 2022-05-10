class Link < ApplicationRecord
  validates :url, presence: true
  VALID_SHORTCODE_REGEX = /\A[^\W][0-9a-zA-Z-_]{4,}+\z/i
  validates :shortcode, presence: true, length: {minimum: 4}, format: {with: VALID_SHORTCODE_REGEX}, uniqueness: { case_sensitive: false}

  def self.generate_shortcode
    SecureRandom.alphanumeric(6)
  end
  
end
