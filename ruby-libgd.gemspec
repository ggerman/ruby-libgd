Gem::Specification.new do |s|
  s.name        = "ruby-libgd"
  s.version     = "0.1.3"
  s.summary     = "Native Ruby bindings for libgd"
  s.description = "High-performance native Ruby bindings to libgd for image generation, drawing, filters, alpha blending, and transformations."
  s.authors     = ["Germán Alberto Giménez Silva"]
  s.email       = ["ggerman@gmail.com"]
  s.homepage    = "https://github.com/ggerman/ruby-libgd"
  s.license     = "MIT"

  s.files       = Dir["lib/**/*", "ext/**/*", "README.md", "LICENSE", "CHANGELOG.md"]
  s.extensions  = ["ext/gd/extconf.rb"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 3.0"
end
