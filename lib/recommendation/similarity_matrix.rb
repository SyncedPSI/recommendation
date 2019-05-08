module Recommendation
  class SimilarityMatrix
    attr_reader :write_queue

    def initialize(opts = {})
      @opts = opts
      @write_queue = Hash.new { |h, k| h[k] = {} }
    end

    def redis_key(append = nil)
      [@opts.fetch(:redis_prefix), @opts.fetch(:action), append].flatten.compact.join(':')
    end

    def max_neighbors
      @opts[:max_neighbors] || Recommendation::DEFAULT_MAX_NEIGHBORS
    end

    def update(item_id, neighbors)
      neighbors.each do |neighbor, weight|
        if @write_queue[item_id].key?(neighbor)
          @write_queue[item_id][neighbor] += weight
        else
          @write_queue[item_id][neighbor] = weight
        end
      end
    end

    def [](item_id)
      @write_queue[item_id]
    end

    def commit_item!(item_id)
      neighbor_items = @write_queue[item_id].to_a
      most_similar_items = get_similar_items(neighbor_items)
      Recommendation.redis.hset(redis_key, item_id, most_similar_items)
      @write_queue.delete(item_id)
    end

    def get_similar_items(neighbor_items)
      neighbor_items.sort! { |a, b| b[1] <=> a[1] }
      most_similar_items = neighbor_items[0..max_neighbors - 1]
      most_similar_items = most_similar_items.map { |item, similarity| similarity.positive? ? "#{item}: #{similarity.to_s[0..5]}" : nil }
      most_similar_items.compact * '|'
    end
  end
end
