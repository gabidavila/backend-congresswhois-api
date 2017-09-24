namespace :import do
  task run_all: :environment do
    tasks = Rake.application.tasks.select { |task| task.to_s.starts_with?('seed:') }
    tasks.each do |task|
      task.invoke
    end
  end
end
