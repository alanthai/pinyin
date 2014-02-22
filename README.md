Pinyin
======
Converts pinyin tones from numbers to diacritics (accents)

Converts a string with tones from numbers (e.g., "pin1yin1") to diacritics
(e.g., "pīnyīn"), and vice versa

## Examples

    Pinyin.to_accents('huan1ying2 guan1lin2!')
    # => "huānyíng guānlín!"

    Pinyin.to_numbers('huānyíng guānlín!')
    # => "huan1ying2 guan1lin2!"
