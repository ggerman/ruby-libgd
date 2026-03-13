# Jupyter Notebooks — ruby-libgd

Mathematical function plotting in Ruby, running inside JupyterLab.

These notebooks demonstrate the `Plot` class built on top of [ruby-libgd](https://rubygems.org/gems/ruby-libgd) — plotting explicit functions, implicit curves, and more, entirely in Ruby.

---

## Requirements

- [Docker](https://www.docker.com/)
- No local Ruby or Python installation needed — everything runs inside the container.

---

## Quick start

Build the image:

```bash
docker build -t ruby-jupyter .
```

Run the container, mounting this folder as `/work`:

```bash
docker run -it -p 8888:8888 \
  -v $(pwd):/work \
  ruby-jupyter
```

Open [http://localhost:8888](http://localhost:8888) in your browser, create a new notebook, and select the **Ruby** kernel.

---

## Dockerfile

```dockerfile
FROM python:3.11

RUN apt-get update && apt-get install -y \
    ruby-full \
    build-essential \
    libgd-dev \
    libgd3 \
    libgd-tools \
    valgrind \
    libzmq3-dev

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

RUN pip install jupyterlab
RUN gem install iruby
RUN iruby register --force
RUN gem install ruby-libgd

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", \
     "--no-browser", "--allow-root", "--ServerApp.token="]
```

> **ARM machines (Apple Silicon, AWS Graviton):** replace `x86_64-linux-gnu` with `aarch64-linux-gnu` in the `libdir` path.

---

## Notebooks

| File | Description |
|------|-------------|
| `01_trig_functions.ipynb` | `sin(x)`, `cos(x)`, `tan(x)` with discontinuity detection |
| `02_logarithms_roots.ipynb` | `log(x)`, `log10(x)`, `log2(x)`, `sqrt(x)`, `cbrt(x)` |
| `03_implicit_circles_ellipses.ipynb` | `x²+y²=r²`, ellipses, shifted circles |
| `04_polynomial.ipynb` | `(x+56)³` and other polynomial examples |

---

## Basic usage

```ruby
require 'gd'
# SafeMath and Plot class defined in the first cell

plot = Plot.new(xmin: -10, xmax: 10, ymin: -10, ymax: 10)

# Explicit: y = f(x)
plot.add("sin(x)")
plot.add("cos(x)")
plot.add("log(x)")
plot.add("tan(x)", steps: 6000)

# Implicit: f(x, y) = 0
plot.add("x**2 + y**2 - 9",          type: :implicit)
plot.add("x**2/9.0 + y**2/4.0 - 1",  type: :implicit)

plot.render("/work/graph.png")
```

---

## Supported functions

| Category | Functions |
|----------|-----------|
| Trigonometric | `sin`, `cos`, `tan`, `asin`, `acos`, `atan` |
| Hyperbolic | `sinh`, `cosh`, `tanh` |
| Logarithmic | `log` / `ln` (natural), `log10`, `log2` |
| Algebraic | `sqrt`, `cbrt`, `exp`, `abs` |
| Rounding | `floor`, `ceil`, `round` |
| Constants | `pi`, `e` |

---

## Plot options

```ruby
Plot.new(
  width:  600,    # canvas width in pixels
  height: 600,    # canvas height in pixels
  xmin:  -10.0,
  xmax:   10.0,
  ymin:  -10.0,
  ymax:   10.0
)
```

```ruby
plot.add(
  "sin(x)",
  type:      :explicit,           # :explicit (default) or :implicit
  color:     GD::Color.rgb(r,g,b),# optional — auto palette if omitted
  steps:     3000,                # sample count for explicit curves
  threshold: 0.30                 # zero-crossing tolerance for implicit
)
```

`add` is chainable:

```ruby
plot.add("sin(x)").add("cos(x)").add("x**2 + y**2 - 9", type: :implicit)
```

---

## Links

- Gem: [rubygems.org/gems/ruby-libgd](https://rubygems.org/gems/ruby-libgd)
- Source: [github.com/ggerman/ruby-libgd](https://github.com/ggerman/ruby-libgd)
- Article: [RubyStackNews](https://rubystacknews.com/2026/03/13/plotting-mathematical-functions-in-ruby-inside-jupyter/)
