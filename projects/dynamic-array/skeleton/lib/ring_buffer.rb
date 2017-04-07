require "byebug"
require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if check_index(index)
      store[calc_index(index)]
    else
      raise "index out of bounds"
    end
  end


  # O(1)
  def []=(index, value)
    if check_index(index)
      store[calc_index(index)] = value
    else
      raise "index out of bounds"
    end
  end

  # O(1)
  def pop
    if @length > 0
      @length = @length - 1
      store[calc_index(@length)]
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == capacity
    store[calc_index(@length)] = val
    @length = @length + 1
  end

  # O(1)
  def shift
    if @length > 0
      tmp = self[0]
      @start_idx = (start_idx + 1) % capacity
      @length = @length - 1
      tmp
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == capacity
    @start_idx = (start_idx - 1) % capacity
    @length = @length + 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def calc_index(index)
    (start_idx + index) % capacity
  end

  def check_index(index)
    index >= 0 && index < @length
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    @length.times { |i| new_store[i] = self[i] }
    @capacity = @capacity * 2
    @start_idx = 0
    @store = new_store
  end
end
