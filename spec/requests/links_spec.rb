require 'rails_helper'

RSpec.describe "Links", type: :request do
  # describe "GET /:shortcode" do
  #   it "works! (now write some real specs)" do
  #     get '/didjfnd'
  #     expect(response).to have_http_status(200)
  #   end
  # end

  let(:link) { create(:link) }

  describe "GET /:shortcode" do
    # let(:link) { create(:link) }

    context "When shortcode exists and is valid" do
    
      before { get "/#{link.shortcode}" }

      it "It redirects" do
        expect(response).to have_http_status(302)
        expect(link.access_count).to eq(1)
      end
    end

    context "When shortcode is invalid" do
      let(:link) { "dgdytvv" }
    
      before { get "/#{link}" }

      it "It renders invalid link text" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # Test suite for shortcode /submit
  describe "POST /submit" do
    # valid payload
    let(:valid_attributes) { { url: 'https://github.com/rockcoolsaint', shortcode: 'test-link' } }
    context 'when the request is valid' do
      context "when custom link parameter is passed" do
        before { post '/submit', params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'creates a link' do
          expect(json['data']['url']).to match(/https:\/\/github.com\/rockcoolsaint/)
          expect(json['data']['shortcode']).to match(/test-link/)
          expect(json['data']['shortcode'].length).to be >= 4
        end
      end
      
      context "when no custom link is passed" do
        before { post '/submit', params: { url: 'https://vanhack.com' } }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'creates a link' do
          expect(json['data']['url']).to match(/https:\/\/vanhack.com/)
          expect(json['data']['shortcode'].length).to eq 6
        end
      end
    end
  end

  # Test suite for shortcode /:shortcode/stats
  describe "GET /:shortcode/stats" do
    context "When shortcode exists and is valid" do
    
      before do
        get "/#{link.shortcode}/stats"
      end

      it "It should respond with success status" do
        expect(response).to have_http_status(200)
      end

      it "It should return a json object" do
        expect(json['data']).not_to be_nil
        expect(json['data']['url']).to match(/https:\/\/github.com\/rockcoolsaint/)
        expect(json['data']['shortcode']).to match(/test-link/)
      end
    end
  end
end
