module Utils
  class Enum < String
    class_attribute :i18n_scope
    class_attribute :valid_values

    def self.values
      @values ||= Array(valid_values).map { |val| new(val) }
    end

    def initialize(s)
      unless s.in?(Array(valid_values))
        raise ArgumentError, "#{s.inspect} is not a valid #{self.class} value"
      end
      super
    end

    def human_name
      if i18n_scope.blank?
        raise NotImplementedError, 'Your subclass must define :i18n_scope'
      end
      I18n.t!(value, scope: i18n_scope)
    end

    def value
      to_s
    end

    def as_json(opts = nil)
      {
          'value'      => value,
          'human_name' => human_name
      }
    end

    def self.load(value)
      if value.present?
        new(value)
      else
        # Don't try to convert nil or empty strings
        value
      end
    end

    def self.dump(obj)
      obj.to_s
    end
  end
end