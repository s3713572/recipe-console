FROM ruby:3.0.1
RUN gem install bundler:1.17.2
RUN apt-get update -qq && apt-get install -y nodejs npm
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle config build.nio4r --with-cflags="-std=c99"
RUN bundle install
RUN npm install -g yarn
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-e", "production"]