require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'Database Table' do
    it { is_expected.to have_db_column :name}
    it { is_expected.to have_db_column :name}
  end
end
