# frozen_string_literal: true

module NMax
  class Number
    # Module, which contains namespaces of error classes used by the containing
    # class
    module Errors
      # Namespace of error classes used to signal about problems with `str`
      # parameter
      module Str
        # Class of errors which signal that value of `str` parameter is of
        # invalid class
        class InvalidClass < ArgumentError
          # Message on the error
          MESSAGE = 'Value of `str` parameter should be of `String` class'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end

        # Class of errors which signal that value of `str` parameter starts
        # with `0` digit
        class StartsWithZero < ArgumentError
          # Message on the error
          MESSAGE = 'Value of `str` parameter should not start with `0` digit'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end
      end

      # Namespace of error classes used to signal about problems with `zeroes`
      # parameter
      module Zeroes
        # Class of errors which signal that value of `zeroes` parameter is of
        # invalid class
        class InvalidClass < ArgumentError
          # Message on the error
          MESSAGE = 'Value of `zeroes` parameter should be of `Integer` class'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end

        # Class of errors which signal that value of `zeroes` parameter is
        # negative
        class Negative < ArgumentError
          # Message on the error
          MESSAGE = 'Value of `zeroes` parameter should be zero or positive'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end
      end

      # Namespace of error classes used to signal about problems length of
      # string representation of a number
      module Length
        # Class of errors which signal that number has no digits in its string
        # representation
        class Zero < ArgumentError
          # Message on the error
          MESSAGE = 'Number has no digits'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end

        # Class of errors which signal that number has too many digits in its
        # string representation
        class TooLong < ArgumentError
          # Message on the error
          MESSAGE = 'Number has too many digits'

          # Initializes instance of the class
          def initialize
            super(MESSAGE)
          end
        end
      end
    end
  end
end
