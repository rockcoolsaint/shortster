class Link < ApplicationRecord

  def self.generate_shortcode
    SecureRandom.alphanumeric(6)
  end
  
end
