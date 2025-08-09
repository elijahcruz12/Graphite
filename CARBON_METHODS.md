# Graphite Methods to Implement for Godot

## Creation

- [ ] `createFromFormat(format: String, time: String, timezone: DateTimeZone | String | int | null = null) -> Graphite`
  * Creates a Graphite instance from a specific format.
  * Example 1: `Graphite.createFromFormat('Y-m-d H:i:s', '2024-01-01 12:30:00')`
  * Example 2: `Graphite.createFromFormat('d/m/Y', '01/01/2024', 'Europe/London')`

- [ ] `nowWithSameTz() -> Graphite`
  * Returns a present instance in the same timezone.
  * Example 1: `$date->nowWithSameTz()`
  * Example 2: `Graphite.now().timezone('America/New_York').nowWithSameTz()`

- [ ] `carbonize(date: mixed | null = null) -> Graphite`
  * Return the Graphite instance passed through, a now instance in the same timezone if null given or parse the input if string given.
  * Example 1: `Graphite.carbonize('2024-01-01')`
  * Example 2: `Graphite.carbonize(new DateTime())`

- [x] `copy() -> Carbon`
  * Get a copy of the instance.
  * Example 1: `$date->copy()`
  * Example 2: `Carbon::now()->copy()`

- [x] `clone() -> Carbon`
  * Get a copy of the instance.
  * Example 1: `$date->clone()`
  * Example 2: `Carbon::now()->clone()`

- [x] `now() -> Carbon`
  * Get a Carbon instance for the current time.
  * Example 1: `Carbon::now()`
  * Example 2: `Carbon::now('America/New_York')`

- [x] `today() -> Carbon`
  * Create a Carbon instance for today.
  * Example 1: `Carbon::today()`
  * Example 2: `Carbon::today('America/New_York')`

- [x] `tomorrow() -> Carbon`
  * Create a Carbon instance for tomorrow.
  * Example 1: `Carbon::tomorrow()`
  * Example 2: `Carbon::tomorrow('America/New_York')`

- [x] `yesterday() -> Carbon`
  * Create a Carbon instance for yesterday.
  * Example 1: `Carbon::yesterday()`
  * Example 2: `Carbon::yesterday('America/New_York')`

## Manipulation

- [x] `add(unit: String, value: int = 1, overflow: bool | null = null) -> Carbon`
  * Add given units or interval to the current instance.
  * Example 1: `$date->add('hour', 3)`
  * Example 2: `$date->add(15, 'days')`

- [x] `sub(unit: String, value: int = 1, overflow: bool | null = null) -> Carbon`
  * Subtract given units or interval from the current instance.
  * Example 1: `$date->sub('hour', 3)`
  * Example 2: `$date->sub(15, 'days')`

- [x] `setTime(hour: int, minute: int, second: int = 0, microseconds: int = 0) -> Carbon`
  * Resets the current time of the DateTime object to a different time.
  * Example 1: `$date->setTime(10, 30)`
  * Example 2: `$date->setTime(20, 0, 0)`

- [x] `setDate(year: int, month: int, day: int) -> Carbon`
  * Set the date with gregorian year, month and day numbers.
  * Example 1: `$date->setDate(2025, 1, 1)`
  * Example 2: `$date->setDate(2023, 12, 31)`

- [ ] `setISODate(year: int, week: int, day: int = 1) -> Carbon`
  * Set a date according to the ISO 8601 standard - using weeks and day offsets rather than specific dates.
  * Example 1: `$date->setISODate(2024, 1)`
  * Example 2: `$date->setISODate(2024, 52, 7)`

- [x] `setTimestamp(timestamp: String | int | float) -> Carbon`
  * Set the instance's timestamp.
  * Example 1: `$date->setTimestamp(1672531200)`
  * Example 2: `$date->setTimestamp('1672531200')`

- [x] `setTimezone(timeZone: DateTimeZone | String | int) -> Carbon`
  * Set the instance's timezone from a string or object.
  * Example 1: `$date->setTimezone('UTC')`
  * Example 2: `$date->setTimezone(new DateTimeZone('America/New_York'))`

