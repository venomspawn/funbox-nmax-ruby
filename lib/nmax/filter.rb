# frozen_string_literal: true

module NMax
  # Class of data filter structures with limited capacity and descending order
  # of items. All items should provide `#<=` and `#<=>` methods.
  class Filter
    require_relative 'filter/errors'

    include Enumerable

    # Initializes instance of the class, making required checks on provided
    # arguments
    # @param [Integer] capacity
    #   maximum capacity of the instance
    # @raise [ArgumentError]
    #   if the argument is not of `Integer` class
    # @raise [ArgumentError]
    #   if the argument is less than zero or equals it
    def initialize(capacity)
      check_capacity(capacity)
      @capacity = capacity
      @items    = []
    end

    # Pushes value to the data structure if that's possible, saving order of
    # the items
    # @param [Object] value
    #   an object with `#<=` and `#<=>` methods
    def push(value)
      return if full? && value <= items.last

      index = find_index(value)
      return if index.negative?

      items.insert(index, value)
      items.pop if overfull?
    end

    # If a block is given, calls every item to the block in ascending order and
    # returns self. If no block is given, returns an enumerator of the items in
    # the same order.
    # @return [NMax::Filter]
    #   self, if a block is given
    # @return [Enumerator]
    #   enumerator of the items in descending order, if no block is given
    def each
      return items.reverse_each unless block_given?

      items.reverse_each { |x| yield x }
      self
    end

    private

    # Maximum capacity of the data structure
    # @return [Integer]
    #   maximum capacity of the data structure
    attr_reader :capacity

    # Array of items in descending order
    # @return [Array]
    #   array of items in descending order
    attr_reader :items

    # Checks if the argument is of `Integer` class and strictly positive
    # @raise [ArgumentError]
    #   if the argument is not of `Integer` class
    # @raise [ArgumentError]
    #   if the argument is less than zero or equals it
    def check_capacity(capacity)
      raise Errors::Capacity::InvalidClass unless capacity.is_a?(Integer)
      raise Errors::Capacity::InvalidValue unless capacity.positive?
    end

    # Returns if the data structure is full
    # @return [Boolean]
    #   if the data structure is full
    def full?
      capacity <= items.size
    end

    # Returns if the data structure is overfull
    # @return [Boolean]
    #   if the data structure is overfull
    def overfull?
      capacity < items.size
    end

    # Returns index in array of items to insert the argument to or `-1` if
    # there found an item in array, which is equal to the argument
    # @param [#<=>] value
    #   argument
    # @return [Integer]
    #   resulting value
    def find_index(value)
      index = items.bsearch_index do |item|
        comp = item <=> value
        comp.zero? ? (break -1) : (next comp.negative?)
      end
      index || items.size
    end
  end
end
