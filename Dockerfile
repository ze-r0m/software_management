FROM ruby:3.4.2

WORKDIR /app

## Поддержка прокси для сборки
#ARG HTTP_PROXY
#ARG HTTPS_PROXY
#ARG http_proxy
#ARG https_proxy
#
## Прокидываем их в ENV, чтобы использовались во всех RUN
#ENV http_proxy=${HTTP_PROXY}
#ENV https_proxy=${HTTPS_PROXY}
#ENV HTTP_PROXY=${HTTP_PROXY}
#ENV HTTPS_PROXY=${HTTPS_PROXY}
#ENV no_proxy=${NO_PROXY}

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

#Делаем entrypoint.sh исполняемым
RUN chmod +x /app/entrypoint.sh

# Предкомпилируем ассеты с фиктивным ключом
RUN SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production bundle exec rake assets:precompile

# Удалим pid-файл и запустим сервер
#CMD bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -e production -b 0.0.0.0"

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]