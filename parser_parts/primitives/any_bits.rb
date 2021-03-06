require_relative '../requirementless'
require_relative '../scope/scopifier'

class AnyBits < Requirementless
  include Scopifier

  def initialize(size)
    @data = []
    @size = Bits.new case size
    when ConstSize
      size
    when UnboundedSize
      size
    else
      ConstSize.new (size ? size : 1)
    end
  end

  def match(bytes)
    @data = []
    @match_start = bytes.to_j
    idx = -1
    for i in 0..(@size.bits - 1)
      if i % 8 == 0
        idx += 1
        @data[idx] = 0
      else
        @data[idx] = @data[idx] << 1
      end
      @data[idx] |= bytes.next_bit
    end
    @match_end = bytes.to_j
    true
  end

  def duplicate
    AnyBits.new @size.bits
  end

  def matched
    @data
  end

  def size_of
    @size
  end

  def to_j
    bits_s = @data.map do |b|
      b.to_s
    end
    if @match_start == nil
      puts "WAT"
      raise "hell"
    end
    "{\"type\": \"any_bits\", \"value\": #{bits_s}, \"position\": {\"start\": #{@match_start}, \"end\": #{@match_end}}}"
  end
end
