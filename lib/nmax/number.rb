# frozen_string_literal: true

module NMax
  # Class which wraps around regular support of long integers in Ruby with
  # addition of leading zeroes information support
  class Number
    require_relative 'number/errors'

    # Maximum allowed length of string of digits of a number, including leading
    # zeroes
    MAX_LENGTH = 1_000

    # Initializes instance of class, making required checks on incoming data
    # @param [String] str
    #   string of digits
    # @param [Integer] zeroes
    #   amount of leading zeroes
    # @raise [ArgumentError]
    #   if `str` parameter is not of `String` class
    # @raise [ArgumentError]
    #   if the value `str` parameter starts with `0` digit
    # @raise [ArgumentError]
    #   if `zeroes` parameter is not of `Integer` class
    # @raise [ArgumentError]
    #   if the value of `zeroes` parameter is negative
    # @raise [ArgumentError]
    #   if sum of length of `str` parameter value and `zeroes` value is more
    #   than the value of {MAX_LENGTH}
    def initialize(str, zeroes)
      check_str(str)
      check_zeroes(zeroes)
      check_length(str, zeroes)
      @num = Integer(str)
      @zeroes = zeroes
    end

    # Performs comparison of the wrapped integer with other object's `#num`
    # property and returns result of the comparison
    # @param [#num] other
    #   other object
    # @return [Integer]
    #   result of the comparison
    def <=>(other)
      num <=> other.num
    end

    # Returns string representation of the number with leading zeroes included
    # @return [String]
    def to_s
      "#{'0' * zeroes}#{num}"
    end

    protected

    # Wrapped long integer
    # @return [Integer]
    #   wrapped long integer
    attr_reader :num

    private

    # Amount of leading zeroes
    # @return [Integer]
    #   amount of leading zeroes
    attr_reader :zeroes

    # Checks if the argument is of `String` class and if it doesn't start with
    # `0` digit
    # @type [Object] str
    #   argument
    # @raise [ArgumentError]
    #   if the argument is not of `String` class
    # @raise [ArgumentError]
    #   if the arguments starts with `0` digit
    def check_str(str)
      raise Errors::Str::InvalidClass unless str.is_a?(String)
      raise Errors::Str::StartsWithZero if str.start_with?('0')
    end

    # Checks if the argument is of `Integer` class and if it is positive or
    # zero
    # @type [Object] zeroes
    #   argument
    # @raise [ArgumentError]
    #   if the argument is not of `Integer` class
    # @raise [ArgumentError]
    #   if the argument is negative
    def check_zeroes(zeroes)
      raise Errors::Zeroes::InvalidClass unless zeroes.is_a?(Integer)
      raise Errors::Zeroes::Negative if zeroes.negative?
    end

    # Checks if sum of length of `str` string and `zeroes` value is no more
    # than value of {MAX_LENGTH}
    # @param [String] str
    #   a string
    # @param [Integer] zeroes
    #   an integer
    # @raise [ArgumentError]
    #   if sum of length of `str` string and `zeroes` value is more than the
    #   value of {MAX_LENGTH}
    def check_length(str, zeroes)
      raise Errors::Length::TooLong if str.length + zeroes > MAX_LENGTH
    end
  end
end
