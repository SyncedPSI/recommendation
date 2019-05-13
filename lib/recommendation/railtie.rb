class Recommendation::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/recommendation.rake'
  end
end