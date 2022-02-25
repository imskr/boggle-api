FROM ruby:2.7.5

RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client

ADD . /boggle-docker

WORKDIR /boggle-docker

RUN bundle install

EXPOSE 3000

CMD ["bash"]
