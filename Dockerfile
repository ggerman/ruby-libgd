FROM ruby:3.3

# avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system packages required to build the native extension and pkg-config
RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
     build-essential pkg-config libgd-dev libpng-dev libjpeg-dev zlib1g-dev libfreetype6-dev \
     ca-certificates git \
  && rm -rf /var/lib/apt/lists/*

# Provide a pkg-config file for gd (ensures extconf.rb can find gd via pkg-config)
RUN printf "prefix=/usr\n\
exec_prefix=\${prefix}\n\
libdir=\${exec_prefix}/lib/x86_64-linux-gnu\n\
includedir=\${prefix}/include\n\
\n\
Name: gd\n\
Description: GD Graphics Library\n\
Version: 2.3\n\
Libs: -L\${libdir} -lgd\n\
Cflags: -I\${includedir}\n" \
> /usr/lib/x86_64-linux-gnu/pkgconfig/gd.pc

ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

WORKDIR /app

# Copy only Gemfile(s) first to leverage Docker layer caching
# If you don't have Gemfile.lock, the second copy will be ignored but it's fine.
COPY Gemfile Gemfile.lock* ./

# Install bundler and gems declared in Gemfile/Gemfile.lock
RUN gem install bundler --no-document \
  && bundle config set --local deployment 'false' \
  && bundle install --jobs 4 --retry 3

# Copy the rest of the project
COPY . .

# Compile the native extension (best-effort at image build time)
# Keep this step idempotent: if ext/gd doesn't exist it will be skipped.
RUN if [ -d "ext/gd" ]; then \
      cd ext/gd && make clean || true && ruby extconf.rb && make && cd ../..; \
    else \
      echo "ext/gd not found; skipping native build step"; \
    fi

# Build the gem artifact from the gemspec (if present)
RUN if [ -f "ruby-libgd.gemspec" ]; then \
      gem build ruby-libgd.gemspec; \
    else \
      echo "ruby-libgd.gemspec not found; skipping gem build"; \
    fi

# If a gem file was produced, install it (this ensures the installed gem is the one tests exercise)
RUN if ls ruby-libgd-*.gem 1> /dev/null 2>&1; then \
      gem install ruby-libgd-*.gem --force; \
    else \
      echo "No built gem found; continuing"; \
    fi

# Install test/dev tools globally so tests can be run without bundler path tricks
RUN gem install rspec chunky_png rake --no-document

# Ensure common gem bin dirs are on PATH
ENV PATH="/usr/local/bundle/bin:/usr/local/bin:/usr/bin:${PATH}"

# Default to an interactive shell; CI should run the test commands inside the container.
CMD ["bash"]
