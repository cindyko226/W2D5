class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == num_buckets && include?(key) == false 
      resize!
    end
    if !include?(key)
      # debugger
      self[key] << key 
      @count += 1 
    end 
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
    self[key].delete(key) 
    @count -= 1 
    end 
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
     new_set = HashSet.new(num_buckets*2)
     @store.each do |el|
      el.each do |num|
        new_set.insert(num)
      end 
    end
    @store = new_set.store
  end
end
