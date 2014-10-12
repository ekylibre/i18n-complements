# encoding: utf-8
require 'helper'

class TestCurrencies < Test::Unit::TestCase

  def test_conversion_rate

    assert_raise ArgumentError do
      I18nComplements::Numisma.currency_rate(:EUR, "JPY")
    end
    
    assert_raise ArgumentError do
      I18nComplements::Numisma.currency_rate("EUR", :JPY)
    end
    
    assert_raise ArgumentError do
      I18nComplements::Numisma.currency_rate(:EUR, :JPY)
    end

    r1 = I18nComplements::Numisma.currency_rate("EUR", "JPY")
    r2 = I18nComplements::Numisma.currency_rate("JPY", "EUR")
    assert 0.01 >= 1 - (r1 * r2).round(2)
    
    assert_nothing_raised do
      I18nComplements::Numisma.currency_rate("EUR", "JPY")
    end

  end


end
