require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:agency_categories) }
    it { should have_many(:agencies).through(:agency_categories) }
  end
end

# class CategoryTest < ActiveSupport::TestCase
#
# def setup
#
# @category = Category.new(name: "sports")
#
# end
#
# test "category should be valid" do
#
# assert @category.valid?
#
# end
#
# test "name should be present" do
#
# @category.name = " "
#
# assert_not @category.valid?
#
# end
#
# test "name should be unique" do
#
# @category.save
#
# category2 = Category.new(name: "sports")
#
# assert_not category2.valid?
#
# end
#
# test "name should not be too long" do
#
# @category.name = "a" * 26
#
# assert_not @category.valid?
#
# end
#
# test "name should not be too short" do
#
# @category.name = "aa"
#
# assert_not @category.valid?
#
# end
