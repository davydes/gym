class TimeRangeValidator < ActiveModel::EachValidator
  MESSAGES  = { :is => :wrong_time, :minimum => :too_early_time, :maximum => :too_later_time }.freeze
  CHECKS    = { :is => :==, :minimum => :>=, :maximum => :<= }.freeze

  RESERVED_OPTIONS  = [:minimum, :maximum, :within, :in, :is]

  def initialize(options)
    if range = (options.delete(:in) || options.delete(:within))
      raise ArgumentError, ":in and :within must be a Range" unless range.is_a?(Range)
      options[:minimum], options[:maximum] = range.begin, range.end
      options[:maximum] -= 1.day if range.exclude_end?
    end

    super
  end

  def check_validity!
    keys = CHECKS.keys & options.keys

    if keys.empty?
      raise ArgumentError, 'Range unspecified. Specify the :within, :maximum, :minimum, or :is option.'
    end

    keys.each do |key|
      value = options[key]

      unless value.is_a?(Time)
        raise ArgumentError, ":#{key} must be a Time instead #{value.class}"
      end
    end

    if keys.include?(:minimum) && keys.include?(:maximum) && options[:maximum] <= options[:minimum]
      raise ArgumentError, 'maximum time must be later minimum time'
    end
  end

  def validate_each(record, attribute, value)
    return if value.nil?
    raise(ArgumentError, "'A Time object was expected instead #{value.class}") unless value.kind_of? Time

    CHECKS.each do |key, validity_check|
      next unless check_value = options[key]
      next if value.send(validity_check, check_value)

      errors_options = options.except(*RESERVED_OPTIONS)
      errors_options[:time] = check_value

      default_message = options[MESSAGES[key]]
      errors_options[:message] ||= default_message if default_message

      record.errors.add(attribute, MESSAGES[key], errors_options)
    end
  end
end
