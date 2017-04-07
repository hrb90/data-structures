class Vertex
  attr_accessor :value, :in_edges, :out_edges

  def initialize(value)
    @value, @in_edges, @out_edges = value, [], []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    from_vertex.out_edges << self
    @to_vertex = to_vertex
    to_vertex.in_edges << self
    @cost = cost
  end

  def destroy!
    self.to_vertex.in_edges.delete(self)
    self.to_vertex = nil
    self.from_vertex.out_edges.delete(self)
    self.from_vertex = nil
  end
end
