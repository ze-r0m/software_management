FROM ruby:3.4.2

WORKDIR /app

# Установим зависимости
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-mysql-client \
  curl \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

# Устанавливаем нужный bundler
RUN gem install bundler -v 2.6.6

# Копируем только Gemfile и устанавливаем гемы
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Копируем всё приложение
COPY . .

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

# Предкомпилируем ассеты
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Удалим pid-файл и запустим сервер
#CMD bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -e production -b 0.0.0.0"

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]