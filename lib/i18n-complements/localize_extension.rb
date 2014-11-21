module I18n
  module Backend

    class Simple

      def localize_with_complements(locale, object, format = nil, options = {})
        
        if object.respond_to?(:strftime)
          format ||= :default
          return localize_without_complements(locale, object, format, options)
        elsif object.respond_to?(:abs)
          if currency = options[:currency]
            raise I18n::InvalidCurrency.new("Currency #{currency.to_s} does not exist.") unless I18nComplements::Numisma[currency.to_s]
            return I18nComplements::Numisma[currency.to_s].localize(object, :locale => locale)
          else
            formatter = I18n.translate('number.format'.to_sym, :locale => locale, :default => {})
            if formatter.is_a?(Proc)
              return formatter[object]
            elsif formatter.is_a?(Hash)
              formatter = {:format => "%n", :separator => '.', :delimiter => '', :precision => 3}.merge(formatter).merge(options)
              format = formatter[:format]
              negative_format = formatter[:negative_format] || "-" + format

              if object.to_f < 0
                format = negative_format
                object = object.abs
              end
              
              value = object.to_s.split(/\./)
              integrals, decimals = value[0].to_s, value[1].to_s
              value = integrals.gsub(/^0+[1-9]+/, '').gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{formatter[:delimiter]}")
              decimals = "0" if decimals.to_s.match(/^\s*$/) and object.is_a?(Float)
              unless decimals.to_s.match(/^\s*$/)
                value << formatter[:separator]
                value << decimals.gsub(/0+$/, '').ljust(formatter[:precision], '0').scan(/.{1,3}/).join(formatter[:delimiter])
              end
              return format.gsub(/%n/, value).gsub(/%s/, "\u{00A0}")
            end
          end
        elsif object.is_a?(TrueClass) or object.is_a?(FalseClass)
          return I18n.translate("boolean.human.#{object.to_s}_class", locale: locale)
        elsif object.is_a?(String)
          return object          
        else
          raise ArgumentError, "Object must be a Numeric, TrueClass, FalseClass, String, Date, DateTime or Time object. #{object.class.name}:#{object.inspect} given."
        end
      end

      alias_method(:localize_without_complements, :localize)
      alias_method(:localize, :localize_with_complements)

    end
  end
end
