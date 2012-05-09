require 'bundler/setup'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'i18n-complements'

for file in Dir[File.join(File.dirname(__FILE__), "locales", "*.yml")]
  I18n.backend.load_translations(file)
end
