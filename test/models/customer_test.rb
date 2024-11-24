# test/models/customer_test.rb
require "test_helper"

class CustomerTest < ActiveSupport::TestCase

  test "should raise error when saving customer without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Customer.create!(last_name: "Nikola", school_email: "jokic@msudenver.edu")
    end
  end


  test "should not allow duplicate school_email" do
    # This retrieves the customer with the key 'one' from customers.yml
    customer = customers(:one)

    assert_raises ActiveRecord::RecordInvalid do
      Customer.create!(first_name: "Run", last_name: "Time", school_email: "rtime@msudenver.edu")
    end

  end


  test "should save customer with valid attributes" do
    customer = Customer.create!(first_name: "Ruby", last_name: "Rails", school_email: "rrails@msudenver.edu")
    assert customer.persisted?, "Customer was not persisted"
  end



end

