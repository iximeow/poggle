class RuleBody
  def initialize(size, body)
    @size = size
    @body = body
    if not @body
      puts "No body present, size of data to match for this rule is #{@size}"
    end
    if not @size
      puts "Must infer a size for #{body}"
    end
  end
end