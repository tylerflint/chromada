namespace :mother do
  desc "seed actions table from mother.yml"
  task :seed_actions => :environment do
    require 'mother'
    Mother.seed_actions
  end
end