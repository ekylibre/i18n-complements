# encoding: utf-8
require 'helper'

class TestCurrencies < I18n::Complements::TestCase
  def test_conversion_rate
    rate = I18n::Complements::Numisma.currency_rate('EUR', 'FRF')
    assert !rate.zero?, 'Rate should not be zero'

    assert rate == 6.55957

    assert_raise I18n::InvalidCurrency do
      I18n::Complements::Numisma.currency_rate(:EUR, 'JPY')
    end

    assert_raise I18n::InvalidCurrency do
      I18n::Complements::Numisma.currency_rate('EUR', :JPY)
    end

    assert_raise I18n::InvalidCurrency do
      I18n::Complements::Numisma.currency_rate(:EUR, :JPY)
    end

    r1 = I18n::Complements::Numisma.currency_rate('EUR', 'JPY')
    r2 = I18n::Complements::Numisma.currency_rate('JPY', 'EUR')
    rounded_one = (r1 * r2).round(2)
    assert rounded_one >= 0.99, "EUR -> JPY: #{r1}, JPY -> EUR: #{r2}, #{r1 * r2}, #{rounded_one}"

    rate = I18n::Complements::Numisma.currency_rate('EUR', 'JPY')
    assert !rate.nil?, 'Rate cannot be nil'
    assert rate != 0, 'Rate cannot be null'
  end
end
