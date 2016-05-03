require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'minitest/autorun'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'i18n-complements'

Dir[File.join(File.dirname(__FILE__), 'locales', '*.yml')].each do |file|
  I18n.backend.load_translations(file)
end

module I18n
  module Complements
    class TestCase < Minitest::Test
      def setup
        I18n.locale = ENV['LOCALE'] || :eng
      end

      def assert_nothing_raised(*_args)
        yield
      end

      def assert_raise(exception)
        yield
      rescue Exception => e
        assert_equal exception, e.class
      else
        refute
      end
    end
  end
end
