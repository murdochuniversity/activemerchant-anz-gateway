require File.expand_path('../../test_helper',File.dirname(__FILE__))

class AnzTest < Test::Unit::TestCase
  def setup
    @gateway = AnzGateway.new({:merchant_id => "TESTANZTEST3", :access_code => "6447E199"})

    @credit_card_success = credit_card('5123456789012346',
                                          :month => 5,
                                          :year => 2013
                           )

    @credit_card_fail = credit_card('1234567812345678',
      :month => Time.now.month,
      :year  => Time.now.year
    )

    @params = {
      :order_id => 'X123F',
      :invoice  => '10001'
    }
  end

  def test_invalid_amount
    assert response = @gateway.purchase(0, @credit_card_success, @params)
    assert_failure response
    assert response.test?
  end

  def test_purchase_success_with_verification_value
    assert response = @gateway.purchase(100, @credit_card_success, @params)
    assert_success response
    assert response.test?
  end

  def test_invalid_expiration_date
    @credit_card_success.year = 2005
    assert response = @gateway.purchase(100, @credit_card_success, @params)
    assert_failure response
    assert response.test?
  end

  def test_purchase_error
    assert response = @gateway.purchase(100, @credit_card_fail, @params)
    assert_equal false, response.success?
    assert response.test?
  end
end
