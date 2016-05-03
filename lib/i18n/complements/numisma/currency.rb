module I18n
  module Complements
    module Numisma
      class Currency
        attr_reader :code, :active, :cash, :countries, :number, :precision, :unit

        def initialize(code, options = {})
          @code = code.strip # .upcase
          @active = (options[:active] ? true : false)
          @cash = options[:cash].to_a.collect(&:to_f).sort
          @countries = options[:countries].to_a.collect(&:to_s).sort.collect(&:to_sym)
          @number = options[:number].to_i
          @precision = options[:precision].to_i
          @unit = (options[:unit].nil? ? nil : options[:unit].to_s)
        end

        def name
          ::I18n.translate("currencies.#{code}")
        end

        def label
          ::I18n.translate('labels.currency_with_code', code: code, name: name, default: '%{name} (%{code})')
        end

        def round(value, _options = {})
          precision = self.precision
          if RUBY_VERSION =~ /^1\.8/
            magnitude = 10**precision
            return (value * magnitude).to_i.to_f * magnitude
          else
            return value.round(precision)
          end
        end

        def ==(other_currency)
          code == other_currency.code
        end

        def to_currency
          self
        end

        # Produces a amount of the currency with the locale parameters
        # TODO: Find a better way to specify number formats which are more complex that the default Rails use
        def localize(amount, options = {})
          return unless amount

          # options.symbolize_keys!

          defaults  = I18n.translate('number.format'.to_sym, locale: options[:locale], default: {})
          defaultt  = I18n.translate('number.currency.format'.to_sym, locale: options[:locale], default: {})
          defaultt[:negative_format] ||= ('-' + defaultt[:format]) if defaultt[:format]
          formatcy = I18n.translate("number.currency.formats.#{code}".to_sym, locale: options[:locale], default: {})
          formatcy[:negative_format] ||= '-' + formatcy[:format] if formatcy[:format]

          formatter = {}
          formatter[:separator] = formatcy[:separator] || defaultt[:separator] || defaults[:separator] || ','
          formatter[:delimiter] = formatcy[:delimiter] || defaultt[:delimiter] || defaults[:delimiter] || ''
          formatter[:precision] = formatcy[:precision] || precision || defaultt[:precision] || 3
          format           = formatcy[:format] || defaultt[:format] || '%n-%u' # defaults[:format] ||
          negative_format  = formatcy[:negative_format] || defaultt[:negative_format] || defaults[:negative_format] || '-' + format
          unit             = formatcy[:unit] || self.unit || code

          if amount.to_f < 0
            format = negative_format # options.delete(:negative_format)
            amount = amount.respond_to?('abs') ? amount.abs : amount.sub(/^-/, '')
          end

          value = amount.to_s
          integers, decimals = value.split(/\./)
          value = integers.gsub(/^0+[1-9]+/, '').gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{formatter[:delimiter]}")
          unless decimals.to_s =~ /^\s*$/
            value << formatter[:separator]
            value << decimals.gsub(/0+$/, '').ljust(formatter[:precision], '0').scan(/.{1,3}/).join(formatter[:delimiter])
          end
          format.gsub(/%n/, value).gsub(/%u/, unit).gsub(/%s/, "\u{00A0}")
        end
      end
    end
  end
end
