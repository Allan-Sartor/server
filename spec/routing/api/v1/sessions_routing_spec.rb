require 'rails_helper'

RSpec.describe DeviseTokenAuth::SessionsController, type: :controller do
  it { is_expected.to route(:post, 'api/auth/sign_in').to(action: :create, format: :json) }
  it { is_expected.to route(:delete, 'api/auth/sign_out').to(action: :destroy, format: :json) }
end
