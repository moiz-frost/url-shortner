require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  context 'CRUD' do
    before do
      @user = create(:user)
      @api_key = create(:api_key, user: @user)
    end

    it 'should have a key already at creation time' do
      expect(@api_key.key).to be_present
    end

    it 'key should be frozen if an attempt to update it is made' do
      @api_key.update(key: 'xyz')
      expect(@api_key.reload.key).to_not eq 'xyz'
    end

    it 'key should be deactivated/activated if deactivate/activate is called' do
      @api_key.deactivate
      expect(@api_key.reload.is_active).to eq false
      @api_key.activate
      expect(@api_key.reload.is_active).to eq true
    end

    it 'api key should be soft deleted if destroy is called' do
      Timecop.freeze
      @api_key.destroy
      expect(ApiKey.where(id: @api_key.id).first).to eq nil
      expect(@api_key.is_deleted).to be_truthy
      expect(@api_key.deleted_at).to eq Time.current
      Timecop.return
    end
  end
end
