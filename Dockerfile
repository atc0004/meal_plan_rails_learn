FROM ruby:2.5

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
        postgresql-client \
        nodejs \
        && apt-get -q clean \
        && rm -rf /var/lib/apt/lists

# Prevents the hanging on rebuild
RUN gem install nokogiri -v "1.10.1"

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000

CMD rails server -b 0.0.0.0
