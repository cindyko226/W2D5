require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)
    @array = [@head, @tail]
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    debugger
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head.next 
  end

  def last
    return @tail.prev
  end

  def empty?
    return @head.next == @tail
  end

  def get(key)
    @array.each do |el|
      return el.val if el.key == key
    end

    nil
  end
  
  # def inspect 
  #   return self.key 
  # end


  def include?(key)
    @array.any? {|el| el.key == key}
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @array = @array[0..0] + [new_node] + @array[1..-1]
    
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    @tail.prev = new_node
    new_node.next = @tail

  end

  def update(key, val)
    @array.each do |el|
      if el.key == key
        el.val = val
      end
    end 
  end

  def remove(key)
    @array.each do |el|
      if el.key == key
        el.remove
        @array.delete(el)
      end
    end
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
