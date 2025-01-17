begin
  require 'rubygems'
  require 'bundler'
  Bundler.setup
rescue LoadError => e
  puts "Error loading bundler (#{e.message}): \"gem install bundler\" for bundler support."
end
  

require 'test/unit'
require 'mocha'
require 'erb'
require 'activemerchant-anz-gateway'

ActiveMerchant::Billing::Base.mode = :test

class AnzGateway < ActiveMerchant::Billing::AnzGateway
end

module ActiveMerchant
  module Assertions
    AssertionClass = Test::Unit::AssertionFailedError
    
    def assert_field(field, value)
      clean_backtrace do 
        assert_equal value, @helper.fields[field]
      end
    end
    
    # Allows the testing of you to check for negative assertions: 
    # 
    #   # Instead of
    #   assert !something_that_is_false
    # 
    #   # Do this
    #   assert_false something_that_should_be_false
    # 
    # An optional +msg+ parameter is available to help you debug.
    def assert_false(boolean, message = nil)
      message = build_message message, '<?> is not false or nil.', boolean
    
      clean_backtrace do
        assert_block message do
          not boolean
        end
      end
    end
    
    # A handy little assertion to check for a successful response: 
    # 
    #   # Instead of
    #   assert_success response
    # 
    #   # DRY that up with
    #   assert_success response
    # 
    # A message will automatically show the inspection of the response 
    # object if things go afoul.
    def assert_success(response)
      clean_backtrace do
        assert response.success?, "Response failed: #{response.inspect}"
      end
    end
    
    # The negative of +assert_success+
    def assert_failure(response)
      clean_backtrace do
        assert_false response.success?, "Response expected to fail: #{response.inspect}"
      end
    end
    
    def assert_valid(validateable)
      clean_backtrace do
        assert validateable.valid?, "Expected to be valid"
      end
    end
    
    def assert_not_valid(validateable)
      clean_backtrace do
        assert_false validateable.valid?, "Expected to not be valid"
      end
    end

    def assert_deprecation_warning(message, target)
      target.expects(:deprecated).with(message)
      yield
    end
    
    private
    def clean_backtrace(&block)
      yield    
    rescue AssertionClass => e
      path = File.expand_path(__FILE__)
      raise AssertionClass, e.message, e.backtrace.reject { |line| File.expand_path(line) =~ /#{path}/ }
    end
  end
  
  module Fixtures
    private
    def credit_card(number = '4242424242424242', options = {})
      defaults = {
        :number => number,
        :month => 9,
        :year => Time.now.year + 1,
        :first_name => 'Longbob',
        :last_name => 'Longsen',
        :verification_value => '123',
        :type => 'visa'
      }.update(options)

      Billing::CreditCard.new(defaults)
    end
    
    def check(options = {})
      defaults = {
        :name => 'Jim Smith',
        :routing_number => '244183602', 
        :account_number => '15378535', 
        :account_holder_type => 'personal', 
        :account_type => 'checking', 
        :number => '1'
      }.update(options)
      
      Billing::Check.new(defaults)
    end
    
    def address(options = {})
      { 
        :name     => 'Jim Smith',
        :address1 => '1234 My Street',
        :address2 => 'Apt 1',
        :company  => 'Widgets Inc',
        :city     => 'Ottawa',
        :state    => 'ON',
        :zip      => 'K1C2N6',
        :country  => 'CA',
        :phone    => '(555)555-5555',
        :fax      => '(555)555-6666'
      }.update(options)
    end
    
  end
end

Test::Unit::TestCase.class_eval do
  include ActiveMerchant::Billing
  include ActiveMerchant::Assertions
  include ActiveMerchant::Utils
  include ActiveMerchant::Fixtures
end
