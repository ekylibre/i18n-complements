# encoding: utf-8
require 'helper'

class TestNumbers < Test::Unit::TestCase

  def test_localization
    assert_nothing_raised do
      I18n.localize(14.5)
    end

    assert_nothing_raised do
      I18n.localize(413500)
    end
  end

  def test_localization_with_core_extensions
    assert_nothing_raised do
      14.5.localize
    end

    assert_nothing_raised do
      413500.localize
    end   

    assert_nothing_raised do
      14.5.l
    end

    assert_nothing_raised do
      413500.l
    end   
  end
  
  def test_number_formatting
    # Integer
    number = 3
    assert_equal "3", I18n.localize(number, :locale => :eng)
    assert_equal "3", I18n.localize(number, :locale => :fra)

    # Integer > 1000
    number = 21145
    assert_equal "21,145", I18n.localize(number, :locale => :eng)
    assert_equal "21\u{00A0}145", I18n.localize(number, :locale => :fra)

    # Float without integers with decimals
    number = 0.5
    assert_equal "0.500", I18n.localize(number, :locale => :eng)
    assert_equal "0,500", I18n.localize(number, :locale => :fra)

    # Float without decimals
    number = 3.0
    assert_equal "3.000", I18n.localize(number, :locale => :eng)
    assert_equal "3,000", I18n.localize(number, :locale => :fra)

    # Float
    number = 14.53
    assert_equal "14.530", I18n.localize(number, :locale => :eng)
    assert_equal "14,530", I18n.localize(number, :locale => :fra)

    # Float > 1000
    number = 2114.5
    assert_equal "2,114.500", I18n.localize(number, :locale => :eng)
    assert_equal "2\u{00A0}114,500", I18n.localize(number, :locale => :fra)

    # Float without integers with decimals < 0.001
    number = 0.41421356
    assert_equal "0.414,213,56", I18n.localize(number, :locale => :eng)
    assert_equal "0,414\u{00A0}213\u{00A0}56", I18n.localize(number, :locale => :fra)

    # Float without integers with decimals < 0.001
    number = 3.1415926
    assert_equal "3.141,592,6", I18n.localize(number, :locale => :eng)
    assert_equal "3,141\u{00A0}592\u{00A0}6", I18n.localize(number, :locale => :fra)

    # Float without integers with decimals < 0.001
    number = 62951413.1415926
    assert_equal "62,951,413.141,592,6", I18n.localize(number, :locale => :eng)
    assert_equal "62\u{00A0}951\u{00A0}413,141\u{00A0}592\u{00A0}6", I18n.localize(number, :locale => :fra)
  end

  def test_number_formatting_with_core_extensions
    for locale in [:eng, :fra, :jpn]
      for number in [3, 21145, 0.5, 3.0, 14.53, 2144.5, 0.41421356, 3.1415926, 62951413.1415926]
        assert_equal(number.l(:locale => locale), I18n.localize(number, :locale => locale))
      end
    end

  end

end
