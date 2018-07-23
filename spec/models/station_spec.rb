require 'rails_helper'

describe Station do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:installation_date)}
  end
  describe 'relationships' do
    it {should respond_to(:trips_from)}
    it {should respond_to(:trips_to)}
  end
end
