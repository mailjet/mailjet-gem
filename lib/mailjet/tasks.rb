namespace :mailjet do
  desc "Do smtg."
  task :do_smtg => :environment do
    Mailjet::Mailer.say_hi
  end

  desc "Start a delayed_job worker."
  task :work => :environment do
    Delayed::Worker.new(:min_priority => ENV['MIN_PRIORITY'], :max_priority => ENV['MAX_PRIORITY'], :queues => (ENV['QUEUES'] || ENV['QUEUE'] || '').split(','), :quiet => false).start
  end
end