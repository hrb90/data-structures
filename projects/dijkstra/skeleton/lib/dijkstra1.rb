require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = { source => { cost: 0, last_edge: nil } }
  until possible_paths.empty?
    lcv = nil
    min_value = 1.0/0.0
    possible_paths.each do |vertex, h|
      if h[:cost] < min_value
        lcv = vertex
        min_value = h[:cost]
      end
    end
    shortest_paths[lcv] = possible_paths[lcv]
    possible_paths.delete(lcv)
    lcv.out_edges.each do |edge|
      new_vertex = edge.to_vertex
      new_cost = min_value + edge.cost
      unless shortest_paths.include?(edge.to_vertex) ||
        (possible_paths[new_vertex] && possible_paths[new_vertex][:cost] < new_cost)
        possible_paths[new_vertex] = { cost: new_cost, last_edge: edge }
      end
    end
  end

  shortest_paths
end
