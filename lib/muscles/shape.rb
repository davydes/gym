module Muscles
  class Shape < Utils::Enum
    self.i18n_scope = 'muscles.shapes'
    self.valid_values = %w(long short wide diamond square circle)
  end
end