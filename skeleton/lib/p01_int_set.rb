require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless num <= @store.length && num >= 0
    @store[num - 1] = true
  end

  def remove(num)
    @store[num - 1] = false
  end

  def include?(num)
    return true if @store[num - 1] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # self[num] << num unless include?(num)
    if @count == num_buckets && include?(num) == false 
      resize!
    end
    if !include?(num)
      # debugger
      self[num] << num 
      @count += 1 
    end 
  end

  def remove(num)
    if self.include?(num)
    self[num].delete(num) 
    @count -= 1 
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = ResizingIntSet.new(num_buckets*2)
    @store.each do |el|
      el.each do |num|
        new_set.insert(num)
      end 
    end
    @store = new_set.store
  end
  
end
