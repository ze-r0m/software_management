puts "Загрузка сидов для окружения: #{Rails.env}"

seed_file = Rails.root.join('db', 'seeds', "#{Rails.env}.rb")

load(seed_file) if File.exist?(seed_file)
