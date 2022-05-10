require 'rails_helper'

RSpec.describe Link, type: :model do
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:shortcode) }

  describe '#self.generate_shortcode' do
    subject(:shortcode) { Link.generate_shortcode } 
    
    it { expect(shortcode.length).to eq 6 }
  end
end
