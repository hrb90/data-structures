class BinaryMinHeap
  def initialize(&prc)
    @prc = prc
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    tmp = @store.pop
    @store = self.class.heapify_down(@store, 0, count, &prc)
    tmp
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    @store = self.class.heapify_up(@store, count - 1, count, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select { |x| x < len }
  end

  def self.parent_index(child_index)
    if child_index > 0
      (child_index - 1) / 2
    else
      raise "root has no parent"
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    child_indices = self.child_indices(len, parent_idx)
    if child_indices.length == 0
      return array
    else
      min_val, min_idx = child_indices.map { |i| [array[i], i] }.min(&prc)
      if prc.call(array[parent_idx], min_val) < 0
        return array
      else
        array[parent_idx], array[min_idx] = array[min_idx], array[parent_idx]
        return self.heapify_down(array, min_idx, len, &prc)
      end
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if child_idx == 0
    parent_index = self.parent_index(child_idx)
    if prc.call(array[parent_index], array[child_idx]) < 0
      return array
    else
      array[parent_index], array[child_idx] = array[child_idx], array[parent_index]
      return self.heapify_up(array, parent_index, len, &prc)
    end
  end
end
