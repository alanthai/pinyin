Pinyin
======
Converts pinyin tones from numbers to diacritics (accents)

Converts a string with tones from numbers (e.g., "pin1yin1") to diacritics
(e.g., "pīnyīn"), and vice versa

## Examples

    Pinyin.to_accents('huan1ying2 guan1lin2!')
    # => huānyíng guānlín!

    Pinyin.to_numbers('huānyíng guānlín!')
    # => huan1ying2 guan1lin2!

Generally, it is possible to add punctuations and other non-pinyin words in the string. However, this might lead to unexpected behavior.

It will not make the conversion if the pinyin is incorrect. See the following table:
http://en.wikipedia.org/wiki/Pinyin_table

    Pinyin.to_accents('lon2') # no such syllable 'lon'
    # => lon2

    Pinyin.to_numbers('lón')
    # => lon

When there are two tones, the first one that appears is selected

	Pinyin.to_accents('kuai41')
	# => kuài1

    Pinyin.to_numbers('kūàí')
    # => kuai1

It will match all correct pinyin, no matter where it is in the text

	Pinyin.to_numbers("L'été est chaud.")
	# => L'e2te2 e2st chaud.
