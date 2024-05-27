require 'rails_helper'

RSpec.describe DeviseTokenAuth::RegistrationsController, type: :controller do
  it { is_expected.to route(:post, 'api/auth').to(action: :create, format: :json) }
  it { is_expected.to route(:put, 'api/auth').to(action: :update, format: :json) }
  it { is_expected.to route(:delete, 'api/auth').to(action: :destroy, format: :json) }
end
