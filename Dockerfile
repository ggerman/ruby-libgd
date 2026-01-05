FROM ruby:3.3

RUN apt update && \
    apt install -y libgd-dev pkg-config build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .

# Build and install ruby-libgd as a real gem
RUN gem build ruby-libgd.gemspec && \
    gem install ruby-libgd-*.gem

# Install test dependencies
RUN gem install rspec chunky_png rake

# Copy specs outside the source tree
RUN mkdir /test && \
    cp -r spec /test/spec

WORKDIR /test

CMD ["rspec", "spec"]
