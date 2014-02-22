#encoding: UTF-8

# Converts a string with tones from numbers (e.g., "pin1yin1") to diacritics
# (e.g., "pīnyīn"), and vice versa
#
# Examples
#
#   Pinyin.to_accents('huan1ying2 guan1lin2!')
#   # => "huānyíng guānlín!"
#
#   Pinyin.to_numbers('huānyíng guānlín!')
#   # => "huan1ying2 guan1lin2!"
class Pinyin
  # source: http://www.chinese-tools.com/tools/converter-pinyin-unicode.html
  ACCENTS = {
    a: ['a', 'ā', 'á', 'ǎ', 'à'],
    e: ['e', 'ē', 'é', 'ě', 'è'],
    i: ['i', 'ī', 'í', 'ǐ', 'ì'],
    o: ['o', 'ō', 'ó', 'ǒ', 'ò'],
    u: ['u', 'ū', 'ú', 'ǔ', 'ù'],
    v: ['ü', 'ǖ', 'ǘ', 'ǚ', 'ǜ'],
    A: ['A', 'Ā', 'Á', 'Ă', 'À'],
    E: ['E', 'Ē', 'É', 'Ĕ', 'È'],
    O: ['O', 'Ō', 'Ó', 'Ŏ', 'Ò'],
  }

  ACCENTS_STRING = "āēīōūǖĀĒŌáéíóúǘÁÉÓǎěǐǒǔǚĂĔŎàèìòùǜÀÈÒ"
  ACCENTS_PER_TONE = ACCENTS_STRING.length / 4

  # Array order matches that of COMBINATION_EXISTS
  INITIALS = ['b', 'p', 'm', 'f',
              'd', 't', 'n', 'l',
              'g', 'k', 'h',
              'z', 'c', 's',
              'zh', 'ch', 'sh', 'r',
              'j', 'q', 'x',
              'w', 'y', '']

  # Regexp will match first occurence
  # Array order matches that of COMBINATION_EXISTS
  FINALS = ['ou', 'ong', 'o', 'eng', 'en', 'ei', 'e', 'ao', 'ang', 'an', 'ai', 'a', 
            'uo', 'un', 'ui', 'ue', 'uang', 'uan', 'uai', 'ua', 'u', 
            'iu', 'iong', 'ing', 'in', 'ie', 'iao', 'iang', 'ian', 'ia', 'i', 
            'vn', 've']

  # All combination of initial + final that exists
  # Modified from source: http://en.wikipedia.org/wiki/Pinyin_table
  COMBINATION_EXISTS = [
    [false, false, true, false, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, true, false, false, true, true, true, true, false, true, false, true, false, false],
    [true, false, true, false, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, true, false, false, true, true, true, true, false, true, false, true, false, false],
    [true, false, true, false, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, true, true, false, true, true, true, true, false, true, false, true, false, false],
    [true, false, true, false, true, true, true, false, false, true, true, false, true, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, false, true, false, false, true, true, false, true, false, true, true, false, true, true, true, false, false],
    [true, true, false, false, true, false, true, true, true, true, true, true, true, true, true, true, false, false, true, false, false, true, false, false, false, false, true, true, false, true, false, true, false, false],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, false, false, false, true, false, false, true, true, false, true, true, true, true, true, true, false, true, true, true],
    [true, true, false, false, true, false, true, true, true, true, true, true, true, true, true, false, false, false, true, false, false, true, true, false, true, true, true, true, true, true, true, true, true, true],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, false, true, false, false],
    [true, true, false, false, true, true, false, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, false, true, false, false],
    [true, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, false, false, false, false, false, false, false, false, false, true, false, false],
    [true, true, false, false, true, true, true, true, true, true, true, true, true, true, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, true, false, false],
    [true, true, false, false, true, true, false, true, true, true, true, true, true, true, true, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, true, false, false],
    [true, true, false, false, true, true, false, true, true, true, true, true, true, true, true, true, false, false, true, false, false, true, false, false, false, false, true, false, false, false, false, true, false, false],
    [true, true, false, false, true, true, false, true, true, true, true, false, false, true, true, true, false, false, true, false, true, true, false, false, false, false, false, false, false, false, false, true, false, false],
    [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true, false, true, false, false, true, true, true, true, true, true, true, true, true, true, true, false, false],
    [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true, false, true, false, false, true, true, true, true, true, true, true, true, true, true, true, false, false],
    [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true, false, true, false, false, true, true, true, true, true, true, true, true, true, true, true, false, false],
    [false, false, true, false, true, true, true, false, false, true, true, true, true, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false],
    [true, true, false, false, false, false, false, true, true, true, true, false, true, false, true, false, true, false, true, false, false, true, false, false, true, true, false, false, false, false, false, true, false, false],
    [true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false],
  ]

  # Public: Convert numbered pinyin string (e.g., "pin1yin2") to ones with
  #         diacritics ("pīnyīn").
  #
  # string  - A numbered pinyin string 
  #
  # Examples
  #
  #   Pinyin.to_accents('huan1ying2 guan1lin2!')
  #   # => "huānyíng guānlín!"
  #
  # Returns a pinyin with diacritics.
  def self.to_accents(string)
    # u:, ü, v all mean the same thing
    string.gsub!(/(u:|ü)/, 'v')

    string.gsub!(%r{
      (?<initial>#{INITIALS.join('|')})
      (?<final>#{FINALS.join('|')})
      (?<tone>\d)?
    }xi) do
      syllable = [$~[:initial], $~[:final], $~[:tone]]
      valid_word?(*syllable) ? accent(*syllable) : syllable[0, 2].join
    end
  end

  # Public: Convert pinyin with diacritics (e.g., "pīnyīn") to numbered ones
  #         (e.g., "pin1yin2")
  #
  # string  - A numbered pinyin string 
  #
  # Examples
  #
  #   Pinyin.to_numbers('huānyíng guānlín!')
  #   # => "huan1ying2 guan1lin2!"
  #
  # Returns a numbered pinyin.
  def self.to_numbers(string)
    offset = 0
    deaccented = string.tr(ACCENTS_STRING, 'aeiouvAEO'*4)

    deaccented.gsub!(%r{
      (?<initial>#{INITIALS.join('|')})
      (?<final>#{FINALS.join('|')})
    }xi) do |syllable|
      initial, final = $~[:initial], $~[:final]
      offset = deaccented.index(syllable, offset)

      accented_vowel = string[offset, syllable.length][/[#{ACCENTS_STRING}]/]
      tone = ACCENTS_STRING.index(accented_vowel) / ACCENTS_PER_TONE + 1 if accented_vowel
      
      syllable += tone.to_s if accented_vowel && valid_word?(initial, final)

      syllable
    end
  end

  # Internal: Adds accents to individual syllables (e.g., from "pin1" to "pīn")
  #
  # initial - Initial consonant(s) (e.g., "p" in "pin") 
  # final   - Final letters (e.g., "in" in "pin")
  # tone    - Expecting numbers 1 to 4, indicating tone of syllable
  #
  # Examples
  #
  #   Pinyin.accent('p', 'in', 1)
  #   # => "pīn"
  #
  # Returns a syllable with diacritics.
  def self.accent(initial, final, tone)
    return initial + final if tone.nil?

    tone = tone.to_i

    vowels = final[/[aeiou]+/i]

    # accent first vowel unless number of vowels > 1 and first vowel is
    # either i, u, or v
    to_accent = (vowels.length > 1 && vowels[0][/[iuv]/]) ? vowels[1] : vowels[0]

    # substitute vowel for accented vowel
    final_with_accent = final.sub(to_accent, ACCENTS[to_accent.to_sym][tone])

    return initial + final_with_accent
  end

  def self.valid_word?(i, f, tone=nil)
    COMBINATION_EXISTS[INITIALS.index(i.downcase)][FINALS.index(f.downcase)]
  end

  private_class_method :accent, :valid_word?
end
