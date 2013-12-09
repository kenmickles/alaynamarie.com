require 'spec_helper'

describe Setting do
  it "has a valid factory" do
    build(:setting).should be_valid
  end

  it "is invalid without a name" do
    build(:setting, name: nil).should_not be_valid
  end

  it "is invalid if name already exists" do
    setting = create(:setting)
    build(:setting, name: setting.name).should_not be_valid
  end
end