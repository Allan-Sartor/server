require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { User.first }
  let(:contact) { build(:contact, user: user) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:address) }

    it 'validates uniqueness of cpf scoped to user_id' do
      existing_contact = user.contacts.first

      duplicate_contact = build(:contact, cpf: existing_contact.cpf, user: user)

      expect(duplicate_contact).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'geocodes address before validation if address is present and changed' do
      contact.address = 'New Address'
      allow(contact).to receive(:geocode_address)
      contact.valid?
      expect(contact).to have_received(:geocode_address)
    end
  end

  describe 'class methods' do
    describe '.filter_by_cpf_or_name' do
      it 'returns contacts that match the query in cpf or name' do
        query_name_first = user.contacts.first.name
        query_name_two = user.contacts.last.name

        result = user.contacts.filter_by_cpf_or_name(query_name_first)

        expect(result).to include(user.contacts.first)
        expect(result).not_to include(user.contacts.last)

        result = user.contacts.filter_by_cpf_or_name(user.contacts.last.cpf.to_s[0, 3])

        expect(result).to include(user.contacts.last)
        expect(result).not_to include(user.contacts.first)
      end
    end

    describe '.sort_by' do
      it 'returns the correct sort options' do
        expect(Contact.send(:sort_by)).to eq(['cpf', 'name'])
      end
    end
  end

  describe 'instance methods' do
    describe '#geocode_address' do
      it 'sets latitude and longitude based on the address' do
        allow(GoogleMapsService).to receive(:fetch_geolocation).with(contact.address).and_return({
                                                                                                   latitude: -25.3537545,
                                                                                                   longitude: -49.1524325
                                                                                                 })

        contact.send(:geocode_address)

        expect(contact.latitude).to eq(-25.3537545)
        expect(contact.longitude).to eq(-49.1524325)
      end

      it 'adds an error if geocoding fails' do
        allow(GoogleMapsService).to receive(:fetch_geolocation).with(contact.address).and_return({
                                                                                                   error: 'Invalid address'
                                                                                                 })

        contact.send(:geocode_address)

        expect(contact.errors[:address]).to include('Invalid address')
      end
    end
  end
end
