# encoding: utf-8
require 'helper'

class TestStrings < Test::Unit::TestCase

  def test_localization
    assert_nothing_raised do
      I18n.localize("This is a test sentence")
    end

    assert_nothing_raised do
      I18n.localize("C'est une phrase d'exemple axée sur les caractères spéciaux")
    end

    assert_nothing_raised do
      I18n.localize("")
    end
  end

  def test_localization_with_core_extensions
    assert_nothing_raised do
     "This is a test sentence".localize
    end

    assert_nothing_raised do
      "C'est une phrase d'exemple axée sur les caractères spéciaux".localize
    end   

    assert_nothing_raised do
     "This is a test sentence".l
    end

    assert_nothing_raised do
      "C'est une phrase d'exemple axée sur les caractères spéciaux".l
    end   
  end

end
