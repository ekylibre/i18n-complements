# TODO: Rewrite this "not DRY" code

class ::String
  def translate(options = {})
    I18n.translate(self, options)
  end
  alias t translate

  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize

  def to_currency
    I18n.currencies(self)
  end
end

class ::Symbol
  def translate(options = {})
    I18n.translate(self, options)
  end
  alias t translate

  def to_currency
    I18n.currencies(to_s)
  end
end

class ::TrueClass
  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize
end

class ::FalseClass
  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize
end

class ::Numeric
  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize
end

class ::Date
  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize
end

class ::DateTime
  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize
end

class ::Time
  def localize(options = {})
    I18n.localize(self, options)
  end
  alias l localize
end
