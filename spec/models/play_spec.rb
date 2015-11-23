require 'rails_helper'

RSpec.describe Play, type: :model do
  describe ".count" do
    it "responds" do
      expect(described_class).to respond_to(:count).with(0).arguments
    end
  end

  describe ".find" do
    it "responds" do
      expect(described_class).to respond_to(:find).with(1).argument
    end
  end

  describe ".new" do
    it "responds" do
      expect(described_class).to respond_to(:create).with(0).arguments
    end
  end

  it { is_expected.to respond_to(:id).with(0).arguments }
  it { is_expected.to belong_to(:game) }
  it { is_expected.to have_many(:turns) }
end
