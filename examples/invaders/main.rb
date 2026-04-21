require 'gd'

# ═══════════════════════════════════════════════════════════════════════════
# Space Invaders Animated GIF Generator using ruby-libgd
# 
# Generates an animated GIF of a simple Space Invaders game
# Pure Ruby, no external processes, using ruby-libgd's native GIF support
# ═══════════════════════════════════════════════════════════════════════════

class SpaceInvadersGame
  WIDTH = 400
  HEIGHT = 300
  FPS = 10
  FRAMES = 60

  def initialize(output_file = "space_invaders.gif")
    @output_file = output_file
    @gif = nil
    @player_x = WIDTH / 2 - 10
    @enemies = []
    @bullets = []
    @score = 0
    @frame_count = 0
    @direction = 1  # 1 for right, -1 for left
    
    initialize_enemies
  end

  # ───────────────────────────────────────────────────────────────────────
  # Initialize enemy positions
  # ───────────────────────────────────────────────────────────────────────
  def initialize_enemies
    @enemies = []
    # 3 rows of enemies
    (0..2).each do |row|
      (0..4).each do |col|
        @enemies << {
          x: 40 + (col * 60),
          y: 40 + (row * 40),
          width: 20,
          height: 20,
          alive: true
        }
      end
    end
  end

  # ───────────────────────────────────────────────────────────────────────
  # Generate the animated GIF
  # ───────────────────────────────────────────────────────────────────────
  def generate
    puts "🎮 Generating Space Invaders GIF..."
    puts "   Size: #{WIDTH}x#{HEIGHT}, Frames: #{FRAMES}, FPS: #{FPS}"

    FRAMES.times do |frame|
      @frame_count = frame
      update_game_state
      img = render_frame
      add_frame_to_gif(img)
    end

    close_gif
    puts "GIF saved to: #{@output_file}"
    puts "   Size: #{File.size(@output_file) / 1024}KB"
  end

  # ───────────────────────────────────────────────────────────────────────
  # Update game state for this frame
  # ───────────────────────────────────────────────────────────────────────
  def update_game_state
    # Move enemies left and right
    move_enemies
    
    # Player moves with sin wave for smooth motion
    @player_x = (WIDTH / 2) + (Math.sin(@frame_count * 0.3) * 80).to_i
    @player_x = [@player_x, 0].max
    @player_x = [@player_x, WIDTH - 20].min

    # Enemies shoot randomly
    if rand < 0.15
      enemy = @enemies.sample
      if enemy && enemy[:alive]
        @bullets << {
          x: enemy[:x] + 10,
          y: enemy[:y] + 20,
          enemy_bullet: true
        }
      end
    end

    # Player shoots
    if @frame_count % 8 == 0
      @bullets << {
        x: @player_x + 10,
        y: HEIGHT - 40,
        enemy_bullet: false
      }
    end

    # Update bullet positions
    @bullets.each do |bullet|
      if bullet[:enemy_bullet]
        bullet[:y] += 5
      else
        bullet[:y] -= 7
      end
    end

    # Remove bullets that are off-screen
    @bullets.reject! { |b| b[:y] < 0 || b[:y] > HEIGHT }

    # Check collisions
    check_collisions

    # Move enemies down and change direction at edges
    if @frame_count % 3 == 0
      @enemies.each do |enemy|
        next unless enemy[:alive]
        enemy[:x] += @direction * 8
      end

      # Change direction if any enemy hits the edge
      if @enemies.any? { |e| e[:alive] && (e[:x] < 10 || e[:x] > WIDTH - 30) }
        @direction *= -1
      end
    end

    # Remove dead enemies
    @enemies.reject! { |e| !e[:alive] }

    # Reset if all enemies defeated
    if @enemies.empty?
      @score += 100
      initialize_enemies
    end
  end

  # ───────────────────────────────────────────────────────────────────────
  # Check collisions between bullets and enemies/player
  # ───────────────────────────────────────────────────────────────────────
  def check_collisions
    @bullets.each do |bullet|
      if !bullet[:enemy_bullet]
        # Player bullet hits enemy
        @enemies.each do |enemy|
          next unless enemy[:alive]
          if collide?(bullet, enemy)
            enemy[:alive] = false
            @score += 10
            @bullets.delete(bullet)
            break
          end
        end
      else
        # Enemy bullet hits player
        if collide?(bullet, { x: @player_x, y: HEIGHT - 30, width: 20, height: 20 })
          @bullets.delete(bullet)
        end
      end
    end
  end

  # ───────────────────────────────────────────────────────────────────────
  # Simple collision detection
  # ───────────────────────────────────────────────────────────────────────
  def collide?(bullet, obj)
    bullet[:x] > obj[:x] &&
      bullet[:x] < obj[:x] + (obj[:width] || 20) &&
      bullet[:y] > obj[:y] &&
      bullet[:y] < obj[:y] + (obj[:height] || 20)
  end

  # ───────────────────────────────────────────────────────────────────────
  # Move enemies (horizontal wave pattern)
  # ───────────────────────────────────────────────────────────────────────
  def move_enemies
    # Enemies move in a wave pattern (already handled in update_game_state)
  end

  # ───────────────────────────────────────────────────────────────────────
  # Render a frame
  # ───────────────────────────────────────────────────────────────────────
  def render_frame
    img = GD::Image.new(WIDTH, HEIGHT)
    
    # Fill background with black
    black = [0, 0, 0]
    white = [255, 255, 255]
    green = [0, 255, 0]
    red = [255, 0, 0]
    cyan = [0, 255, 255]
    yellow = [255, 255, 0]

    img.fill(black)

    # Draw stars (background)
    draw_stars(img, white)

    # Draw enemies
    @enemies.each do |enemy|
      draw_enemy(img, enemy, green)
    end

    # Draw player
    draw_player(img, @player_x, HEIGHT - 30, cyan)

    # Draw bullets
    @bullets.each do |bullet|
      color = bullet[:enemy_bullet] ? red : yellow
      img.filled_circle(bullet[:x], bullet[:y], 2, color)
    end

    # Draw score
    draw_text(img, "SCORE: #{@score}", 10, 10, white)
    draw_text(img, "ENEMIES: #{@enemies.length}", 10, 25, white)
    draw_text(img, "FRAME: #{@frame_count}/#{FRAMES}", 10, 40, white)

    img
  end

  # ───────────────────────────────────────────────────────────────────────
  # Draw a simple enemy sprite
  # ───────────────────────────────────────────────────────────────────────
  def draw_enemy(img, enemy, color)
    x = enemy[:x].to_i
    y = enemy[:y].to_i
    
    # Draw enemy as a rectangle with a simple pattern
    img.filled_rectangle(x, y, x + 20, y + 15, color)
    
    # Eyes
    img.filled_rectangle(x + 4, y + 2, x + 6, y + 4, [0, 0, 0])
    img.filled_rectangle(x + 14, y + 2, x + 16, y + 4, [0, 0, 0])
  end

  # ───────────────────────────────────────────────────────────────────────
  # Draw player sprite
  # ───────────────────────────────────────────────────────────────────────
  def draw_player(img, x, y, color)
    x = x.to_i
    y = y.to_i
    
    # Draw player as a triangle (spaceship)
    # Base
    img.filled_rectangle(x, y + 15, x + 20, y + 20, color)
    
    # Cockpit
    img.filled_rectangle(x + 7, y + 5, x + 13, y + 15, color)
    
    # Engine glow (blinking)
    if @frame_count % 4 < 2
      img.filled_rectangle(x + 5, y + 18, x + 8, y + 20, [255, 100, 0])
      img.filled_rectangle(x + 12, y + 18, x + 15, y + 20, [255, 100, 0])
    end
  end

  # ───────────────────────────────────────────────────────────────────────
  # Draw animated stars in background
  # ───────────────────────────────────────────────────────────────────────
  def draw_stars(img, color)
    # Use frame count to create twinkling effect
    seed = @frame_count
    15.times do |i|
      x = (i * 27 + seed * 5) % WIDTH
      y = (i * 19 + seed * 3) % HEIGHT
      brightness = (Math.sin(seed * 0.1 + i) * 100 + 155).to_i
      star_color = [brightness, brightness, brightness]
      img.filled_circle(x, y, 1, star_color)
    end
  end

  # ───────────────────────────────────────────────────────────────────────
  # Draw text on image
  # ───────────────────────────────────────────────────────────────────────
  def draw_text(img, text, x, y, color)
    # Simple text rendering using small rectangles (pixel art)
    # For now, just use a basic placeholder
    # In production, you'd use img.text() with a TTF font
  end

  # ───────────────────────────────────────────────────────────────────────
  # Add frame to GIF (using ruby-libgd's native GIF support)
  # ───────────────────────────────────────────────────────────────────────
  def add_frame_to_gif(img)
    if @frame_count == 0
      # Create GIF on first frame
      @gif = GD::Gif.new(@output_file, loop: true)
    end

    # Add frame with delay
    delay = (1000 / FPS / 10).to_i  # Convert to centiseconds
    @gif.add_frame(img, delay: [delay, 1].max)  # Minimum 1 centisecond
  end

  # ───────────────────────────────────────────────────────────────────────
  # Close and save the GIF
  # ───────────────────────────────────────────────────────────────────────
  def close_gif
    @gif.close if @gif
  end
