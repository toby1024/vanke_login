FROM ruby:2.3

RUN echo '====================start vanke login===================='

COPY . /app

CMD ruby /app/login.rb $PHONE $PASSWORD