# encoding: utf-8
require 'helper'

class TestCurrencies < Test::Unit::TestCase

  def test_localization_with_currency
    assert_nothing_raised do
      ::I18n.localize(14.5, :currency => :JPY)
    end

    assert_nothing_raised do
      ::I18n.localize(14.5, :currency => "JPY")
    end
    
    assert_raise(I18n::InvalidCurrency) do
      ::I18n.localize(14.5, :currency => "jPY")
    end
  end

  def test_localization_with_currency_with_core_extensions
    assert_nothing_raised do
      14.5.localize(:currency => :JPY)
    end

    assert_nothing_raised do
      14.5.l(:currency => :JPY)
    end

    assert_nothing_raised do
      13546.localize(:currency => :JPY)
    end
    
    assert_nothing_raised do
      13546.l(:currency => :JPY)
    end
    
    assert_raise(I18n::InvalidCurrency) do
      14.5.l(:currency => "jPY")
    end    

    assert_raise(I18n::InvalidCurrency) do
      14.5.l(:currency => "JPYXX")
    end    
  end
  
  def test_number_formatting_with_currency
    number = 413500
    assert_equal "¥413,500", ::I18n.localize(number, :locale => :eng, :currency=>"JPY")
    assert_equal "413\u{00A0}500\u{00A0}¥", ::I18n.localize(number, :locale => :fra, :currency=>"JPY")
    assert_equal "413,500円", ::I18n.localize(number, :locale => :jpn, :currency=>"JPY")
  end

  def test_number_formatting_with_currency_with_core_extensions
    for locale in [:eng, :fra, :jpn]
      for money in [[413500, "JPY"], [1425.23, "USD"], [0.96, "EUR"]]
        assert_equal(money[0].l(:locale => money[1]), ::I18n.localize(money[0], :locale => money[1]))
      end
    end
  end


  def test_listing_of_currencies
    assert_nothing_raised do
      ::I18n.active_currencies
    end

    assert_nothing_raised do
      ::I18n.available_currencies
    end

    assert ::I18n.active_currencies.size <= ::I18n.available_currencies.size, "Available currencies cannot be less numerous than active currencies"
  end

  def test_currency_properties
    assert !::I18n.currencies(:JPY).nil?
    assert !::I18n.currencies("JPY").nil?
    assert ::I18n.currencies("JPy").nil?

    assert !::I18n.currencies("USD").nil?
    assert !::I18n.currencies("EUR").nil?

    assert ::I18n.currencies("JPYXX").nil?

    assert_nothing_raised do
      ::I18n.currency_label("JPY")
    end
    assert !::I18n.currency_label("JPY").match(/Unknown/)
  end
  
  def test_currency_properties_with_core_extensions
    assert_nothing_raised do
      :JPY.to_currency.name
    end
    
    assert_nothing_raised do
      "USD".to_currency.name
    end
  end
  
  
end
