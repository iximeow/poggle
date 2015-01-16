class Bits
  attr_accessor :size

  @@unit = "bits"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size || (ConstSize.new 1)
  end

  def type
    @size.class
  end

  def +(other)
    return other unless other.const
    Bits.new ConstSize.new (@size.value + other.bits)
  end

  def *(other)
    return other unless other.const
    Bits.new ConstSize.new (@size.value * other)
  end

  def const
    @size.const
  end

  def bits
    @size.value
  end

  def bytes
    raise "not a byte-sized value" if @size % 8 == 0
    @size.value / 8
  end
end
