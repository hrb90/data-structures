require "byebug"
require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if check_index(index)
      store[index]
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def []=(index, value)
    if check_index(index)
      store[index] = value
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def pop
    if @length > 0
      tmp = store[@length - 1]
      store[@length - 1] = nil
      @length = @length - 1
      tmp
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == capacity
    store[@length] = val
    @length = @length + 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length > 0
      (@length - 1).times { |i| store[i] = store[i + 1] }
      @length = @length - 1
    else
      raise "index out of bounds"
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == capacity
    @length.times { |i| store[length - i] = store[length - i - 1] }
    @length = @length + 1
    store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    index >= 0 && index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    new_store = StaticArray.new(@capacity)
    @length.times { |i| new_store[i] = store[i] }
    @store = new_store
  end
end
