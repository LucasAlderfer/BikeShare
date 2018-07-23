require 'rails_helper'

describe Order do
  it {should validate_presence_of(:status)}
  it {should validate_presence_of(:user_id)}
end
