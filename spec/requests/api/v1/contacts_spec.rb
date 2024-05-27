require 'rails_helper'

RSpec.describe '/contacts', type: :request do
  let!(:user) { User.first }
  let(:outher_user) { User.last }
  let(:contact) { user.contacts.first }
  let(:contact_two) { outher_user.contacts.first }
  let(:valid_attributes) do
    {
      name: 'Bento 2',
      cpf: '08621941058',
      phone: '(41) 95555-3333',
      address: 'R. Ataláia, 1429 - Paloma, Colombo - PR, 83410-100'
    }
  end
  let(:invalid_attributes) { attributes_for :invalid_contact, user: user }

  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_contacts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders two contacts from distinct users' do
      get api_contacts_url, headers: valid_headers, as: :json
      expect(json_response[:contacts].size).to eq 3
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_contacts_url(contact), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        get api_contacts_url(contact), headers: {}, as: :json
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Contact' do
        expect do
          post api_contacts_url,
               params: { contact: valid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Contact, :count).by(1)
      end

      it 'renders a JSON response with the new contact' do
        post api_contacts_url,
             params: { contact: valid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Contact' do
        expect do
          post api_contacts_url,
               params: { contact: invalid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Contact, :count).by(0)
      end

      it 'renders a JSON response with errors for the new Contact' do
        post api_contacts_url,
             params: { contact: invalid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_contacts_url,
             params: { contact: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Joaquim Pereira',
          cpf: '400.956.060-68',
          phone: '(41) 95555-3344',
          address: 'Rua dias da silva, 333 - Jardim Neuza - Colombo - PR' }
      end

      it 'updates the requested contact' do
        patch "/api/contacts/#{contact.id}",
              params: { contact: new_attributes },
              headers: valid_headers,
              as: :json
        contact.reload
        expect(contact.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the contact' do
        patch "/api/contacts/#{contact.id}",
              params: { contact: new_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the contact' do
        patch "/api/contacts/#{contact.id}",
              params: { contact: invalid_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        patch "/api/contacts/#{contact_two.id}", headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch "/api/contacts/#{contact.id}",
              params: { contact: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested contact' do
      expect do
        delete "/api/contacts/#{contact.id}", headers: valid_headers, as: :json
      end.to change(Contact, :count).by(-1)
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        delete "/api/contacts/#{contact_two.id}", headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete "/api/contacts/#{contact.id}", headers: {}, as: :json
      end
    end
  end
end
