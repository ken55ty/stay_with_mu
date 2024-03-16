FROM ruby:3.2.2

ENV TZ Asia/Tokyo
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get install -y vim

# Install yarn
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

# 作業ディレクトリを指定
WORKDIR /stay_with_mu

# ホストのGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile Gemfile.lock /stay_with_mu/

# bundle installを実行
RUN bundle install

# ホストのカレントディレクトリをコンテナにコピー
COPY . /stay_with_mu/

# entrypoint.shをコンテナ内の/usr/binにコピーし、実行権限を与える
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# ENTRYPOINTとCMDを統合
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]