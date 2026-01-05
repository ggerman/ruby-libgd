# Ruby Libgd

<p align="right">
  <img src="docs/images/logo.png" width="160" />
</p>

# ruby-libgd
Native GD bindings for modern Ruby

![RubyStackNews](examples/images/rubystacknews-banner.png)

## What is ruby-libgd?

ruby-libgd is a modern native Ruby binding to the GD Graphics Library, providing Ruby with a fast, embeddable, server-side graphics engine.

It enables Ruby to generate images, charts, dashboards, GIS tiles, and scientific graphics without spawning external processes.

## Installation

gem install ruby-libgd

System dependencies:

apt install -y libgd-dev pkg-config

## Examples

All runnable examples live in:

examples/
  basics/
  image_processing/
  charts/
  images/

Each Ruby script in examples/ generates an image in examples/images/.

## Sample output

![Fruit chart](examples/images/fruit_chart_with_text.png)
![Pie chart](examples/images/pie_chart.png)
![World population](examples/images/world_population.png)
![Stem plot](examples/images/stem_plot.png)
![Aitoff](examples/images/aitoff_matplotlib.png)

## Links

GitHub: https://github.com/ggerman/ruby-libgd  
RubyGems: https://rubygems.org/gems/ruby-libgd  
Article: https://rubystacknews.com/2026/01/02/rebuilding-rubys-image-processing-layer-why-ruby-libgd-matters-for-gis-and-the-future-of-ruby/

Ruby got its raster engine back.
