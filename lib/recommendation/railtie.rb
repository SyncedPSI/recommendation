module Recommendation
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/recommendation_tasks.rake'
    end
  end
end