- [ ] `shiftTimezone(value: DateTimeZone | String) -> Carbon`
  * Set the instance's timezone from a string or object and add/subtract the offset difference.
  * Example 1: `$date->shiftTimezone('America/New_York')`
  * Example 2: `$date->shiftTimezone('Europe/London')`

- [x] `utc() -> Carbon`
  * Set the instance's timezone to UTC.
  * Example 1: `$date->utc()`
  * Example 2: `Carbon::now()->utc()`

- [x] `setDateFrom(date: DateTimeInterface | String) -> Carbon`
  * Set the year, month, and date for this instance to that of the passed instance.
  * Example 1: `$date->setDateFrom('2025-01-01')`
  * Example 2: `$date->setDateFrom(Carbon::now())`

- [x] `setTimeFrom(date: DateTimeInterface | String) -> Carbon`
  * Set the hour, minute, second and microseconds for this instance to that of the passed instance.
  * Example 1: `$date->setTimeFrom('12:30:00')`
  * Example 2: `$date->setTimeFrom(Carbon::now())`

- [x] `setDateTimeFrom(date: DateTimeInterface | String) -> Carbon`
  * Set the date and time for this instance to that of the passed instance.
  * Example 1: `$date->setDateTimeFrom('2025-01-01 12:30:00')`
  * Example 2: `$date->setDateTimeFrom(Carbon::now())`

- [x] `setUnit(unit: String, value: int | float | null) -> Carbon`
  * Set specified unit to new given value.
  * Example 1: `$date->setUnit('year', 2026)`
  * Example 2: `$date->setUnit('hour', 10)`

## Comparison

- [x] `eq(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->eq('2018-07-25 12:45:16')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->eq(Carbon::parse('2018-07-25 12:45:17'))`

- [x] `equalTo(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->equalTo('2018-07-25 12:45:16')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->equalTo('2018-07-25 12:45:17')`

- [x] `ne(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is not equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->ne('2018-07-25 12:45:16')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->ne('2018-07-25 12:45:17')`

- [x] `notEqualTo(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is not equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->notEqualTo('2018-07-25 12:45:16')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->notEqualTo('2018-07-25 12:45:17')`

- [x] `gt(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is greater (after) than another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->gt('2018-07-25 12:45:15')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->gt('2018-07-25 12:45:17')`

- [x] `greaterThan(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is greater (after) than another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->greaterThan('2018-07-25 12:45:15')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->greaterThan('2018-07-25 12:45:17')`

- [x] `isAfter(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is greater (after) than another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->isAfter('2018-07-25 12:45:15')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->isAfter('2018-07-25 12:45:17')`

- [x] `gte(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is greater (after) than or equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->gte('2018-07-25 12:45:15')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->gte('2018-07-25 12:45:16')`

- [x] `greaterThanOrEqualTo(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is greater (after) than or equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->greaterThanOrEqualTo('2018-07-25 12:45:15')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->greaterThanOrEqualTo('2018-07-25 12:45:16')`

- [x] `lt(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is less (before) than another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->lt('2018-07-25 12:45:17')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->lt('2018-07-25 12:45:15')`

- [x] `lessThan(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is less (before) than another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->lessThan('2018-07-25 12:45:17')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->lessThan('2018-07-25 12:45:15')`

- [x] `isBefore(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is less (before) than another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->isBefore('2018-07-25 12:45:17')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->isBefore('2018-07-25 12:45:15')`

- [x] `lte(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is less (before) or equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->lte('2018-07-25 12:45:17')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->lte('2018-07-25 12:45:16')`

- [x] `lessThanOrEqualTo(date: DateTimeInterface | String) -> bool`
  * Determines if the instance is less (before) or equal to another.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->lessThanOrEqualTo('2018-07-25 12:45:17')`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->lessThanOrEqualTo('2018-07-25 12:45:16')`

