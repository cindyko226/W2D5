class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      result += (el + idx).hash
    end
    result.hash
  end
end

class String
  def hash
    result = 0
    self.each_char.with_index do |character, idx|
      result += (character.ord + idx).hash
    end
    result.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0 
    self.each do |k, v|
      result += (k.hash + v.hash)
    end
    result.hash
  end
end
