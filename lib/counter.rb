class Counter < Hash
    def initialize(other = nil)
      super(0)
      if other.is_a? Array 
        other.each { |e| self[e] += 1 }
      end
      if other.is_a? Hash
        other.each { |k,v| self[k] = v }
      end
      if other.is_a? String
        other.each_char { |e| self[e] += 1 }
      end
    end
    def +(rhs)
       raise TypeError, "cannot add #{rhs.class} to a Counter" if ! rhs.is_a? Counter  
       result = Counter.new(self)
       rhs.each { |k, v| result[k] += v }
       result
    end
    def -(rhs)
       raise TypeError, "cannot subtract #{rhs.class} to a Counter" if ! rhs.is_a? Counter  
       result = Counter.new(self)
       rhs.each { |k, v| result[k] -= v }
       result
    end
    def most_common(n = nil)
       s = sort_by {|k, v| -v}
       return n ? s.take(n) : s
    end
    def to_s
       "Counter(#{super.to_s})"
    end
    def inspect
       to_s
    end
end