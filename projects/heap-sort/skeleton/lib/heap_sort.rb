require_relative "heap"

class Array
  def heap_sort!
    # Use max heaps
    prc = Proc.new { |x, y| -1 * (x <=> y) }
    # Heapify in place
    length.times { |i| BinaryMinHeap.heapify_up(self, i, i, &prc) }
    length.times do |i|
      self[0], self[length - i - 1] = self[length - i - 1], self[0]
      BinaryMinHeap.heapify_down(self, 0, length - i - 1, &prc)
    end
  end
end
