require 'rails_helper'
require 'validators/time_range_validator'

class Validatable
  include ActiveModel::Validations
  attr_accessor  :time
end

describe TimeRangeValidator do
  describe '[:is]' do
    before(:all) do
      @validatable = Validatable.new
      @validatable.class_eval { validates :time, time_range: { is: Time.parse('2015-01-01 01:12:12') } }
    end

    it 'should validate valid date' do
      @validatable.time = Time.parse('2015-01-01 01:12:12')
      expect(@validatable).to be_valid
    end

    it 'should validate invalid date' do
      @validatable.time = Time.parse('2012-12-12 12:12:12')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end
  end

  describe '[:maximum]' do
    before(:all) do
      @validatable = Validatable.new
      @validatable.class_eval { validates :time, time_range: { maximum: Time.parse('2015-01-01 01:01:01') } }
    end

    it 'should validate valid date' do
      @validatable.time = Time.parse('2015-01-01 01:01:01')
      expect(@validatable).to be_valid
    end

    it 'should be invalid with later date' do
      @validatable.time = Time.parse('2015-01-01 01:01:02')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end
  end

  describe '[:minimum]' do
    before(:all) do
      @validatable = Validatable.new
      @validatable.class_eval { validates :time, time_range: { minimum: Time.parse('2015-01-01 01:01:02') } }
    end

    it 'should validate valid date' do
      @validatable.time = Time.parse('2015-01-01 01:01:02')
      expect(@validatable).to be_valid
    end

    it 'should be invalid with early date' do
      @validatable.time = Time.parse('2015-01-01 01:01:01')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end
  end

  describe '[:minimum && :maximum]' do
    before(:all) do
      @validatable = Validatable.new
      @validatable.class_eval { validates :time,
                                          time_range: {
                                              minimum: Time.parse('2015-01-01 01:01:02'),
                                              maximum: Time.parse('2015-01-01 01:01:04')
                                          }
      }
    end

    it 'should validate valid date' do
      @validatable.time = Time.parse('2015-01-01 01:01:03')
      expect(@validatable).to be_valid
    end

    it 'should be invalid with early date' do
      @validatable.time = Time.parse('2015-01-01 01:01:01')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end

    it 'should be invalid with later date' do
      @validatable.time = Time.parse('2015-01-01 01:01:05')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end
  end

  describe '[:in]' do
    before(:all) do
      @validatable = Validatable.new
      @validatable.class_eval { validates :time,
                                          time_range: {
                                              in: Time.parse('2015-01-01 01:01:02')..Time.parse('2015-01-01 01:01:04')
                                          }
      }
    end

    it 'should validate valid date' do
      @validatable.time = Time.parse('2015-01-01 01:01:03')
      expect(@validatable).to be_valid
    end

    it 'should be invalid with early date' do
      @validatable.time = Time.parse('2015-01-01 01:01:01')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end

    it 'should be invalid with later date' do
      @validatable.time = Time.parse('2015-01-01 01:01:05')
      expect(@validatable).not_to be_valid
      expect(@validatable.errors.keys).to be == [:time]
    end
  end
end