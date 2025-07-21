FROM ruby:3.4.2

WORKDIR /rails

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  default-mysql-client \
  nodejs \
  curl \
  yarn \
  && rm -rf /var/lib/apt/lists/*

# Устанавливаем нужную версию bundler
RUN gem install bundler -v 2.6.6

# Устанавливаем Node.js через n
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Копируем и устанавливаем зависимости
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Копируем весь проект
COPY . .

# Удалим PID перед запуском
CMD ["bash", "-c", "rm -f tmp/pids/server.pid"]
CMD ["bash", "-c", "rm -f bin/dev"]
