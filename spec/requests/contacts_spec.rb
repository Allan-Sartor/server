require 'rails_helper'

RSpec.describe "/contacts", type: :request do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
  
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Contact.create! valid_attributes
      get contacts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      contact = Contact.create! valid_attributes
      get contact_url(contact), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Contact" do
        expect {
          post contacts_url,
               params: { contact: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Contact, :count).by(1)
      end

      it "renders a JSON response with the new contact" do
        post contacts_url,
             params: { contact: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Contact" do
        expect {
          post contacts_url,
               params: { contact: invalid_attributes }, as: :json
        }.to change(Contact, :count).by(0)
      end

      it "renders a JSON response with errors for the new contact" do
        post contacts_url,
             params: { contact: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        patch contact_url(contact),
              params: { contact: new_attributes }, headers: valid_headers, as: :json
        contact.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the contact" do
        contact = Contact.create! valid_attributes
        patch contact_url(contact),
              params: { contact: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the contact" do
        contact = Contact.create! valid_attributes
        patch contact_url(contact),
              params: { contact: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete contact_url(contact), headers: valid_headers, as: :json
      }.to change(Contact, :count).by(-1)
    end
  end
end
