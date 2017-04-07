require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}
  map_prc = Proc.new { |x, y| x[:cost] <=> y[:cost] }
  possible_paths = PriorityMap.new(&map_prc)
  possible_paths[source] = { cost: 0, last_edge: nil }
  until possible_paths.empty?
    lcv, val = possible_paths.extract
    shortest_paths[lcv] = val
    lcv.out_edges.each do |edge|
      new_vertex = edge.to_vertex
      new_cost = val[:cost] + edge.cost
      unless shortest_paths.include?(edge.to_vertex) ||
        (possible_paths[new_vertex] && possible_paths[new_vertex][:cost] < new_cost)
        possible_paths[new_vertex] = { cost: new_cost, last_edge: edge }
      end
    end
  end

  shortest_paths
end
