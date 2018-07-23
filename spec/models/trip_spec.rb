require 'rails_helper'

describe Trip do
  context 'validations' do
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:start_station)}
    it {should validate_presence_of(:end_date)}
    it {should validate_presence_of(:end_station)}
    it {should validate_presence_of(:bike_id)}
    it {should validate_presence_of(:subscription_type)}
    it {should validate_presence_of(:zip_code)}
  end
  describe 'relationships' do
    it {should respond_to(:start_station)}
    it {should respond_to(:end_station)}
  end
end
