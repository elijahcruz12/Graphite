class_name GraphiteInterface
extends RefCounted

## Diff wording options (expressed in octal).
const NO_ZERO_DIFF = 1
const JUST_NOW = 2
const ONE_DAY_WORDS = 4
const TWO_DAY_WORDS = 8
const SEQUENTIAL_PARTS_ONLY = 16
const ROUND = 32
const FLOOR = 64
const CEIL = 128

## Diff syntax options.
const DIFF_ABSOLUTE = 1  # backward compatibility with true
const DIFF_RELATIVE_AUTO = 0  # backward compatibility with false
const DIFF_RELATIVE_TO_NOW = 2
const DIFF_RELATIVE_TO_OTHER = 3

## Translate string options.
const TRANSLATE_MONTHS = 1
const TRANSLATE_DAYS = 2
const TRANSLATE_UNITS = 4
const TRANSLATE_MERIDIEM = 8
const TRANSLATE_DIFF = 0x10
const TRANSLATE_ALL = TRANSLATE_MONTHS | TRANSLATE_DAYS | TRANSLATE_UNITS | TRANSLATE_MERIDIEM | TRANSLATE_DIFF

## The day constants.
const SUNDAY = 0
const MONDAY = 1
const TUESDAY = 2
const WEDNESDAY = 3
const THURSDAY = 4
const FRIDAY = 5
const SATURDAY = 6

## The month constants.
## These aren't used by Graphite itself but exist for convenience sake alone.
const JANUARY = 1
const FEBRUARY = 2
const MARCH = 3
const APRIL = 4
const MAY = 5
const JUNE = 6
const JULY = 7
const AUGUST = 8
const SEPTEMBER = 9
const OCTOBER = 10
const NOVEMBER = 11
const DECEMBER = 12

## Number of X in Y.
const YEARS_PER_MILLENNIUM = 1000
const YEARS_PER_CENTURY = 100
const YEARS_PER_DECADE = 10
const MONTHS_PER_YEAR = 12
const MONTHS_PER_QUARTER = 3
const QUARTERS_PER_YEAR = 4
const WEEKS_PER_YEAR = 52
const WEEKS_PER_MONTH = 4
const DAYS_PER_YEAR = 365
const DAYS_PER_WEEK = 7
const HOURS_PER_DAY = 24
const MINUTES_PER_HOUR = 60
const SECONDS_PER_MINUTE = 60
const MILLISECONDS_PER_SECOND = 1000
const MICROSECONDS_PER_MILLISECOND = 1000
const MICROSECONDS_PER_SECOND = 1000000

## Special settings to get the start of week from current locale culture.
const WEEK_DAY_AUTO = 'auto'

## RFC7231 DateTime format.
const RFC7231_FORMAT = 'D, d M Y H:i:s \\G\\M\\T'

## Default format to use for __toString method when type juggling occurs.
const DEFAULT_TO_STRING_FORMAT = 'Y-m-d H:i:s'

## Format for converting mocked time, includes microseconds.
const MOCK_DATETIME_FORMAT = 'Y-m-d H:i:s.u'

## Pattern detection for ->isoFormat and ::createFromIsoFormat.
const ISO_FORMAT_REGEXP = '(O[YMDHhms]|[Hh]mm(ss)?|Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|Qo?|YYYYYY|YYYYY|YYYY|YY?|g{1,5}|G{1,5}|e|E|a|A|hh?|HH?|kk?|mm?|ss?|S{1,9}|x|X|zz?|ZZ?)'

## Default locale (language and region).
const DEFAULT_LOCALE = 'en'
