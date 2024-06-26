require 'rails_helper'

RSpec.describe DeviseTokenAuth::ConfirmationsController, type: :controller do
  it { is_expected.to route(:post, 'api/auth/confirmation').to(action: :create, format: :json) }
end
