require 'redis'
require 'recommendation/railtie' if defined?(Rails)
require 'recommendation/config'

module Recommendation
  autoload :Base,                  'recommendation/base'
  autoload :JaccardInputMatrix,    'recommendation/jaccard_input_matrix'
  autoload :SimilarityMatrix,      'recommendation/similarity_matrix'

  DEFAULT_MAX_NEIGHBORS = 50
end
