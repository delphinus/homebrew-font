require 'formula'
require 'yaml'

module YAMLDiff
  def diff_txt
    data_to_patch = DATAPatch.new :p1
    data_to_patch.path = Pathname __FILE__
    YAML.load data_to_patch.contents
  end
end

class NerdfontsFontpatcher < Formula
  extend YAMLDiff
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/font-patcher"
  sha256 '9a192ed5b007cd38b7c7f10cdb345e495ebff4ec7e4fb50ba55a5f14528d98de'
  def initialize(name = 'nerdfonts_fontpatcher', path = Pathname(__FILE__), spec = 'stable')
    super
  end
  patch diff_txt[:nerdfonts]
end

class NerdfontsChangelog < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/changelog.md"
  sha256 '00a66eb59f4f09340aecb08c4fa5ac8f823ea78a78329cea748c5544bc81c4c4'
  def initialize(name = 'nerdfonts_devicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsDevicons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/devicons.ttf"
  sha256 'cbb926337e9b6c88b615a2a91e83f304c72e2f7d66835484ab21341f70ee489c'
  def initialize(name = 'nerdfonts_devicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsOriginalsource < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/original-source.otf"
  sha256 '767a71c1ebf5129d7548b92c8ec15a4089d717a38b267ba0f09bed9d37956c7e'
  def initialize(name = 'nerdfonts_originalsource', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsPomicons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/Pomicons.otf"
  sha256 'b215bcfb88927419b81c8e86ae8948ad83a9ca34870d71566962032e5afd75a9'
  def initialize(name = 'nerdfonts_pomicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsPowerline < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/PowerlineSymbols.otf"
  sha256 '4a2496a009b1649878ce067a7ec2aed9f79656c90136971e1dba00766515f7a1'
  def initialize(name = 'nerdfonts_powerline', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsPowerlineExtra < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/PowerlineExtraSymbols.otf"
  sha256 '0705a52454b3bede8207d05ced7f70cef2ef3e8435d978fc59adc4897240102a'
  def initialize(name = 'nerdfonts_powerlineextra', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsFontawesome < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/FontAwesome.otf"
  sha256 '7961070f76a33c1307de19ce2a93dc2b26d6747fa759aee5045118644c758acc'
  def initialize(name = 'nerdfonts_fontawesome', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsOcticons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.6.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/octicons.ttf"
  sha256 'e9893ef786b007dafe957659590584b484e93ca983da3eedfba24fc2bade856e'
  def initialize(name = 'nerdfonts_octicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class Ricty < Formula
  homepage 'https://github.com/yascentur/Ricty'
  url 'https://github.com/yascentur/Ricty/archive/4.0.1.tar.gz'
  sha1 'b851f5fea12706dc868951fe6ed32d047a9ebe85'
  version '4.0.1'

  resource 'inconsolataregular' do
    url 'https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf'
    sha1 '493154cb3884f5dcdfcac5515ea0db1f7281538f'
    version '1.0.0'
  end

  resource 'inconsolatabold' do
    url 'https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf'
    sha1 '8639e856aa9ea16e0d519206f76942ce87d23017'
    version '1.0.0'
  end

  resource 'migu1mfonts' do
    url 'http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip'
    sha1 'a0641894cec593f8bb1e5c2bf630f20ee9746b18'
    version '20130617'
  end

  option 'nerdfonts', 'Patch for nerdfonts'
  option 'disable-fullwidth', 'Disable fullwidth ambiguous characters'
  option 'disable-visible-space', 'Disable visible zenkaku space'

  depends_on 'fontforge'

  def install
    share_fonts = share + 'fonts'

    resource('migu1mfonts').stage { share_fonts.install Dir['*'] }
    if build.include?('nerdfonts')
      fontpatcher = NerdfontsFontpatcher.new
      fontpatcher.brew { buildpath.install Dir['*'] }
      fontpatcher.patch
      changelog = NerdfontsChangelog.new
      changelog.brew { buildpath.install Dir['*'] }
      [
        NerdfontsDevicons,
        NerdfontsOriginalsource,
        NerdfontsPomicons,
        NerdfontsPowerline,
        NerdfontsPowerlineExtra,
        NerdfontsFontawesome,
        NerdfontsOcticons,
      ].each do |klass|
        instance = klass.new
        instance.brew { (buildpath + 'glyph-source-fonts').install Dir['*'] }
      end
      nerdfonts_script = buildpath + 'font-patcher'
      rename_from = '(Ricty|Discord|Bold(?=Oblique))-?'
      rename_to = "\\1 "
    end

    resource('inconsolataregular').stage { share_fonts.install Dir['*'] }
    inconsolataregular = share_fonts + 'Inconsolata-Regular.ttf'
    resource('inconsolatabold').stage { share_fonts.install Dir['*'] }
    inconsolatabold = share_fonts + 'Inconsolata-Bold.ttf'

    ricty_args = [inconsolataregular, inconsolatabold, share_fonts + 'migu-1m-regular.ttf', share_fonts + 'migu-1m-bold.ttf']
    ricty_args.unshift('-z') if build.include? 'disable-visible-space'
    ricty_args.unshift('-a') if build.include? 'disable-fullwidth'

    system 'sh', './ricty_generator.sh', *ricty_args
    Dir['Ricty*.ttf'].each do |file|
      system "fontforge -script misc/regular2oblique_converter.pe #{file}"
    end

    ttf_files = Dir['Ricty*.ttf']
    if build.include?('nerdfonts')
      ttf_files.each do |ttf|
        system "fontforge -lang=py -script #{nerdfonts_script} --fontawesome --octicons --pomicons --powerline --powerlineextra #{ttf}"
        mv ttf.gsub(/#{rename_from}/, rename_to), ttf
      end
    end
    share_fonts.install Dir['Ricty*.ttf']
  end

  test do
    system 'false'
  end

  def caveats; <<-EOS.undent
    ***************************************************
    Generated files:
      #{Dir[share + 'fonts/Ricty*.ttf'].join("\n      ")}
    ***************************************************
    To install Ricty:
      $ cp -f #{share}/fonts/Ricty*.ttf ~/Library/Fonts/
      $ fc-cache -vf
    ***************************************************
    EOS
  end
end

__END__
:nerdfonts: |
  diff --git a/font-patcher b/font-patcher
  index 57bb42b..235721a 100755
  --- a/font-patcher
  +++ b/font-patcher
  @@ -86,8 +86,7 @@ sourceFont = fontforge.open(args.font)
   fontname, style = re.match("^([^-]*)(?:(-.*))?$", sourceFont.fontname).groups()
   familyname = sourceFont.familyname
   # fullname (filename) can always use long/verbose font name, even in windows
  -fullname = sourceFont.fullname + verboseAdditionalFontNameSuffix
  -fontname = fontname + additionalFontNameSuffix.replace(" ", "")
  +fullname = sourceFont.fullname

   if args.windows:
       maxLength = 31
  @@ -122,9 +121,6 @@ reservedFontNameReplacements = { 'source': 'sauce', 'Source': 'Sauce', 'hermit':

   projectInfo = "Patched with 'Nerd Fonts Patcher' (https://github.com/ryanoasis/nerd-fonts)"

  -sourceFont.familyname = replace_all(familyname, reservedFontNameReplacements)
  -sourceFont.fullname = replace_all(fullname, reservedFontNameReplacements)
  -sourceFont.fontname = replace_all(fontname, reservedFontNameReplacements)
   sourceFont.appendSFNTName('English (US)', 'Preferred Family', sourceFont.familyname)
   sourceFont.appendSFNTName('English (US)', 'Compatible Full', sourceFont.fullname)
   sourceFont.comment = projectInfo
  @@ -296,6 +292,49 @@ def copy_glyphs(sourceFont, sourceFontStart, sourceFontEnd, symbolFont, symbolFo
       symbolFont.selection.select(("ranges","unicode"),symbolFontStart,symbolFontEnd)
       sourceFont.selection.select(("ranges","unicode"),sourceFontStart,sourceFontEnd)

  +    if sourceFontStart == sourceFontPomiconsStart:
  +      x_ratio = 1.1
  +      y_ratio = 1.1
  +      x_diff = 0
  +      y_diff = -100
  +    elif sourceFontStart in [symbolsPowerlineRange1Start, symbolsPowerlineRange2Start]:
  +      x_ratio = 0.96
  +      y_ratio = 0.88
  +      x_diff = 0
  +      y_diff = -40
  +    elif sourceFontStart in [symbolsPowerlineExtraRange1Start, symbolsPowerlineExtraRange2Start, symbolsPowerlineExtraRange3Start]:
  +      x_ratio = 0.4
  +      y_ratio = 0.4
  +      x_diff = 0
  +      y_diff = 0
  +    elif sourceFontStart == sourceFontOriginalStart:
  +      x_ratio = 0.9
  +      y_ratio = 0.9
  +      x_diff = 50
  +      y_diff = -50
  +    elif sourceFontStart == sourceFontDeviconsStart:
  +      x_ratio = 1.0
  +      y_ratio = 1.0
  +      x_diff = -150
  +      y_diff = -150
  +    elif sourceFontStart == sourceFontFontAwesomeStart:
  +      x_ratio = 0.95
  +      y_ratio = 0.95
  +      x_diff = 0
  +      y_diff = -60
  +    elif sourceFontStart == sourceFontOcticonsStart:
  +      x_ratio = 1.0
  +      y_ratio = 1.0
  +      x_diff = 0
  +      y_diff = -55
  +    else:
  +      print '{0:X}'.format(sourceFontStart)
  +
  +    scale = psMat.scale(x_ratio, y_ratio)
  +    translate = psMat.translate(x_diff, y_diff)
  +    transform = psMat.compose(scale, translate)
  +    symbolFont.transform(transform)
  +
       for sym_glyph in symbolFont.selection.byGlyphs:
               #sym_attr = SYM_ATTR[sym_glyph.unicode]
               glyphName = sym_glyph.glyphname
  @@ -418,8 +457,8 @@ copy_glyphs(sourceFont, sourceFontOriginalStart, sourceFontOriginalEnd, symbols,
   copy_glyphs(sourceFont, sourceFontDeviconsStart, sourceFontDeviconsEnd, symbolsDevicons, symbolsDeviconsRangeStart, symbolsDeviconsRangeEnd)

   if args.powerline:
  -    copy_glyphs(sourceFont, symbolsPowerlineRange1Start, symbolsPowerlineRange1End, sourceFont, symbolsPowerlineRange1Start, symbolsPowerlineRange1End)
  -    copy_glyphs(sourceFont, symbolsPowerlineRange2Start, symbolsPowerlineRange2End, sourceFont, symbolsPowerlineRange2Start, symbolsPowerlineRange2End)
  +    copy_glyphs(sourceFont, symbolsPowerlineRange1Start, symbolsPowerlineRange1End, powerlineSymbols, symbolsPowerlineRange1Start, symbolsPowerlineRange1End)
  +    copy_glyphs(sourceFont, symbolsPowerlineRange2Start, symbolsPowerlineRange2End, powerlineSymbols, symbolsPowerlineRange2Start, symbolsPowerlineRange2End)

   if args.powerlineextra:
       copy_glyphs(sourceFont, symbolsPowerlineExtraRange1Start, symbolsPowerlineExtraRange1End, powerlineExtraSymbols, symbolsPowerlineExtraRange1Start, symbolsPowerlineExtraRange1End, True)
