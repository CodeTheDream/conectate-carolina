require 'rails_helper'

RSpec.describe Category, type: :model do
  
  scenario "validates category model attributes" do
    expect(category).to be_valid
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
