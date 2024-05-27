require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :routing do
  describe 'routing' do
    it { is_expected.to route(:get, 'api/contacts').to(action: :index, format: :json) }
    it { is_expected.to route(:get, 'api/contacts/1').to(action: :show, id: '1', format: :json) }
    it { is_expected.to route(:post, 'api/contacts').to(action: :create, format: :json) }
    it { is_expected.to route(:put, 'api/contacts/1').to(action: :update, id: '1', format: :json) }
    it { is_expected.to route(:patch, 'api/contacts/1').to(action: :update, id: '1', format: :json) }
    it { is_expected.to route(:delete, 'api/contacts/1').to(action: :destroy, id: '1', format: :json) }
  end
end
