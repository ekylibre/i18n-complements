require 'i18n'

module I18n
  class InvalidCurrency < ArgumentError
  end

  module Complements
  end
end

require 'i18n/complements/numisma'
require 'i18n/complements/localize_extension'
require 'i18n/complements/core_extension'
require 'i18n/complements/version'
