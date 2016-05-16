# We monkey patch TablePrint to add support for passing output
# coloured by colorize, to avoid the truncation that otherwise happens
# due to the extra characters
module TablePrint
  class FixedWidthFormatter
    def format(value)
      padding = width - length(value.to_s)
      truncate(value) + (padding < 0 ? '' : " " * padding)
    end
		private
    def truncate(value)
      return "" unless value
      test = value.uncolorize.to_s
      return value unless test.length > width
      "#{value[0..width-4]}..."
    end
    def length(str)
      str.uncolorize.length
    end
  end
end
