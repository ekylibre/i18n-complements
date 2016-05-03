# This module aimed to structure and controls currencies through the application
# It represents the international monetary system with all its currencies like specified in ISO 4217
# Numisma comes from latin: It designs here the "science of money"
require 'net/http'
require 'yaml'
require 'i18n/complements/numisma/currency'

module I18n
  module Complements
    module Numisma
      class << self
        def currencies
          @@currencies
        end

        # Returns the path to currencies file
        def currencies_file
          # Rails.root.join("config", "currencies.yml")
          File.join(File.dirname(__FILE__), 'numisma', 'currencies.yml')
        end

        # Returns a hash with active currencies only
        def active_currencies
          x = {}
          for code, currency in @@currencies
            x[code] = currency if currency.active
          end
          x
        end

        # Shorcut to get currency
        def [](currency_code)
          @@currencies[currency_code]
        end

        def currency_rate(from, to)
          raise InvalidCurrency.new(":from currency is unknown (#{from.class}:#{from.inspect})") if Numisma[from].nil?
          raise InvalidCurrency.new(":to currency is unknown (#{to.class}:#{to.inspect})") if Numisma[to].nil?
          rate = nil
          begin
            uri = URI('http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate')
            response = Net::HTTP.post_form(uri, 'FromCurrency' => from, 'ToCurrency' => to)
            doc = ::LibXML::XML::Parser.string(response.body).parse
            rate = doc.root.content.to_f
          rescue
            uri = URI("http://download.finance.yahoo.com/d/quotes.csv?s=#{from}#{to}=X&f=l1")
            response = Net::HTTP.get(uri)
            rate = response.strip.to_f
          end
          rate
        end

        # Load currencies
        def load_currencies
          @@currencies = {}
          for code, details in YAML.load_file(currencies_file)
            currency = Currency.new(code, details.inject({}) { |h, p| h[p[0].to_sym] = p[1]; h })
            @@currencies[currency.code] = currency
          end
        end
      end

      # Finally load all currencies
      load_currencies
    end
  end

  class << self
    def currencies(currency_code)
      I18n::Complements::Numisma.currencies[currency_code.to_s]
    end

    def active_currencies
      I18n::Complements::Numisma.active_currencies
    end

    def available_currencies
      I18n::Complements::Numisma.currencies
    end

    def currency_label(currency_code)
      if currency = I18n::Complements::Numisma.currencies[currency_code.to_s]
        currency.label
      else
        return "Unknown currency: #{currency_code}"
      end
    end

    def currency_rate(from, to)
      I18n::Complements::Numisma.currency_rate(from, to)
    end

    def currencies_file
      I18n::Complements::Numisma.currencies_file
    end
  end
end
