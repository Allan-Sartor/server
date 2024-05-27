require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { create(:user) }
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
      duplicate_contact = create(:contact, cpf: contact.cpf, user: user)

      puts duplicate_contact.errors.messages
      expect(duplicate_contact.errors[:cpf])
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
        contact1 = build(:contact, cpf: '123.456.789-00', name: 'John Doe', user: user)
        contact2 = build(:contact, cpf: '987.654.321-00', name: 'Jane Smith', user: user)

        result = Contact.filter_by_cpf_or_name('John')
        expect(result).to include(contact1)
        expect(result).not_to include(contact2)

        result = Contact.filter_by_cpf_or_name('987.654')
        expect(result).to include(contact2)
        expect(result).not_to include(contact1)
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
