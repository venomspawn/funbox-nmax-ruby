# frozen_string_literal: true

require_relative 'filter'
require_relative 'lexer'

module NMax
  # Class of main application
  class Application
    # Default capacity of data filter structure
    DEFAULT_CAPACITY = 100

    # Initializes instance
    # @param [#getbyte] io
    #   object of input stream with `#getbyte` method of IO-like signature
    # @param [Object] capacity
    #   filter's capacity
    def initialize(io, capacity)
      @io = io
      @lexer = Lexer.new
      @filter = begin
                  Filter.new(capacity.to_i)
                rescue StandardError
                  Filter.new(DEFAULT_CAPACITY)
                end
    end

    # Processes input stream and puts results to standard out
    def run!
      loop do
        code = io.getbyte
        number = lexer.feed(code)
        filter.push(number) unless number.nil?
        break if code.nil?
      end
      filter.each(&method(:puts))
    end

    private

    # Object of input stream
    # @return [#getbyte]
    #   object of input stream
    attr_reader :io

    # Lexer to extract long numbers
    # @return [NMax::Lexer]
    #   lexer to extract long number
    attr_reader :lexer

    # Data filter structure
    # @return [NMax::Filter]
    #   data filter structure
    attr_reader :filter
  end
end
