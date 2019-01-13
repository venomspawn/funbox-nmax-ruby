# frozen_string_literal: true

require_relative 'number'

module NMax
  # Class of lexers that extract long numbers from input stream
  class Lexer
    # Initializes instance
    def initialize
      @buf = String.new(' ' * Number::MAX_LENGTH, encoding: Encoding::BINARY)
      reset
    end

    # ASCII code of `0` digit
    DIGIT_0 = 48

    # ASCII code of `9` digit
    DIGIT_9 = 57

    # Range of ASCII codes of digits
    DIGITS = (DIGIT_0..DIGIT_9).freeze

    # Feeds provided ASCII symbol code to the lexer. Returns a long number, if
    # there is one ready, or `nil` otherwise.
    # @param [Integer] code
    #   symbol code
    # @return [NMax::Number]
    #   long number, if there is one ready
    # @return [NilClass]
    #   if a number is not ready
    def feed(code)
      if DIGITS.include?(code)
        feed_digit(code)
      elsif number?
        flush
      end
    end

    private

    # Buffer of digits
    # @return [String]
    #   buffer of digits
    attr_reader :buf

    # Current amount of digits in buffer
    # @return [Integer]
    #   current amount of digits in buffer
    attr_reader :digits

    # Current amount of leading zeroes
    # @return [Integer]
    #   current amount of digits in buffer
    attr_reader :zeroes

    # Feeds provided ASCII code of a digit to the lexer. Returns a long number,
    # if it's grown long enough, or `nil` otherwise.
    # @param [Integer] code
    #   code of a digit
    # @return [NMax::Number]
    #   stored long number, if it's grown long enough
    # @return [NilClass]
    #   if stored long number has yet to grow long enough
    def feed_digit(code)
      code == DIGIT_0 && empty? ? inc_zeroes : add_digit(code)
      flush if full?
    end

    # Returns if stored long number has grown long enough
    # @return [Boolean]
    #   if stored long number has grown long enough
    def full?
      Number::MAX_LENGTH <= digits + zeroes
    end

    # Returns if there is no digits in the buffer
    # @return [Boolean]
    #   if there is no digits in the buffer
    def empty?
      digits.zero?
    end

    # Returns if stored long number can be flushed
    # @return [Boolean]
    #   if stored long number can be flushed
    def number?
      digits.positive? || zeroes.positive?
    end

    # Returns stored long number, resetting lexer
    # @return [NMax::Number]
    #   flushed number
    def flush
      Number.new(buf[0, digits], zeroes).tap { reset }
    end

    # Resets current amounts of stored digits and leading zeroes
    def reset
      @digits = 0
      @zeroes = 0
    end

    # Increases amount of leading zeroes by 1
    def inc_zeroes
      @zeroes += 1
    end

    # Stores digit with the provided ASCII code in the buffer
    # @param [Integer] code
    #   code of the digit
    def add_digit(code)
      buf.setbyte(digits, code)
      @digits += 1
    end
  end
end
