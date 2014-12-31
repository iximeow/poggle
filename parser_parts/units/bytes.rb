require_relative './const_size'

class Bytes
  @@unit = "bytes"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size || (ConstSize.new 1)
  end

  def bytes
    @size.force
  end

  def bits
    @size.force * 8
  end

  def const
    @size.const
  end

  def +(other)
    return self unless const
    case other
    when Bytes
      Bytes.new(bytes + other.bytes)
    when Bits
      Bits.new(bits + other.bits)
    else
      throw "Unhandlable size #{other}"
    end
  end

  def *(other)
    Bytes.new(@size * other)
  end

  def size
    bytes
  end

  def to_s
    "#{@size} #{@@unit}"
  end
end