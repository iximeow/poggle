require_relative './scope/scopifier'

class Rule < BodyProxy
  include Scopifier
  scopify :body

  def initialize(name, body)
    @name = name
    @body = body
    self.enscopen(Scope.new)
  end

  def duplicate
    Rule.new @name, @body.duplicate
  end

  # not so sure about this
  def enscopen(scope)
    @body.enscopen(scope)
  end

  def infer_size
    @body.infer_size
  end

  def name
    @name
  end

  def matched
    @body.matched
  end

  def to_s
    "#{@name}: #{@body}"
  end
end