- [ ] `between(date1: DateTimeInterface | String, date2: DateTimeInterface | String, equal: bool = true) -> bool`
  * Determines if the instance is between two others.
  * Example 1: `Carbon::parse('2018-07-25')->between('2018-07-14', '2018-08-01')`
  * Example 2: `Carbon::parse('2018-07-25')->between('2018-07-25', '2018-08-01', false)`

- [ ] `betweenIncluded(date1: DateTimeInterface | String, date2: DateTimeInterface | String) -> bool`
  * Determines if the instance is between two others, bounds included.
  * Example 1: `Carbon::parse('2018-07-25')->betweenIncluded('2018-07-14', '2018-08-01')`
  * Example 2: `Carbon::parse('2018-07-25')->betweenIncluded('2018-07-25', '2018-08-01')`

- [ ] `betweenExcluded(date1: DateTimeInterface | String, date2: DateTimeInterface | String) -> bool`
  * Determines if the instance is between two others, bounds excluded.
  * Example 1: `Carbon::parse('2018-07-25')->betweenExcluded('2018-07-14', '2018-08-01')`
  * Example 2: `Carbon::parse('2018-07-25')->betweenExcluded('2018-07-25', '2018-08-01')`

- [ ] `isBetween(date1: DateTimeInterface | String, date2: DateTimeInterface | String, equal: bool = true) -> bool`
  * Determines if the instance is between two others.
  * Example 1: `Carbon::parse('2018-07-25')->isBetween('2018-07-14', '2018-08-01')`
  * Example 2: `Carbon::parse('2018-07-25')->isBetween('2018-07-25', '2018-08-01', false)`

## Difference

- [ ] `diff(date: DateTimeInterface | null = null, absolute: bool = false, skip: array = []) -> CarbonInterval`
  * Get the difference as a DateInterval instance.
  * Example 1: `Carbon::now()->diff(Carbon::now()->addHour())`
  * Example 2: `Carbon::now()->diff(Carbon::now()->subDay(), true)`

## Human Readable

- [ ] `diffForHumans(other: DateTimeInterface | String | null = null, absolute: bool = false, short: bool = false, parts: int = 1, options: int = 0) -> String`
  * Get the difference in a human readable format.
  * Example 1: `Carbon::now()->subDays(2)->diffForHumans()`
  * Example 2: `Carbon::now()->addHours(2)->diffForHumans(Carbon::now())`

