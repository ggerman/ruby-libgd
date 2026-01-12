<header>
  <img src="../images/logo.png" height="250" alt="ruby-libgd" />
  <h1>Ruby は再び画像を生成できる</h1>
  <p class="lead">
    ruby-libgd は、GD グラフィックスライブラリを基盤とした
    Ruby 向けの最新ネイティブバインディングです。
    チャート、ダッシュボード、GIS、科学可視化のための
    高速で組み込み可能なラスターエンジンを提供します。
  </p>

  <div class="buttons">
    <a href="https://github.com/ggerman/ruby-libgd">GitHub</a>
    <a class="secondary" href="https://rubygems.org/gems/ruby-libgd">RubyGems</a>
    <a class="secondary" href="https://rubystacknews.com/2026/01/05/ruby-can-create-images-again/">記事を読む</a>
  </div>
</header>

<div class="connect-bar">
  <h3>連絡先</h3>
  <div class="connect-links">
    <a href="mailto:ggerman@gmail.com">📧 メール</a>
    <a href="https://wa.me/5493434192620" target="_blank">💬 WhatsApp</a>
    <a href="https://rubystacknews.com" target="_blank">🌐 RubyStackNews</a>
    <a href="https://x.com/ruby_stack_news" target="_blank">🐦 Twitter</a>
    <a href="https://www.linkedin.com/in/germ%C3%A1n-silva-56a12622/" target="_blank">💼 LinkedIn</a>
  </div>
</div>

<div class="connect-bar">
  <h3>ドキュメント</h3>
  <div class="connect-links">
    <a href="/ruby-libgd/index.html">🇬🇧 English</a>
    <a href="/ruby-libgd/jp/index.html">🇯🇵 日本語</a>
    <a href="https://github.com/ggerman/ruby-libgd">📦 GitHub</a>
    <a href="https://rubygems.org/gems/ruby-libgd">💎 RubyGems</a>
  </div>
</div>


# ruby-libgd — Ruby向けグラフィックス＆画像処理エンジン

`ruby-libgd` は GD C ライブラリを基盤とした Ruby 用のネイティブ 2D ラスターグラフィックスエンジンです。  
`GD::Image` クラスを通じて、描画、テキスト、フィルタ、合成、画像入出力の完全な API を提供します。

---

## コアクラス

| クラス | 説明 |
|------|------|
| `GD::Image` | ラスター画像キャンバス。すべての描画・フィルタ・出力操作を提供 |

---

## キャンバス & コア

| メソッド | 説明 |
|--------|-------------|
| [`GD::Image.new`](io/new.md) | 新しい TrueColor キャンバスを作成 |
| [`GD::Image.open`](io/load.md) | 画像をディスクから読み込み |
| [`width`](core/width.md) | 画像の幅 |
| [`height`](core/height.md) | 画像の高さ |
| [`color`](core/color.md) | 色を割り当て（RGBA） |
| [`clone`](transform/clone.md) | 画像を複製 |
| [`destroy`](core/destroy.md) | メモリを解放 |

---

## 色（Color）

| メソッド | 説明 |
|--------|-------------|
| [`GD::Color.rgb`](color/rgb.md) | RGB 色を作成 |
| [`GD::Color.rgba`](color/rgba.md) | RGBA 色を作成 |
| [`GD::Color`](color/model.md) | カラーモデル |

---

## 描画（Drawing）

| メソッド | 説明 |
|-------|-------------|
| [`line`](drawing/line_ja.md) | 直線を描画 |
| [`rectangle`](drawing/rectangle_ja.md) | 四角形の枠線を描画 |
| [`filled_rectangle`](drawing/filled_rectangle_ja.md) | 塗りつぶし四角形 |
| [`ellipse`](drawing/ellipse_ja.md) | 楕円を描画 |
| [`filled_ellipse`](drawing/filled_ellipse_ja.md) | 塗りつぶし楕円 |
| [`circle`](drawing/circle_ja.md) | 円を描画 |
| [`filled_circle`](drawing/filled_circle_ja.md) | 塗りつぶし円 |
| [`polygon`](drawing/polygon_ja.md) | 多角形を描画 |
| [`filled_polygon`](drawing/filled_polygon_ja.md) | 塗りつぶし多角形 |
| [antialias](antialiasing.md) | アンチエイリアスとアルファ合成 |

---

## テキスト（Text）

| メソッド | 説明 |
|--------|-------------|
| [`text`](text/text_ja.md) | UTF-8 TrueType テキストを描画 |

---

## フィルタ（Filters）

| メソッド | 説明 |
|--------|-------------|
| [`filter`](filters/filter.md) | 画像フィルタを適用 |
| [`filter("sepia")`](filters/sepia.md) | セピア調（ruby-libgd 実装） |

---

## 変換（Transformations）

| メソッド | 説明 |
|--------|-------------|
| [`crop`](transform/crop.md) | 切り抜き |
| [`scale`](transform/scale.md) | リサイズ |
| [`resize`](transform/resize.md) | `scale` のエイリアス |
| [`clone`](transform/clone.md) | 画像を複製 |

---

## 合成（Composition）

| メソッド | 説明 |
|--------|-------------|
| [`copy`](composition/copy.md) | 別の画像からコピー |
| [`copy_resize`](composition/copy_resize.md) | コピー＆リサイズ |

---

## 入出力（Input & Output）

| メソッド | 説明 |
|--------|-------------|
| [`GD::Image.open`](io/load.md) | 画像を読み込み |
| [`save`](io/save.md) | PNG / JPEG / WebP で保存 |
| [`to_png`](io/to_png.md) | PNG バイト列としてエンコード |
