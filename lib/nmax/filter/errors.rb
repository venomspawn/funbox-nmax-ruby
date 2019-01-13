# frozen_string_literal: true

module NMax
  class Filter
    # Module, which contains namespaces of error classes used by the containing
    # class
    module Errors
      # Namespace of error classes used to signal about problems with
      # `capacity` parameter
      module Capacity
        # Class of errors which signal that value of `capacity` parameter is of
        # invalid class
        class InvalidClass < ArgumentError
          # Message on the error
          MESSAGE = 'Value of `capacity` parameter should be of `String` class'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end

        # Class of errors which signal that value of `capacity` parameter is
        # less than zero or equals it
        class InvalidValue < ArgumentError
          # Message on the error
          MESSAGE = 'Value of `capacity` parameter should be more than zero'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end
      end
    end
  end
end
