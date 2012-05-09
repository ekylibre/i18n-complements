module I18n
  module Backend
    module Base

      def localize_with_numbers(locale, object, format = :default, options = {})
        # options.symbolize_keys!
        if object.respond_to?(:abs)
          if currency = options[:currency]
            raise I18nComplements::InvalidCurrency.new("Currency #{currency.to_s} does not exist.") unless I18nComplements::Numisma[currency.to_s]
            return I18nComplements::Numisma[currency.to_s].localize(object, :locale=>locale)
          else
            formatter = I18n.translate('number.format'.to_sym, :locale => locale, :default => {})
            if formatter.is_a?(Proc)
              return formatter[object]
            elsif formatter.is_a?(Hash)
              formatter = {:format => "%n", :separator=>'.', :delimiter=>'', :precision=>3}.merge(formatter).merge(options)
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
                # decimals = decimals.gsub(/0+$/, '').ljust(formatter[:precision], '0').reverse.split(/(?=\d{3})/).reverse.collect{|x| x.reverse}.join(formatter[:delimiter])
                value << formatter[:separator]

                i = 0
                decimals.gsub(/0+$/, '').ljust(formatter[:precision], '0').each_char do |c|
                  if i == 3
                    value << formatter[:delimiter] 
                    i = 0
                  end
                  value << c
                  i += 1
                end
                # .reverse.split(/(?=\d{3})/).reverse.collect{|x| x.reverse}.join(formatter[:delimiter])
                  # value << decimals
              end

              # decimals = decimals.gsub(/0+$/, '').ljust(formatter[:precision], '0').reverse.split(/(?=\d{3})/).reverse.collect{|x| x.reverse}.join(formatter[:delimiter])
              # value += formatter[:separator] + decimals unless decimals.to_s.match(/^\s*$/)
              return format.gsub(/%n/, value).gsub(/%s/, "\u{00A0}")
            end
          end
        elsif object.respond_to?(:strftime)
          return localize_without_numbers(locale, object, format, options)
        else
          raise ArgumentError, "Object must be a Numeric, Date, DateTime or Time object. #{object.inspect} given."
        end
      end

      alias :localize_without_numbers :localize
      alias :localize :localize_with_numbers  

    end
  end
end

# I18n::Backend::Base.send(:include, I18nComplements::Backend::Base)
