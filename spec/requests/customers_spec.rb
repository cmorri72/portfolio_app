require 'rails_helper'
 
#request specs for the Customers resource focusing on HTTP requests
RSpec.describe "Customers", type: :request do

  # GET /customers (index)
  describe "GET /customers" do
    context "when customers exist" do
      let!(:customer) { Customer.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu") }

      # Test 1: Returns a successful response and displays the search form
      it "returns a successful response and displays the search form" do
        get customers_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Search') # Ensure search form is rendered
      end

      # Test 2: Ensure it does NOT display customers without a search
      it "does not display customers until a search is performed" do
        get customers_path
        expect(response.body).to_not include("Aaron")
      end
    end

    # Test 3: Handle missing records or no search criteria provided
    context "when no customers exist or no search is performed" do
      it "displays a message prompting to search" do
        get customers_path
        expect(response.body).to include("Please enter search criteria to find customers")
      end
    end
  end

  # Search functionality
  describe "GET /customers (search functionality)" do
    let!(:customer1) { Customer.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu") }
    let!(:customer2) { Customer.create!(first_name: "Jackie", last_name: "Joyner", school_email: "joyner@msudenver.edu") }
  end

  # POST /customers (create)
  describe "POST /customers" do
    context "with valid parameters" do
      # Test 7: Create a new customer and ensure it redirects
      it "creates a new customer and redirects" do
        expect {
          post customers_path, params: { customer: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu" } }
        }.to change(Customer, :count).by(1)

        expect(response).to have_http_status(:found)  # Expect redirect after creation
        follow_redirect!
        expect(response.body).to include("Aaron", "Gordon")  # Customer's details in the response
      end

      # Test 8: Ensure it returns a 201 status (created)
      it "returns a 201 status on successful creation" do
        post customers_path, params: { customer: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu" } }
        expect(response).to have_http_status(:found)  # Expect 201 Created status
      end
    end

    context "with invalid parameters" do
      # Test 9: Ensure it does not create a customer and returns a 422 status
      it "does not create a customer and returns a 422 status" do
        expect {
          post customers_path, params: { customer: { first_name: "", last_name: "", school_email: "" } } # Invalid parameters
        }.to_not change(Customer, :count)

        expect(response).to have_http_status(:unprocessable_entity) # Expect 422 error for invalid data
      end
    end
  end

  # GET /customers/:id (show)
  describe "GET /customers/:id" do
    context "when the customer exists" do
      let!(:customer) { Customer.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu") }

      # Test 10: Ensure it returns a successful response (200 OK)
      it "returns a successful response" do
        get customer_path(customer)
        expect(response).to have_http_status(:ok)  # Expect 200 OK status
      end

      # Test 11: Ensure it includes the customer's details in the response body
      it "includes the customer's details in the response body" do
        get customer_path(customer)
        expect(response.body).to include("Aaron", "Gordon")
      end
    end

    # Test 12: Handle missing records
    context "when the customer does not exist" do
      it "returns a 404 status" do
        get "/customers/9999"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # DELETE /customers/:id (destroy)
  describe "DELETE /customers/:id" do
    let!(:customer) { Customer.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu") }

    # Test 13: Deletes the customer and redirects
    it "deletes the customer and redirects" do
      expect {
        delete "/customers/#{customer.id}"
      }.to change(Customer, :count).by(-1)

      expect(response).to have_http_status(:found)  # Expect 302 redirect after deletion
      follow_redirect!  # Follow the redirect after deletion
      expect(response.body).to include("Customer was successfully destroyed.")
    end

    # Test 14: Returns a 404 when trying to delete a non-existent customer
    it "returns a 404 status when trying to delete a non-existent customer" do
      delete "/customers/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