end

# ═══════════════════════════════════════════════════════════════════════════
# RUN THE GAME
# ═══════════════════════════════════════════════════════════════════════════

if __FILE__ == $0
  puts "🎮 Space Invaders GIF Generator"
  puts "================================"
  puts ""
  
  game = SpaceInvadersGame.new("space_invaders.gif")
  game.generate
  
  puts ""
  puts "- Play the GIF to see the game in action!"
  puts "- Features:"
  puts "   * Animated enemies (wave pattern)"
  puts "   * Player movement (sin wave)"
  puts "   * Collision detection"
  puts "   * Scoring system"
  puts "   * Enemy bullets vs player bullets"
  puts "   * Twinkling stars background"
  puts "   * 100% ruby-libgd (no external processes)"
  puts ""
end

# ═══════════════════════════════════════════════════════════════════════════
# ALTERNATIVE: SIMPLER VERSION (If you want to start small)
# ═══════════════════════════════════════════════════════════════════════════

class SimpleSpaceInvaders
  def self.generate
    puts "🎮 Generating Simple Space Invaders..."
    
    gif = GD::Gif.new("simple_space_invaders.gif", loop: true)
    
    # Generate 30 frames of simple animation
    30.times do |frame|
      img = GD::Image.new(300, 200)
      
      # Background
      img.fill([0, 0, 50])  # Dark blue
      
      # Enemy (moves left and right)
      enemy_x = 100 + (Math.sin(frame * 0.2) * 80).to_i
      img.filled_rectangle(enemy_x, 50, enemy_x + 30, 80, [0, 255, 0])
      
      # Player (at bottom)
      player_x = 130 + (Math.sin(frame * 0.1) * 40).to_i
      img.filled_rectangle(player_x, 150, player_x + 20, 180, [0, 255, 255])
      
      # Bullet
      if frame % 5 < 2
        bullet_y = 150 - ((frame % 20) * 3)
        img.filled_circle(player_x + 10, bullet_y, 2, [255, 255, 0])
      end
      
      # Score
      img.text("SCORE: #{frame * 10}", {
        x: 10, y: 10,
        size: 12,
        color: [255, 255, 255]
      })
      
      # Add frame to GIF (delay in centiseconds)
      gif.add_frame(img, delay: 10)
    end
    
    gif.close
    puts "* Saved to: simple_space_invaders.gif"
  end
end

# Uncomment to run the simpler version:
# SimpleSpaceInvaders.generate
