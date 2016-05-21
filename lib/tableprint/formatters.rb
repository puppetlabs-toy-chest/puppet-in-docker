# We monkey patch TablePrint to add support for passing output
# coloured by rainbow, to avoid the truncation that otherwise happens
# due to the extra characters
module TablePrint
  class FixedWidthFormatter # :nodoc:
    def format(value)
      padding = width - length(value.to_s)
      value.to_s + (padding < 0 ? '' : ' ' * padding)
    end

    private

    def length(str)
      str.length
    end
  end
end
