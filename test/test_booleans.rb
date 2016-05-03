# encoding: utf-8
require 'helper'

class TestBooleans < I18n::Complements::TestCase
  def test_localization
    assert_nothing_raised do
      I18n.localize(true)
    end

    assert_nothing_raised do
      I18n.localize(false)
    end
  end

  def test_localization_with_core_extensions
    assert_nothing_raised do
      true.localize
    end

    assert_nothing_raised do
      false.localize
    end

    assert_nothing_raised do
      true.l
    end

    assert_nothing_raised do
      false.l
    end
  end
end
