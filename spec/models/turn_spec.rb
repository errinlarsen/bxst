require 'rails_helper'

RSpec.describe Turn, type: :model do
  it { is_expected.to belong_to(:play) }
end
