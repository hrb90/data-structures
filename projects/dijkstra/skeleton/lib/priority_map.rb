require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    @map = {}
    heap_prc = Proc.new { |x, y| prc.call(@map[x], @map[y]) }
    @queue = BinaryMinHeap.new(&heap_prc)
  end

  def [](key)
    map[key]
  end

  def []=(key, value)
    already_in = map.has_key?(key)
    map[key] = value
    already_in ? update(key, value) : insert(key, value)
  end

  def count
    @queue.count
  end

  def empty?
    @queue.empty?
  end

  def extract
    min_vertex = @queue.extract
    [min_vertex, map.delete(min_vertex)]
  end

  def has_key?(key)
    map.has_key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @queue.push(key)
  end

  def update(key, value)
    queue.reduce!(key)
  end
end
