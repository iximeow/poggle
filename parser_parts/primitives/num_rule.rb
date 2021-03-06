require_relative '../requirementless'
require_relative '../scope/scopifier'

include Math

class NumRule < Requirementless
  include Scopifier

  def initialize(num)
    @matchNum = num
    word_size = word_size @matchNum
    @bytes = [@matchNum].pack(size_for(word_size)).to_s.unpack("C"*word_size)
  end

  def size_for(size)
    case size
    when 1
      "C"
    when 2
      "S"
    when 4
      "L"
    when 8
      "Q"
    else
      throw "Unknown word size: #{size}"
    end
  end

  def duplicate
    NumRule.new @matchNum
  end

  def size_of
    Bytes.new ConstSize.new @bytes.length
  end

  def match(bytes)
    for i in 0..(@bytes.length-1)
      if @bytes[i] != bytes.next
        return false
      end
    end
    true
  end

  def to_s
    "Value #{@matchNum} consisting of #{@bytes.length} bytes (#{@bytes.to_s})"
  end

  def to_j
    bytes_s = @bytes.map do |b|
      "\"#{b.to_s(16)}\""
    end
    "{\"type\": \"number\", \"value\": [#{bytes_s.join(", ")}]}"
  end
end
