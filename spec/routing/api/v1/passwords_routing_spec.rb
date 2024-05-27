require 'rails_helper'

RSpec.describe DeviseTokenAuth::PasswordsController, type: :controller do
  it { is_expected.to route(:post, 'api/auth/password').to(action: :create, format: :json) }
  it { is_expected.to route(:put, 'api/auth/password').to(action: :update, format: :json) }
end