- [ ] `diffInYears(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in years.
  * Example 1: `Carbon::parse('2010-01-01')->diffInYears()`
  * Example 2: `Carbon::parse('2010-01-01')->diffInYears(Carbon::parse('2020-01-01'))`

- [ ] `diffInMonths(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in months.
  * Example 1: `Carbon::parse('2020-01-01')->diffInMonths()`
  * Example 2: `Carbon::parse('2020-01-01')->diffInMonths(Carbon::parse('2020-06-01'))`

- [ ] `diffInWeeks(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in weeks.
  * Example 1: `Carbon::parse('2020-01-01')->diffInWeeks()`
  * Example 2: `Carbon::parse('2020-01-01')->diffInWeeks(Carbon::parse('2020-02-01'))`

- [ ] `diffInDays(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in days.
  * Example 1: `Carbon::parse('2020-01-01')->diffInDays()`
  * Example 2: `Carbon::parse('2020-01-01')->diffInDays(Carbon::parse('2020-01-15'))`

- [ ] `diffInDaysFiltered(callback: callable, date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in days using a filter.
  * Example 1: `Carbon::parse('2020-01-01')->diffInDaysFiltered(function($date) { return $date->isWeekday(); })`
  * Example 2: `Carbon::parse('2020-01-01')->diffInDaysFiltered(function($date) { return !$date->isWeekend(); }, Carbon::parse('2020-01-15'))`

- [ ] `diffInWeekdays(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in weekdays.
  * Example 1: `Carbon::parse('2020-01-01')->diffInWeekdays()`
  * Example 2: `Carbon::parse('2020-01-01')->diffInWeekdays(Carbon::parse('2020-01-15'))`

- [ ] `diffInWeekendDays(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in weekend days.
  * Example 1: `Carbon::parse('2020-01-01')->diffInWeekendDays()`
  * Example 2: `Carbon::parse('2020-01-01')->diffInWeekendDays(Carbon::parse('2020-01-15'))`

- [ ] `diffInHours(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in hours.
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInHours()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00')->diffInHours(Carbon::parse('2020-01-01 15:00:00'))`

- [ ] `diffInRealHours(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in real hours (ignoring DST).
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInRealHours()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00')->diffInRealHours(Carbon::parse('2020-01-01 15:00:00'))`

- [ ] `diffInMinutes(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in minutes.
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInMinutes()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00')->diffInMinutes(Carbon::parse('2020-01-01 10:30:00'))`

- [ ] `diffInRealMinutes(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in real minutes (ignoring DST).
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInRealMinutes()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00')->diffInRealMinutes(Carbon::parse('2020-01-01 10:30:00'))`

- [ ] `diffInSeconds(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in seconds.
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInSeconds()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00')->diffInSeconds(Carbon::parse('2020-01-01 10:00:30'))`

- [ ] `diffInRealSeconds(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in real seconds (ignoring DST).
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInRealSeconds()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00')->diffInRealSeconds(Carbon::parse('2020-01-01 10:00:30'))`

- [ ] `diffInMilliseconds(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in milliseconds.
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInMilliseconds()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00.000')->diffInMilliseconds(Carbon::parse('2020-01-01 10:00:00.500'))`

- [ ] `diffInMicroseconds(date: DateTimeInterface | String | null = null, absolute: bool = true) -> int`
  * Get the difference in microseconds.
  * Example 1: `Carbon::parse('2020-01-01 10:00:00')->diffInMicroseconds()`
  * Example 2: `Carbon::parse('2020-01-01 10:00:00.000000')->diffInMicroseconds(Carbon::parse('2020-01-01 10:00:00.000500'))`

- [ ] `secondsSinceMidnight() -> int`
  * The number of seconds since midnight.
  * Example 1: `Carbon::parse('2020-01-01 15:30:45')->secondsSinceMidnight()`
  * Example 2: `Carbon::now()->secondsSinceMidnight()`

- [ ] `secondsUntilEndOfDay() -> int`
  * The number of seconds until 23:59:59.
  * Example 1: `Carbon::parse('2020-01-01 15:30:45')->secondsUntilEndOfDay()`
  * Example 2: `Carbon::now()->secondsUntilEndOfDay()`

- [ ] `diffAsCarbonInterval(date: DateTimeInterface | String | null = null, absolute: bool = true) -> CarbonInterval`
  * Get the difference as a CarbonInterval instance.
  * Example 1: `Carbon::parse('2020-01-01')->diffAsCarbonInterval()`
  * Example 2: `Carbon::parse('2020-01-01')->diffAsCarbonInterval(Carbon::parse('2020-01-15'))`

- [ ] `longAbsoluteDiffForHumans(other: DateTimeInterface | String | null = null, parts: int = 2) -> String`
  * Get the difference in a long human readable format.
  * Example 1: `Carbon::now()->subDays(2)->subHours(3)->longAbsoluteDiffForHumans()`
  * Example 2: `Carbon::now()->addYears(1)->addMonths(2)->longAbsoluteDiffForHumans(Carbon::now())`

- [ ] `longRelativeDiffForHumans(other: DateTimeInterface | String | null = null, parts: int = 2) -> String`
  * Get the difference in a long relative human readable format.
  * Example 1: `Carbon::now()->subDays(2)->subHours(3)->longRelativeDiffForHumans()`
  * Example 2: `Carbon::now()->addYears(1)->addMonths(2)->longRelativeDiffForHumans(Carbon::now())`

- [ ] `shortAbsoluteDiffForHumans(other: DateTimeInterface | String | null = null, parts: int = 1) -> String`
  * Get the difference in a short absolute human readable format.
  * Example 1: `Carbon::now()->subDays(2)->shortAbsoluteDiffForHumans()`
  * Example 2: `Carbon::now()->addHours(3)->shortAbsoluteDiffForHumans(Carbon::now())`

- [ ] `shortRelativeDiffForHumans(other: DateTimeInterface | String | null = null, parts: int = 1) -> String`
  * Get the difference in a short relative human readable format.
  * Example 1: `Carbon::now()->subDays(2)->shortRelativeDiffForHumans()`
  * Example 2: `Carbon::now()->addHours(3)->shortRelativeDiffForHumans(Carbon::now())`

## Formatting

- [x] `format(format: String) -> String`
  * Returns the formatted date string.
  * Example 1: `Carbon::now()->format('Y-m-d')`
  * Example 2: `Carbon::now()->format('l jS \of F Y h:i:s A')`

- [x] `toDateTimeString() -> String`
  * Format the instance as a datetime string.
  * Example 1: `Carbon::now()->toDateTimeString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toDateTimeString()`

- [x] `toDateString() -> String`
  * Format the instance as a date string.
  * Example 1: `Carbon::now()->toDateString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toDateString()`

- [x] `toTimeString() -> String`
  * Format the instance as a time string.
  * Example 1: `Carbon::now()->toTimeString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toTimeString()`

- [x] `toFormattedDateString() -> String`
  * Format the instance as a readable date string.
  * Example 1: `Carbon::now()->toFormattedDateString()`
  * Example 2: `Carbon::create(2024, 1, 1)->toFormattedDateString()`

- [x] `toDayDateTimeString() -> String`
  * Format the instance as a readable day, date and time string.
  * Example 1: `Carbon::now()->toDayDateTimeString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toDayDateTimeString()`

- [x] `toAtomString() -> String`
  * Format the instance as an ATOM string.
  * Example 1: `Carbon::now()->toAtomString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toAtomString()`

- [x] `toCookieString() -> String`
  * Format the instance as a cookie string.
  * Example 1: `Carbon::now()->toCookieString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toCookieString()`

- [x] `toIso8601String() -> String`
  * Format the instance as an ISO 8601 string.
  * Example 1: `Carbon::now()->toIso8601String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toIso8601String()`

- [x] `toIso8601ZuluString() -> String`
  * Format the instance as an ISO 8601 string in UTC timezone.
  * Example 1: `Carbon::now()->toIso8601ZuluString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toIso8601ZuluString()`

- [x] `toRfc822String() -> String`
  * Format the instance as an RFC 822 string.
  * Example 1: `Carbon::now()->toRfc822String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRfc822String()`

- [x] `toRfc850String() -> String`
  * Format the instance as an RFC 850 string.
  * Example 1: `Carbon::now()->toRfc850String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRfc850String()`

- [x] `toRfc1036String() -> String`
  * Format the instance as an RFC 1036 string.
  * Example 1: `Carbon::now()->toRfc1036String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRfc1036String()`

- [x] `toRfc1123String() -> String`
  * Format the instance as an RFC 1123 string.
  * Example 1: `Carbon::now()->toRfc1123String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRfc1123String()`

- [x] `toRfc2822String() -> String`
  * Format the instance as an RFC 2822 string.
  * Example 1: `Carbon::now()->toRfc2822String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRfc2822String()`

- [x] `toRfc3339String() -> String`
  * Format the instance as an RFC 3339 string.
  * Example 1: `Carbon::now()->toRfc3339String()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRfc3339String()`

- [x] `toRssString() -> String`
  * Format the instance as an RSS string.
  * Example 1: `Carbon::now()->toRssString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toRssString()`

- [x] `toW3cString() -> String`
  * Format the instance as a W3C string.
  * Example 1: `Carbon::now()->toW3cString()`
  * Example 2: `Carbon::create(2024, 1, 1, 12, 30, 0)->toW3cString()`

## Modifiers

- [x] `startOfDay() -> Carbon`
  * Resets the time to 00:00:00 start of day.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfDay()`
  * Example 2: `Carbon::now()->startOfDay()`

- [x] `endOfDay() -> Carbon`
  * Resets the time to 23:59:59.999999 end of day.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfDay()`
  * Example 2: `Carbon::now()->endOfDay()`

- [x] `startOfMonth() -> Carbon`
  * Resets the date to the first day of the month and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfMonth()`
  * Example 2: `Carbon::now()->startOfMonth()`

- [x] `endOfMonth() -> Carbon`
  * Resets the date to end of the month and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfMonth()`
  * Example 2: `Carbon::now()->endOfMonth()`

- [ ] `startOfQuarter() -> Carbon`
  * Resets the date to the first day of the quarter and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfQuarter()`
  * Example 2: `Carbon::now()->startOfQuarter()`

- [ ] `endOfQuarter() -> Carbon`
  * Resets the date to end of the quarter and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfQuarter()`
  * Example 2: `Carbon::now()->endOfQuarter()`

- [x] `startOfYear() -> Carbon`
  * Resets the date to the first day of the year and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfYear()`
  * Example 2: `Carbon::now()->startOfYear()`

- [x] `endOfYear() -> Carbon`
  * Resets the date to end of the year and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfYear()`
  * Example 2: `Carbon::now()->endOfYear()`

- [ ] `startOfDecade() -> Carbon`
  * Resets the date to the first day of the decade and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfDecade()`
  * Example 2: `Carbon::now()->startOfDecade()`

- [ ] `endOfDecade() -> Carbon`
  * Resets the date to end of the decade and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfDecade()`
  * Example 2: `Carbon::now()->endOfDecade()`

- [ ] `startOfCentury() -> Carbon`
  * Resets the date to the first day of the century and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfCentury()`
  * Example 2: `Carbon::now()->startOfCentury()`

- [ ] `endOfCentury() -> Carbon`
  * Resets the date to end of the century and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfCentury()`
  * Example 2: `Carbon::now()->endOfCentury()`

- [ ] `startOfMillennium() -> Carbon`
  * Resets the date to the first day of the millennium and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfMillennium()`
  * Example 2: `Carbon::now()->startOfMillennium()`

- [ ] `endOfMillennium() -> Carbon`
  * Resets the date to end of the millennium and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfMillennium()`
  * Example 2: `Carbon::now()->endOfMillennium()`

- [x] `startOfWeek(weekStartsAt: int | null = null) -> Carbon`
  * Resets the date to the first day of week and the time to 00:00:00.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfWeek()`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->startOfWeek(Carbon::SUNDAY)`

- [x] `endOfWeek(weekEndsAt: int | null = null) -> Carbon`
  * Resets the date to end of week and time to 23:59:59.999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfWeek()`
  * Example 2: `Carbon::parse('2018-07-25 12:45:16')->endOfWeek(Carbon::SATURDAY)`

- [x] `startOfHour() -> Carbon`
  * Modify to start of current hour, minutes and seconds become 0.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfHour()`
  * Example 2: `Carbon::now()->startOfHour()`

- [x] `endOfHour() -> Carbon`
  * Modify to end of current hour, minutes and seconds become 59.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfHour()`
  * Example 2: `Carbon::now()->endOfHour()`

- [x] `startOfMinute() -> Carbon`
  * Modify to start of current minute, seconds become 0.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->startOfMinute()`
  * Example 2: `Carbon::now()->startOfMinute()`

- [x] `endOfMinute() -> Carbon`
  * Modify to end of current minute, seconds become 59.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16')->endOfMinute()`
  * Example 2: `Carbon::now()->endOfMinute()`

- [ ] `startOfSecond() -> Carbon`
  * Modify to start of current second, microseconds become 0.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16.334455')->startOfSecond()`
  * Example 2: `Carbon::now()->startOfSecond()`

- [ ] `endOfSecond() -> Carbon`
  * Modify to end of current second, microseconds become 999999.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16.334455')->endOfSecond()`
  * Example 2: `Carbon::now()->endOfSecond()`

- [x] `startOf(unit: String, params: mixed) -> Carbon`
  * Modify to start of current given unit.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16.334455')->startOf('month')`
  * Example 2: `Carbon::now()->startOf('week', Carbon::FRIDAY)`

- [x] `endOf(unit: String, params: mixed) -> Carbon`
  * Modify to end of current given unit.
  * Example 1: `Carbon::parse('2018-07-25 12:45:16.334455')->endOf('month')`
  * Example 2: `Carbon::now()->endOf('week', Carbon::FRIDAY)`

## Queries

- [x] `isWeekday() -> bool`
  * Determines if the instance is a weekday.
  * Example 1: `Carbon::parse('2019-07-14')->isWeekday()`
  * Example 2: `Carbon::parse('2019-07-15')->isWeekday()`

- [x] `isWeekend() -> bool`
  * Determines if the instance is a weekend day.
  * Example 1: `Carbon::parse('2019-07-14')->isWeekend()`
  * Example 2: `Carbon::parse('2019-07-15')->isWeekend()`

- [x] `isYesterday() -> bool`
  * Determines if the instance is yesterday.
  * Example 1: `Carbon::yesterday()->isYesterday()`
  * Example 2: `Carbon::tomorrow()->isYesterday()`

- [x] `isToday() -> bool`
  * Determines if the instance is today.
  * Example 1: `Carbon::today()->isToday()`
  * Example 2: `Carbon::tomorrow()->isToday()`

- [x] `isTomorrow() -> bool`
  * Determines if the instance is tomorrow.
  * Example 1: `Carbon::tomorrow()->isTomorrow()`
  * Example 2: `Carbon::yesterday()->isTomorrow()`

- [x] `isFuture() -> bool`
  * Determines if the instance is in the future, ie. greater (after) than now.
  * Example 1: `Carbon::now()->addHours(5)->isFuture()`
  * Example 2: `Carbon::now()->subHours(5)->isFuture()`

- [x] `isPast() -> bool`
  * Determines if the instance is in the past, ie. less (before) than now.
  * Example 1: `Carbon::now()->subHours(5)->isPast()`
  * Example 2: `Carbon::now()->addHours(5)->isPast()`

- [x] `isLeapYear() -> bool`
  * Determines if the instance is a leap year.
  * Example 1: `Carbon::parse('2020-01-01')->isLeapYear()`
  * Example 2: `Carbon::parse('2019-01-01')->isLeapYear()`

- [ ] `isLongYear() -> bool`
  * Determines if the instance is a long year (using calendar year).
  * Example 1: `Carbon::create(2015)->isLongYear()`
  * Example 2: `Carbon::create(2016)->isLongYear()`

- [ ] `isSameAs(format: String, date: DateTimeInterface | String) -> bool`
  * Compares the formatted values of the two dates.
  * Example 1: `Carbon::parse('2019-06-13')->isSameAs('Y-d', Carbon::parse('2019-12-13'))`
  * Example 2: `Carbon::parse('2019-06-13')->isSameAs('Y-m', Carbon::parse('2019-06-14'))`

- [ ] `isSameUnit(unit: String, date: DateTimeInterface | String) -> bool`
  * Determines if the instance is in the current unit given.
  * Example 1: `Carbon::parse('2019-01-13')->isSameUnit('year', Carbon::parse('2019-12-25'))`
  * Example 2: `Carbon::parse('2018-12-13')->isSameUnit('year', Carbon::parse('2019-12-25'))`

- [ ] `isCurrentUnit(unit: String) -> bool`
  * Determines if the instance is in the current unit given.
  * Example 1: `Carbon::now()->isCurrentUnit('hour')`
  * Example 2: `Carbon::now()->subHours(2)->isCurrentUnit('hour')`

- [ ] `isSameQuarter(date: DateTimeInterface | String, ofSameYear: bool = true) -> bool`
  * Checks if the passed in date is in the same quarter as the instance quarter (and year if needed).
  * Example 1: `Carbon::parse('2019-01-12')->isSameQuarter(Carbon::parse('2019-03-01'))`
  * Example 2: `Carbon::parse('2019-01-12')->isSameQuarter(Carbon::parse('2019-04-01'))`

- [x] `isSameMonth(date: DateTimeInterface | String, ofSameYear: bool = true) -> bool`
  * Checks if the passed in date is in the same month as the instance´s month.
  * Example 1: `Carbon::parse('2019-01-12')->isSameMonth(Carbon::parse('2019-01-01'))`
  * Example 2: `Carbon::parse('2019-01-12')->isSameMonth(Carbon::parse('2019-02-01'))`

- [x] `isDayOfWeek(dayOfWeek: int | String) -> bool`
  * Checks if this day is a specific day of the week.
  * Example 1: `Carbon::parse('2019-07-17')->isDayOfWeek(Carbon::WEDNESDAY)`
  * Example 2: `Carbon::parse('2019-07-17')->isDayOfWeek('Wednesday')`

- [x] `isBirthday(date: DateTimeInterface | String | null = null) -> bool`
  * Check if its the birthday. Compares the date/month values of the two dates.
  * Example 1: `Carbon::now()->subYears(5)->isBirthday()`
  * Example 2: `Carbon::parse('2019-06-05')->isBirthday(Carbon::parse('2001-06-05'))`

- [x] `isLastOfMonth() -> bool`
  * Check if today is the last day of the Month.
  * Example 1: `Carbon::parse('2019-02-28')->isLastOfMonth()`
  * Example 2: `Carbon::parse('2019-03-30')->isLastOfMonth()`

- [x] `isStartOfDay(checkMicroseconds: bool = false) -> bool`
  * Check if the instance is start of day / midnight.
  * Example 1: `Carbon::parse('2019-02-28 00:00:00')->isStartOfDay()`
  * Example 2: `Carbon::parse('2019-02-28 00:00:00.000000')->isStartOfDay(true)`

- [x] `isEndOfDay(checkMicroseconds: bool = false) -> bool`
  * Check if the instance is end of day.
  * Example 1: `Carbon::parse('2019-02-28 23:59:59')->isEndOfDay()`
  * Example 2: `Carbon::parse('2019-02-28 23:59:59.999999')->isEndOfDay(true)`

## Translation

- [ ] `getTranslatedDayName(context: String | null = null, keySuffix: String = '', defaultValue: String | null = null) -> String`
  * Get the translation of the current week day name.
  * Example 1: `Carbon::now()->getTranslatedDayName()`
  * Example 2: `Carbon::now()->locale('fr')->getTranslatedDayName()`

- [ ] `getTranslatedShortDayName(context: String | null = null) -> String`
  * Get the translation of the current short week day name.
  * Example 1: `Carbon::now()->getTranslatedShortDayName()`
  * Example 2: `Carbon::now()->locale('fr')->getTranslatedShortDayName()`

- [ ] `getTranslatedMinDayName(context: String | null = null) -> String`
  * Get the translation of the current abbreviated week day name.
  * Example 1: `Carbon::now()->getTranslatedMinDayName()`
  * Example 2: `Carbon::now()->locale('fr')->getTranslatedMinDayName()`

- [ ] `getTranslatedMonthName(context: String | null = null, keySuffix: String = '', defaultValue: String | null = null) -> String`
  * Get the translation of the current month day name.
  * Example 1: `Carbon::now()->getTranslatedMonthName()`
  * Example 2: `Carbon::now()->locale('fr')->getTranslatedMonthName()`

- [ ] `getTranslatedShortMonthName(context: String | null = null) -> String`
  * Get the translation of the current short month day name.
  * Example 1: `Carbon::now()->getTranslatedShortMonthName()`
  * Example 2: `Carbon::now()->locale('fr')->getTranslatedShortMonthName()`

- [ ] `isoFormat(format: String, originalFormat: String | null = null) -> String`
  * Format in the current language using ISO replacement patterns.
  * Example 1: `Carbon::now()->isoFormat('LLLL')`
  * Example 2: `Carbon::now()->locale('fr')->isoFormat('LLLL')`

- [ ] `translatedFormat(format: String) -> String`
  * Format as ->format() do but translate words whenever possible using the current locale.
  * Example 1: `Carbon::now()->translatedFormat('l, F j, Y g:i A')`
  * Example 2: `Carbon::now()->locale('fr')->translatedFormat('l, F j, Y g:i A')`