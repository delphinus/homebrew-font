require 'formula'
require 'yaml'

module YAMLDiff
  def diff_txt
    data_to_patch = DATAPatch.new :p1
    data_to_patch.path = Pathname __FILE__
    YAML.load data_to_patch.contents
  end
end

class Powerline < Formula
  extend YAMLDiff
  homepage 'https://github.com/powerline/fontpatcher'
  url 'https://github.com/powerline/fontpatcher/archive/18a788b8ec1822095813b73b0582a096320ff714.zip'
  sha256 'c50a9c9a94e7b5a3f0cd0c149c5c394684c8b9b63e049a9277500286921c29ce'
  version '20150113'
  def initialize(name = 'powerline', path = Pathname(__FILE__), spec = 'stable')
    super
  end
  patch diff_txt[:powerline]
end

class FontnerdiconsFontpatcher < Formula
  extend YAMLDiff
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.3.1'
  url "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v#{version}/font-patcher"
  sha256 '4eb44f809ced10cd441963878f868db1b8f2153e4d419ef488b1874d9b69d453'
  def initialize(name = 'fontnerdicons_fontpatcher', path = Pathname(__FILE__), spec = 'stable')
    super
  end
  patch diff_txt[:webdevicons]
end

class FontnerdiconsDevicons < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.3.1'
  url "https://github.com/ryanoasis/nerd-fonts/raw/v#{version}/glyph-source-fonts/devicons.ttf"
  sha256 'cbb926337e9b6c88b615a2a91e83f304c72e2f7d66835484ab21341f70ee489c'
  def initialize(name = 'fontnerdicons_devicons', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class FontnerdiconsOriginalsource < Formula
  homepage 'https://github.com/ryanoasis/nerd-fonts'
  version '0.3.1'
  url "https://github.com/ryanoasis/nerd-fonts/raw/v#{version}/glyph-source-fonts/original-source.otf"
  sha256 '916057692a3a6902fa538faffb7db6292b96cdbb32b55f478d6bca52ede80213'
  def initialize(name = 'fontnerdicons_originalsource', path = Pathname(__FILE__), spec = 'stable')
    super
  end
end

class Pomicons < Formula
  homepage 'https://github.com/gabrielelana/pomicons'
  version 'master'
  url "https://github.com/gabrielelana/pomicons/raw/#{version}/fonts/Pomicons.otf"
  sha256 'b215bcfb88927419b81c8e86ae8948ad83a9ca34870d71566962032e5afd75a9'
  def initialize(name = 'pomicons', path = Pathname(__FILE__), spec = 'stable')
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

  resource 'vimpowerline' do
    url 'https://github.com/Lokaltog/vim-powerline/archive/09c0cea859.tar.gz'
    sha1 'a1acef16074b6c007a57de979787a9b166f1feb1'
    version '20120817'
  end

  option 'powerline', 'Patch for Powerline'
  option 'vim-powerline', 'Patch for Powerline from vim-powerline'
  option 'webdevicons', 'Patch for vim-webdevicons'
  option 'dz', 'Use Inconsolata-dz instead of Inconsolata'
  option 'disable-fullwidth', 'Disable fullwidth ambiguous characters'
  option 'disable-visible-space', 'Disable visible zenkaku space'
  option 'patch-in-place', "Patch Powerline glyphs directly into Ricty fonts without creating new 'for Powerline' fonts"

  depends_on 'fontforge'

  def install
    share_fonts = share + 'fonts'
    powerline_script = []

    resource('migu1mfonts').stage { share_fonts.install Dir['*'] }
    if build.include? 'powerline'
      powerline = Powerline.new
      powerline.brew { buildpath.install Dir['*'] }
      powerline.patch
      powerline_script << buildpath + 'scripts/powerline-fontpatcher'
      rename_from = '(Ricty|Discord)-?'
      rename_to = "\\1 "
    end
    if build.include?('vim-powerline') && !(build.include?('powerline') && build.include?('patch-in-place'))
      resource('vimpowerline').stage { buildpath.install 'fontpatcher' }
      powerline_script << buildpath + 'fontpatcher/fontpatcher'
      rename_from = "\.ttf"
      rename_to = '-Powerline.ttf'
    end
    if build.include?('webdevicons')
      fontpatcher = FontnerdiconsFontpatcher.new
      fontpatcher.brew { buildpath.install Dir['*'] }
      fontpatcher.patch
      [FontnerdiconsDevicons, FontnerdiconsOriginalsource, Pomicons].each do |klass|
        instance = klass.new
        instance.brew { (buildpath + 'glyph-source-fonts').install Dir['*'] }
      end
      webdevicons_script = buildpath + 'font-patcher'
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

    powerline_args = []
    powerline_args.unshift('--no-rename') if build.include? 'patch-in-place'

    system 'sh', './ricty_generator.sh', *ricty_args
    Dir['Ricty*.ttf'].each do |file|
      system "fontforge -script misc/regular2oblique_converter.pe #{file}"
    end

    ttf_files = Dir['Ricty*.ttf']
    if build.include?('powerline') || build.include?('vim-powerline')
      powerline_script.each do |script|
        ttf_files.each do |ttf|
          system "fontforge -lang=py -script #{script} #{powerline_args.join(' ')} #{ttf}"
          mv ttf.gsub(/#{rename_from}/, rename_to), ttf if build.include? 'patch-in-place'
        end
      end
    end
    if build.include?('webdevicons')
      ttf_files.each do |ttf|
        system "fontforge -lang=py -script #{webdevicons_script} --pomicons #{ttf}"
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
:powerline: |
  diff --git a/scripts/powerline-fontpatcher b/scripts/powerline-fontpatcher
  index ed2bc65..094c974
  --- a/scripts/powerline-fontpatcher
  +++ b/scripts/powerline-fontpatcher
  @@ -73,0 +74,7 @@ class FontPatcher(object):
  +				# Ignore the above calculation and
  +				# manually set the best values for Ricty
  +				target_bb[0]=0
  +				target_bb[1]=-525
  +				target_bb[2]=1025
  +				target_bb[3]=1650
  +

:webdevicons: |
  diff --git a/font-patcher b/font-patcher
  index 26b6bf8..eac1cc7 100755
  --- a/font-patcher
  +++ b/font-patcher
  @@ -39,31 +39,12 @@ if actualVersion < minimumVersion:
       print "Please use at least version: " + str(minimumVersion)
       sys.exit(1)

  -
  -verboseAdditionalFontNameSuffix = " Plus Nerd File Types"
  -
  -if args.windows:
  -    # attempt to shorten here on the additional name BEFORE trimming later
  -    additionalFontNameSuffix = " PNFT"
  -else:
  -    additionalFontNameSuffix = verboseAdditionalFontNameSuffix
  -
  -if args.single:
  -    additionalFontNameSuffix += " Mono"
  -    verboseAdditionalFontNameSuffix += " Mono"
  -
  -if args.pomicons:
  -    additionalFontNameSuffix += " Plus Pomicons"
  -    verboseAdditionalFontNameSuffix += " Plus Pomicons"
  -
  -
   sourceFont = fontforge.open(args.font)

  -fontname, style = re.match("^([^-]*)(?:(-.*))?$", sourceFont.fontname).groups()
  -familyname = sourceFont.familyname + additionalFontNameSuffix
  +fontname = sourceFont.fontname
  +familyname = sourceFont.familyname
   # fullname (filename) can always use long/verbose font name, even in windows
  -fullname = sourceFont.fullname + verboseAdditionalFontNameSuffix
  -fontname = fontname + additionalFontNameSuffix.replace(" ", "")
  +fullname = sourceFont.fullname

   if args.windows:
       maxLength = 31
  @@ -199,6 +180,26 @@ def copy_glyphs(sourceFont, sourceFontStart, sourceFontEnd, symbolFont, symbolFo
               # Prepare symbol glyph dimensions
               sym_dim = get_dim(sym_glyph)

  +            if sourceFontStart == sourceFontRange1Start:
  +                x_ratio = 0.8
  +                y_ratio = 0.8
  +                x_diff = 80
  +                y_diff = -50
  +            elif sourceFontStart == sourceFontRange3Start:
  +                x_ratio = 1.1
  +                y_ratio = 1.1
  +                x_diff = 0
  +                y_diff = -100
  +            else:
  +                x_ratio = 1.05
  +                y_ratio = 1.05
  +                x_diff = 0
  +                y_diff = -200
  +
  +            scale = psMat.scale(x_ratio, y_ratio)
  +            translate = psMat.translate(x_diff, y_diff)
  +            transform = psMat.compose(scale, translate)
  +
               # Select and copy symbol from its encoding point
               symbolFont.selection.select(sym_glyph.encoding)
               symbolFont.copy()
  @@ -207,6 +208,8 @@ def copy_glyphs(sourceFont, sourceFontStart, sourceFontEnd, symbolFont, symbolFo
               sourceFont.selection.select(currentSourceFontGlyph)
               sourceFont.paste()

  +            sourceFont.transform(transform)
  +
               if args.single:
                   # Now that we have copy/pasted the glyph, it's time to scale and move it

