# encoding: utf-8
require 'helper'

class TestExtensions < Test::Unit::TestCase
  
  def setup
    I18n.locale = :eng
  end

  def test_string_translation
    assert_equal "My example is short", I18n.translate("my_example")
    assert_equal I18n.translate("my_example"), "my_example".translate
    assert_equal I18n.translate("my_example"), "my_example".t

    assert_equal "My example is short", I18n.translate("my.example")
    assert_equal I18n.translate("my.example"), "my.example".translate
    assert_equal I18n.translate("my.example"), "my.example".t
  end

  def test_symbol_translation
    assert_equal "My example is short", I18n.translate(:my_example)
    assert_equal I18n.translate(:my_example), :my_example.translate
    assert_equal I18n.translate(:my_example), :my_example.t
  end


  def test_date_localization
    date = Date.civil(1999, 12, 31)

    assert_nothing_raised do
      date.localize
    end

    assert_nothing_raised do
      date.l
    end

    assert_equal I18n.localize(date), date.l
  end

  def test_datetime_localization
    datetime = DateTime.civil(1999, 12, 31, 23, 59, 59)

    assert_nothing_raised do
      datetime.localize
    end

    assert_nothing_raised do
      datetime.l
    end

    assert_equal I18n.localize(datetime), datetime.l
  end

  def test_time_localization
    time = DateTime.civil(1999, 12, 31, 23, 59, 59).to_time

    assert_nothing_raised do
      time.localize
    end

    assert_nothing_raised do
      time.l
    end

    assert_equal I18n.localize(time), time.l
  end

end
