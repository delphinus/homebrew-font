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
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/font-patcher"
  sha256 '754cfbfa06eb419baf9f244bbe9b32367f0de38517e0d4be517844f49f7e5cfb'
  def initialize(name = 'nerdfonts_fontpatcher', path = Pathname(__FILE__), spec = 'stable')
    super
  end
  patch diff_txt[:nerdfonts]
end

class NerdfontsChangelog < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/changelog.md"
  sha256 '37d8824943c35f21e3f0653d9c57601372741fff3ac81cd047ab3d446c5710ac'
  def initialize(name = 'nerdfonts_devicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsDevicons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/devicons.ttf"
  sha256 'cbb926337e9b6c88b615a2a91e83f304c72e2f7d66835484ab21341f70ee489c'
  def initialize(name = 'nerdfonts_devicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsOriginalsource < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/original-source.otf"
  sha256 '767a71c1ebf5129d7548b92c8ec15a4089d717a38b267ba0f09bed9d37956c7e'
  def initialize(name = 'nerdfonts_originalsource', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsPomicons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/Pomicons.otf"
  sha256 'b215bcfb88927419b81c8e86ae8948ad83a9ca34870d71566962032e5afd75a9'
  def initialize(name = 'nerdfonts_pomicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsPowerline < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/PowerlineSymbols.otf"
  sha256 '4a2496a009b1649878ce067a7ec2aed9f79656c90136971e1dba00766515f7a1'
  def initialize(name = 'nerdfonts_powerline', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsFontawesome < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/FontAwesome.otf"
  sha256 '7961070f76a33c1307de19ce2a93dc2b26d6747fa759aee5045118644c758acc'
  def initialize(name = 'nerdfonts_fontawesome', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class NerdfontsOcticons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.5.0'
  url "https://github.com/ryanoasis/nerd-fonts/raw/#{version}/glyph-source-fonts/octicons.ttf"
  sha256 'de09ac73ef5b5960535750e2151f6652e2b8efa40dbfaaeba73c55c6692c9071'
  def initialize(name = 'nerdfonts_octicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class Ricty < Formula
  homepage 'https://github.com/yascentur/Ricty'
  url 'https://github.com/yascentur/Ricty/archive/3.2.4.tar.gz'
  sha1 '7fc8adcc74656d9e2e1acd325de82f0f08a6d222'
  version '3.2.4'

  resource 'inconsolatafonts' do
    url 'http://levien.com/type/myfonts/Inconsolata.otf'
    sha1 '7f0a4919d91edcef0af9dc153054ec49d1ab3072'
    version '1.0.0'
  end

  resource 'inconsolatadzfonts' do
    url 'http://media.nodnod.net/Inconsolata-dz.otf.zip'
    sha1 'c8254dbed67fb134d4747a7f41095cedab33b879'
    version '1.0.0'
  end

  resource 'migu1mfonts' do
    url 'http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip'
    sha1 'a0641894cec593f8bb1e5c2bf630f20ee9746b18'
    version '20130617'
  end

  option 'nerdfonts', 'Patch for nerdfonts'
  option 'dz', 'Use Inconsolata-dz instead of Inconsolata'
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
      [NerdfontsDevicons, NerdfontsOriginalsource, NerdfontsPomicons, NerdfontsPowerline, NerdfontsFontawesome, NerdfontsOcticons].each do |klass|
        instance = klass.new
        instance.brew { (buildpath + 'glyph-source-fonts').install Dir['*'] }
      end
      nerdfonts_script = buildpath + 'font-patcher'
      rename_from = '(Ricty|Discord|Bold(?=Oblique))-?'
      rename_to = "\\1 "
    end
    if build.include? 'dz'
      resource('inconsolatadzfonts').stage { share_fonts.install Dir['*'] }
      inconsolata = share_fonts + 'Inconsolata-dz.otf'
      # Patch the discord script since the special characters are in different locations in Inconsolata-dz
      inreplace 'ricty_discord_patch.pe', '65608', '65543' # Serif r
      inreplace 'ricty_discord_patch.pe', '65610', '65545' # Un-dotted zero
    else
      resource('inconsolatafonts').stage { share_fonts.install Dir['*'] }
      inconsolata = share_fonts + 'Inconsolata.otf'
    end

    ricty_args = [inconsolata, share_fonts + 'migu-1m-regular.ttf', share_fonts + 'migu-1m-bold.ttf']
    ricty_args.unshift('-z') if build.include? 'disable-visible-space'
    ricty_args.unshift('-a') if build.include? 'disable-fullwidth'

    system 'sh', './ricty_generator.sh', *ricty_args
    Dir['Ricty*.ttf'].each do |file|
      system "fontforge -script misc/regular2oblique_converter.pe #{file}"
    end

    ttf_files = Dir['Ricty*.ttf']
    if build.include?('nerdfonts')
      ttf_files.each do |ttf|
        system "fontforge -lang=py -script #{nerdfonts_script} --fontawesome --octicons --pomicons --powerline #{ttf}"
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
  index 4dd5a54..8a8a774 100755
  --- a/font-patcher
  +++ b/font-patcher
  @@ -72,10 +72,9 @@ if args.pomicons:
   sourceFont = fontforge.open(args.font)

   fontname, style = re.match("^([^-]*)(?:(-.*))?$", sourceFont.fontname).groups()
  -familyname = sourceFont.familyname + additionalFontNameSuffix
  +familyname = sourceFont.familyname
   # fullname (filename) can always use long/verbose font name, even in windows
  -fullname = sourceFont.fullname + verboseAdditionalFontNameSuffix
  -fontname = fontname + additionalFontNameSuffix.replace(" ", "")
  +fullname = sourceFont.fullname

   if args.windows:
       maxLength = 31
  @@ -95,14 +94,8 @@ def replace_all(text, dic):
           text = text.replace(i, j)
       return text

  -# comply with SIL Open Font License (OFL)
  -reservedFontNameReplacements = { 'source': 'sauce', 'Source': 'Sauce', 'hermit': 'hurmit', 'Hermit': 'Hurmit', 'fira': 'fura', 'Fira': 'Fura', 'hack': 'knack', 'Hack': 'Knack' }
  -
   projectInfo = "Patched with 'Nerd Fonts Patcher' (https://github.com/ryanoasis/nerd-fonts)"

  -sourceFont.familyname = replace_all(familyname, reservedFontNameReplacements)
  -sourceFont.fullname = replace_all(fullname, reservedFontNameReplacements)
  -sourceFont.fontname = replace_all(fontname, reservedFontNameReplacements)
   sourceFont.appendSFNTName('English (US)', 'Preferred Family', sourceFont.familyname)
   sourceFont.appendSFNTName('English (US)', 'Compatible Full', sourceFont.fullname)
   sourceFont.comment = projectInfo
  @@ -285,6 +278,43 @@ def copy_glyphs(sourceFont, sourceFontStart, sourceFontEnd, symbolFont, symbolFo
               # Prepare symbol glyph dimensions
               sym_dim = get_dim(sym_glyph)

  +            if sourceFontStart == sourceFontPomiconsStart:
  +              x_ratio = 1.1
  +              y_ratio = 1.1
  +              x_diff = 0
  +              y_diff = -100
  +            elif sourceFontStart in [symbolsPowerlineRange1Start, symbolsPowerlineRange2Start]:
  +              x_ratio = 0.96
  +              y_ratio = 0.88
  +              x_diff = 0
  +              y_diff = -40
  +            elif sourceFontStart == sourceFontOriginalStart:
  +              x_ratio = 0.9
  +              y_ratio = 0.9
  +              x_diff = 50
  +              y_diff = -50
  +            elif sourceFontStart == sourceFontDeviconsStart:
  +              x_ratio = 1.1
  +              y_ratio = 1.1
  +              x_diff = -150
  +              y_diff = -180
  +            elif sourceFontStart == sourceFontFontAwesomeStart:
  +              x_ratio = 1.0
  +              y_ratio = 1.0
  +              x_diff = 0
  +              y_diff = -100
  +            elif sourceFontStart == sourceFontOcticonsStart:
  +              x_ratio = 1.0
  +              y_ratio = 1.0
  +              x_diff = 0
  +              y_diff = -55
  +            else:
  +              print '{0:X}'.format(sourceFontStart)
  +
  +            scale = psMat.scale(x_ratio, y_ratio)
  +            translate = psMat.translate(x_diff, y_diff)
  +            transform = psMat.compose(scale, translate)
  +
               # Select and copy symbol from its encoding point
               symbolFont.selection.select(sym_glyph.encoding)
               symbolFont.copy()
  @@ -293,6 +323,8 @@ def copy_glyphs(sourceFont, sourceFontStart, sourceFontEnd, symbolFont, symbolFo
               sourceFont.selection.select(currentSourceFontGlyph)
               sourceFont.paste()

  +            sourceFont.transform(transform)
  +
               if args.single:
                   # Now that we have copy/pasted the glyph, it's time to scale and move it

  @@ -372,8 +404,8 @@ copy_glyphs(sourceFont, sourceFontOriginalStart, sourceFontOriginalEnd, symbols,
   copy_glyphs(sourceFont, sourceFontDeviconsStart, sourceFontDeviconsEnd, symbolsDevicons, symbolsDeviconsRangeStart, symbolsDeviconsRangeEnd)

   if args.powerline:
  -    copy_glyphs(sourceFont, symbolsPowerlineRange1Start, symbolsPowerlineRange1End, sourceFont, symbolsPowerlineRange1Start, symbolsPowerlineRange1End)
  -    copy_glyphs(sourceFont, symbolsPowerlineRange2Start, symbolsPowerlineRange2End, sourceFont, symbolsPowerlineRange2Start, symbolsPowerlineRange2End)
  +    copy_glyphs(sourceFont, symbolsPowerlineRange1Start, symbolsPowerlineRange1End, powerlineSymbols, symbolsPowerlineRange1Start, symbolsPowerlineRange1End)
  +    copy_glyphs(sourceFont, symbolsPowerlineRange2Start, symbolsPowerlineRange2End, powerlineSymbols, symbolsPowerlineRange2Start, symbolsPowerlineRange2End)


   if args.fontawesome:

