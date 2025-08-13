class_name Graphite
extends RefCounted


var _datetime: Dictionary
var _timezone: Dictionary


func _init(datetime_dict: Dictionary = {}, timezone_dict: Dictionary = {}):
	if datetime_dict.is_empty():
		_datetime = Time.get_datetime_dict_from_system()
	else:
		_datetime = datetime_dict
	
	# We also get/store the timezone.
	if timezone_dict.is_empty():
		_timezone = Time.get_time_zone_from_system()
	else:
		_timezone = timezone_dict


### Static Init ###

## Allows you to get the current [code]datetime[/code].
static func now(timezone_dict: Dictionary = {}) -> Graphite:
	return Graphite.new({}, timezone_dict)

## Creates a new Graphite instance from the given dictionaries.
static func from_dict(datetime_dict: Dictionary, timezone_dict: Dictionary) -> Graphite:
	return Graphite.new(datetime_dict, timezone_dict)

## Creates a new Graphite instance of the start of today.
static func today(timezone_dict: Dictionary = {}) -> Graphite:
	var start_of_today = Time.get_datetime_dict_from_system()
	start_of_today.hour = 0
	start_of_today.minute = 0
	start_of_today.second = 0
	return Graphite.new(start_of_today, timezone_dict)

## Creates a new Graphite instance of the start of tomorrow.
static func tomorrow(timezone_dict: Dictionary = {}) -> Graphite:
	var start_of_tomorrow = Time.get_datetime_dict_from_system()
	start_of_tomorrow.day += 1
	start_of_tomorrow.hour = 0
	start_of_tomorrow.minute = 0
	start_of_tomorrow.second = 0
	return Graphite.new(start_of_tomorrow, timezone_dict)

## Creates a new Graphite instance of the start of yesterday
static func yesterday(timezone_dict: Dictionary = {}) -> Graphite:
	var start_of_yesterday = Time.get_datetime_dict_from_system()
	start_of_yesterday.day -= 1
	start_of_yesterday.hour = 0
	start_of_yesterday.minute = 0
	start_of_yesterday.second = 0
	return Graphite.new(start_of_yesterday, timezone_dict)

### Math ###

## Adds the specified [param amount] of time to the Graphite instance.
## Requires a [param unit] of measurement, such as [code]seconds[/code], [code]minutes[/code],
## or [code]hours[/code]. Defaults to [i]seconds[/i].
## [br] The [param unit] is plural.
## [br] Returns Graphite
func add(amount: int, unit: String = "seconds") -> Graphite:
	return GraphiteMath.add(self, amount, unit)

## Subtracts the specified [param amount] of time from the Graphite instance.
## Requires a [param unit] of measurement, such as [code]seconds[/code], [code]minutes[/code],
## or [code]hours[/code]. Defaults to [i]seconds[/i].
## [br] The [param unit] is plural.
## [br] Returns Graphite
func sub(amount: int, unit: String = "seconds") -> Graphite:
	return GraphiteMath.sub(self, amount, unit)

### Addition Functions (Plural) ###

## Adds the specified amount of microseconds to the instance.
## [br] Returns Graphite
func addMicroseconds(amount: int) -> Graphite:
	return GraphiteMath.addMicroseconds(self, amount)

## Adds the specified amount of milliseconds to the instance.
## [br] Returns Graphite
func addMilliseconds(amount: int) -> Graphite:
	return GraphiteMath.addMilliseconds(self, amount)

## Adds the specified amount of seconds to the instance.
## [br] Returns Graphite
func addSeconds(amount: int) -> Graphite:
	return GraphiteMath.addSeconds(self, amount)

## Adds the specified amount of minutes to the instance.
## [br] Returns Graphite
func addMinutes(amount: int) -> Graphite:
	return GraphiteMath.addMinutes(self, amount)

## Adds the specified amount of hours to the instance.
## [br] Returns Graphite
func addHours(amount: int) -> Graphite:
	return GraphiteMath.addHours(self, amount)

## Adds the specified amount of days to the instance.
## [br] Returns Graphite
func addDays(amount: int) -> Graphite:
	return GraphiteMath.addDays(self, amount)

## Adds the specified amount of weeks to the instance.
## [br] Returns Graphite
func addWeeks(amount: int) -> Graphite:
	return GraphiteMath.addWeeks(self, amount)

## Adds the specified amount of weekdays (Monday-Friday) to the instance.
## [br] Returns Graphite
func addWeekdays(amount: int) -> Graphite:
	return GraphiteMath.addWeekdays(self, amount)

## Adds the specified amount of months to the instance.
## [br] Returns Graphite
func addMonths(amount: int) -> Graphite:
	return GraphiteMath.addMonths(self, amount)

## Adds the specified amount of quarters to the instance.
## [br] Returns Graphite
func addQuarters(amount: int) -> Graphite:
	return GraphiteMath.addQuarters(self, amount)

## Adds the specified amount of years to the instance.
## [br] Returns Graphite
func addYears(amount: int) -> Graphite:
	return GraphiteMath.addYears(self, amount)

## Adds the specified amount of decades to the instance.
## [br] Returns Graphite
func addDecades(amount: int) -> Graphite:
	return GraphiteMath.addDecades(self, amount)

## Adds the specified amount of centuries to the instance.
## [br] Returns Graphite
func addCenturies(amount: int) -> Graphite:
	return GraphiteMath.addCenturies(self, amount)

## Adds the specified amount of millenniums to the instance.
## [br] Returns Graphite
func addMillenniums(amount: int) -> Graphite:
	return GraphiteMath.addMillenniums(self, amount)

## Adds the specified amount of millennia to the instance.
## [br] Returns Graphite
func addMillennia(amount: int) -> Graphite:
	return GraphiteMath.addMillennia(self, amount)

### Addition Functions (Singular) ###

## Adds one microsecond to the instance.
## [br] Returns Graphite
func addMicrosecond() -> Graphite:
	return GraphiteMath.addMicrosecond(self)

## Adds one millisecond to the instance.
## [br] Returns Graphite
func addMillisecond() -> Graphite:
	return GraphiteMath.addMillisecond(self)

## Adds one second to the instance.
## [br] Returns Graphite
func addSecond() -> Graphite:
	return GraphiteMath.addSecond(self)

## Adds one minute to the instance.
## [br] Returns Graphite
func addMinute() -> Graphite:
	return GraphiteMath.addMinute(self)

## Adds one hour to the instance.
## [br] Returns Graphite
func addHour() -> Graphite:
	return GraphiteMath.addHour(self)

## Adds one day to the instance.
## [br] Returns Graphite
func addDay() -> Graphite:
	return GraphiteMath.addDay(self)

## Adds one week to the instance.
## [br] Returns Graphite
func addWeek() -> Graphite:
	return GraphiteMath.addWeek(self)

## Adds one weekday (Monday-Friday) to the instance.
## [br] Returns Graphite
func addWeekday() -> Graphite:
	return GraphiteMath.addWeekday(self)

## Adds one month to the instance.
## [br] Returns Graphite
func addMonth() -> Graphite:
	return GraphiteMath.addMonth(self)

## Adds one quarter to the instance.
## [br] Returns Graphite
func addQuarter() -> Graphite:
	return GraphiteMath.addQuarter(self)

## Adds one year to the instance.
## [br] Returns Graphite
func addYear() -> Graphite:
	return GraphiteMath.addYear(self)

## Adds one decade to the instance.
## [br] Returns Graphite
func addDecade() -> Graphite:
	return GraphiteMath.addDecade(self)

## Adds one century to the instance.
## [br] Returns Graphite
func addCentury() -> Graphite:
	return GraphiteMath.addCentury(self)

## Adds one millennium to the instance.
## [br] Returns Graphite
func addMillennium() -> Graphite:
	return GraphiteMath.addMillennium(self)

### Subtraction Functions (Plural) ###

## Subtracts the specified amount of microseconds from the instance.
## [br] Returns Graphite
func subMicroseconds(amount: int) -> Graphite:
	return GraphiteMath.subMicroseconds(self, amount)

## Subtracts the specified amount of milliseconds from the instance.
## [br] Returns Graphite
func subMilliseconds(amount: int) -> Graphite:
	return GraphiteMath.subMilliseconds(self, amount)

## Subtracts the specified amount of seconds from the instance.
## [br] Returns Graphite
func subSeconds(amount: int) -> Graphite:
	return GraphiteMath.subSeconds(self, amount)

## Subtracts the specified amount of minutes from the instance.
## [br] Returns Graphite
func subMinutes(amount: int) -> Graphite:
	return GraphiteMath.subMinutes(self, amount)

## Subtracts the specified amount of hours from the instance.
## [br] Returns Graphite
func subHours(amount: int) -> Graphite:
	return GraphiteMath.subHours(self, amount)

## Subtracts the specified amount of days from the instance.
## [br] Returns Graphite
func subDays(amount: int) -> Graphite:
	return GraphiteMath.subDays(self, amount)

## Subtracts the specified amount of weeks from the instance.
## [br] Returns Graphite
func subWeeks(amount: int) -> Graphite:
	return GraphiteMath.subWeeks(self, amount)

## Subtracts the specified amount of weekdays (Monday-Friday) from the instance.
## [br] Returns Graphite
func subWeekdays(amount: int) -> Graphite:
	return GraphiteMath.subWeekdays(self, amount)

## Subtracts the specified amount of months from the instance.
## [br] Returns Graphite
func subMonths(amount: int) -> Graphite:
	return GraphiteMath.subMonths(self, amount)

## Subtracts the specified amount of quarters from the instance.
## [br] Returns Graphite
func subQuarters(amount: int) -> Graphite:
	return GraphiteMath.subQuarters(self, amount)

## Subtracts the specified amount of years from the instance.
## [br] Returns Graphite
func subYears(amount: int) -> Graphite:
	return GraphiteMath.subYears(self, amount)

## Subtracts the specified amount of decades from the instance.
## [br] Returns Graphite
func subDecades(amount: int) -> Graphite:
	return GraphiteMath.subDecades(self, amount)

## Subtracts the specified amount of centuries from the instance.
## [br] Returns Graphite
func subCenturies(amount: int) -> Graphite:
	return GraphiteMath.subCenturies(self, amount)

## Subtracts the specified amount of millenniums from the instance.
## [br] Returns Graphite
func subMillenniums(amount: int) -> Graphite:
	return GraphiteMath.subMillenniums(self, amount)

## Subtracts the specified amount of millennia from the instance.
## [br] Returns Graphite
func subMillennia(amount: int) -> Graphite:
	return GraphiteMath.subMillennia(self, amount)

### Subtraction Functions (Singular) ###

## Subtracts one microsecond from the instance.
## [br] Returns Graphite
func subMicrosecond() -> Graphite:
	return GraphiteMath.subMicrosecond(self)

## Subtracts one millisecond from the instance.
## [br] Returns Graphite
func subMillisecond() -> Graphite:
	return GraphiteMath.subMillisecond(self)

## Subtracts one second from the instance.
## [br] Returns Graphite
func subSecond() -> Graphite:
	return GraphiteMath.subSecond(self)

## Subtracts one minute from the instance.
## [br] Returns Graphite
func subMinute() -> Graphite:
	return GraphiteMath.subMinute(self)

## Subtracts one hour from the instance.
## [br] Returns Graphite
func subHour() -> Graphite:
	return GraphiteMath.subHour(self)

## Subtracts one day from the instance.
## [br] Returns Graphite
func subDay() -> Graphite:
	return GraphiteMath.subDay(self)

## Subtracts one week from the instance.
## [br] Returns Graphite
func subWeek() -> Graphite:
	return GraphiteMath.subWeek(self)

## Subtracts one weekday (Monday-Friday) from the instance.
## [br] Returns Graphite
func subWeekday() -> Graphite:
	return GraphiteMath.subWeekday(self)

## Subtracts one month from the instance.
## [br] Returns Graphite
func subMonth() -> Graphite:
	return GraphiteMath.subMonth(self)

## Subtracts one quarter from the instance.
## [br] Returns Graphite
func subQuarter() -> Graphite:
	return GraphiteMath.subQuarter(self)

## Subtracts one year from the instance.
## [br] Returns Graphite
func subYear() -> Graphite:
	return GraphiteMath.subYear(self)

## Subtracts one decade from the instance.
## [br] Returns Graphite
func subDecade() -> Graphite:
	return GraphiteMath.subDecade(self)

## Subtracts one century from the instance.
## [br] Returns Graphite
func subCentury() -> Graphite:
	return GraphiteMath.subCentury(self)

## Subtracts one millennium from the instance.
## [br] Returns Graphite
func subMillennium() -> Graphite:
	return GraphiteMath.subMillennium(self)

### Creation ###

## Get a copy of the instance.
## [br] Returns Graphite
func copy() -> Graphite:
	return GraphiteManipulation.copy(self)

## Get a copy of the instance.
## [br] Returns Graphite
func clone() -> Graphite:
	return GraphiteManipulation.clone(self)

### Manipulation ###

## Resets the current time of the DateTime object to a different time.
## [br] Returns Graphite
func setTime(hour: int, minute: int, second: int = 0, microseconds: int = 0) -> Graphite:
	return GraphiteManipulation.setTime(self, hour, minute, second, microseconds)

## Set the date with gregorian year, month and day numbers.
## [br] Returns Graphite
func setDate(year: int, month: int, day: int) -> Graphite:
	return GraphiteManipulation.setDate(self, year, month, day)

## Set the instance's timestamp.
## [br] Returns Graphite
func setTimestamp(timestamp) -> Graphite:
	return GraphiteManipulation.setTimestamp(self, timestamp)

## Set the instance's timezone from a string or object.
## [br] Returns Graphite
func setTimezone(timeZone) -> Graphite:
	return GraphiteManipulation.setTimezone(self, timeZone)

## Set the instance's timezone to UTC.
## [br] Returns Graphite
func utc() -> Graphite:
	return GraphiteManipulation.utc(self)

## Set the year, month, and date for this instance to that of the passed instance.
## [br] Returns Graphite
func setDateFrom(date) -> Graphite:
	return GraphiteManipulation.setDateFrom(self, date)

## Set the hour, minute, second and microseconds for this instance to that of the passed instance.
## [br] Returns Graphite
func setTimeFrom(date) -> Graphite:
	return GraphiteManipulation.setTimeFrom(self, date)

## Set the date and time for this instance to that of the passed instance.
## [br] Returns Graphite
func setDateTimeFrom(date) -> Graphite:
	return GraphiteManipulation.setDateTimeFrom(self, date)

## Set specified unit to new given value.
## [br] Returns Graphite
func setUnit(unit: String, value) -> Graphite:
	return GraphiteManipulation.setUnit(self, unit, value)

### Formatting ###

## Returns the formatted date string.
## [br] Returns String
func format(format_string: String) -> String:
	return GraphiteFormatting.format(self, format_string)

## Format the instance as a datetime string.
## [br] Returns String
func toDateTimeString() -> String:
	return GraphiteFormatting.toDateTimeString(self)

## Format the instance as a date string.
## [br] Returns String
func toDateString() -> String:
	return GraphiteFormatting.toDateString(self)

## Format the instance as a time string.
## [br] Returns String
func toTimeString() -> String:
	return GraphiteFormatting.toTimeString(self)

## Format the instance as a readable date string.
## [br] Returns String
func toFormattedDateString() -> String:
	return GraphiteFormatting.toFormattedDateString(self)

## Format the instance as a readable day, date and time string.
## [br] Returns String
func toDayDateTimeString() -> String:
	return GraphiteFormatting.toDayDateTimeString(self)

## Format the instance as an ATOM string.
## [br] Returns String
func toAtomString() -> String:
	return GraphiteFormatting.toAtomString(self)

## Format the instance as a cookie string.
## [br] Returns String
func toCookieString() -> String:
	return GraphiteFormatting.toCookieString(self)

## Format the instance as an ISO 8601 string.
## [br] Returns String
func toIso8601String() -> String:
	return GraphiteFormatting.toIso8601String(self)

## Format the instance as an ISO 8601 string in UTC timezone.
## [br] Returns String
func toIso8601ZuluString() -> String:
	return GraphiteFormatting.toIso8601ZuluString(self)

## Format the instance as an RFC 822 string.
## [br] Returns String
func toRfc822String() -> String:
	return GraphiteFormatting.toRfc822String(self)

## Format the instance as an RFC 850 string.
## [br] Returns String
func toRfc850String() -> String:
	return GraphiteFormatting.toRfc850String(self)

## Format the instance as an RFC 1036 string.
## [br] Returns String
func toRfc1036String() -> String:
	return GraphiteFormatting.toRfc1036String(self)

## Format the instance as an RFC 1123 string.
## [br] Returns String
func toRfc1123String() -> String:
	return GraphiteFormatting.toRfc1123String(self)

## Format the instance as an RFC 2822 string.
## [br] Returns String
func toRfc2822String() -> String:
	return GraphiteFormatting.toRfc2822String(self)

## Format the instance as an RFC 3339 string.
## [br] Returns String
func toRfc3339String() -> String:
	return GraphiteFormatting.toRfc3339String(self)

## Format the instance as an RSS string.
## [br] Returns String
func toRssString() -> String:
	return GraphiteFormatting.toRssString(self)

## Format the instance as a W3C string.
## [br] Returns String
func toW3cString() -> String:
	return GraphiteFormatting.toW3cString(self)

### Modifiers ###

## Resets the time to 00:00:00 start of day.
## [br] Returns Graphite
func startOfDay() -> Graphite:
	return GraphiteModifiers.startOfDay(self)

## Resets the time to 23:59:59.999999 end of day.
## [br] Returns Graphite
func endOfDay() -> Graphite:
	return GraphiteModifiers.endOfDay(self)

## Resets the date to the first day of the month and the time to 00:00:00.
## [br] Returns Graphite
func startOfMonth() -> Graphite:
	return GraphiteModifiers.startOfMonth(self)

## Resets the date to end of the month and time to 23:59:59.999999.
## [br] Returns Graphite
func endOfMonth() -> Graphite:
	return GraphiteModifiers.endOfMonth(self)

## Resets the date to the first day of the year and the time to 00:00:00.
## [br] Returns Graphite
func startOfYear() -> Graphite:
	return GraphiteModifiers.startOfYear(self)

## Resets the date to end of the year and time to 23:59:59.999999.
## [br] Returns Graphite
func endOfYear() -> Graphite:
	return GraphiteModifiers.endOfYear(self)

## Resets the date to the first day of week and the time to 00:00:00.
## [br] Returns Graphite
func startOfWeek(weekStartsAt: int = 1) -> Graphite:
	return GraphiteModifiers.startOfWeek(self, weekStartsAt)

## Resets the date to end of week and time to 23:59:59.999999.
## [br] Returns Graphite
func endOfWeek(weekEndsAt: int = 0) -> Graphite:
	return GraphiteModifiers.endOfWeek(self, weekEndsAt)

## Modify to start of current hour, minutes and seconds become 0.
## [br] Returns Graphite
func startOfHour() -> Graphite:
	return GraphiteModifiers.startOfHour(self)

## Modify to end of current hour, minutes and seconds become 59.
## [br] Returns Graphite
func endOfHour() -> Graphite:
	return GraphiteModifiers.endOfHour(self)

## Modify to start of current minute, seconds become 0.
## [br] Returns Graphite
func startOfMinute() -> Graphite:
	return GraphiteModifiers.startOfMinute(self)

## Modify to end of current minute, seconds become 59.
## [br] Returns Graphite
func endOfMinute() -> Graphite:
	return GraphiteModifiers.endOfMinute(self)

## Modify to start of current given unit.
## [br] Returns Graphite
func startOf(unit: String, params = null) -> Graphite:
	return GraphiteModifiers.startOf(self, unit, params)

## Modify to end of current given unit.
## [br] Returns Graphite
func endOf(unit: String, params = null) -> Graphite:
	return GraphiteModifiers.endOf(self, unit, params)

### Queries ###

## Determines if the instance is a weekday.
## [br] Returns bool
func isWeekday() -> bool:
	return GraphiteQueries.isWeekday(self)

## Determines if the instance is a weekend day.
## [br] Returns bool
func isWeekend() -> bool:
	return GraphiteQueries.isWeekend(self)

## Determines if the instance is yesterday.
## [br] Returns bool
func isYesterday() -> bool:
	return GraphiteQueries.isYesterday(self)

## Determines if the instance is today.
## [br] Returns bool
func isToday() -> bool:
	return GraphiteQueries.isToday(self)

## Determines if the instance is tomorrow.
## [br] Returns bool
func isTomorrow() -> bool:
	return GraphiteQueries.isTomorrow(self)

## Determines if the instance is in the future, ie. greater (after) than now.
## [br] Returns bool
func isFuture() -> bool:
	return GraphiteQueries.isFuture(self)

## Determines if the instance is in the past, ie. less (before) than now.
## [br] Returns bool
func isPast() -> bool:
	return GraphiteQueries.isPast(self)

## Determines if the instance is a leap year.
## [br] Returns bool
func isLeapYear() -> bool:
	return GraphiteQueries.isLeapYear(self)

## Checks if the passed in date is in the same month as the instance´s month.
## [br] Returns bool
func isSameMonth(date, ofSameYear: bool = true) -> bool:
	return GraphiteQueries.isSameMonth(self, date, ofSameYear)

## Checks if this day is a specific day of the week.
## [br] Returns bool
func isDayOfWeek(dayOfWeek) -> bool:
	return GraphiteQueries.isDayOfWeek(self, dayOfWeek)

## Check if its the birthday. Compares the date/month values of the two dates.
## [br] Returns bool
func isBirthday(date = null) -> bool:
	return GraphiteQueries.isBirthday(self, date)

## Check if today is the last day of the Month.
## [br] Returns bool
func isLastOfMonth() -> bool:
	return GraphiteQueries.isLastOfMonth(self)

## Check if the instance is start of day / midnight.
## [br] Returns bool
func isStartOfDay(checkMicroseconds: bool = false) -> bool:
	return GraphiteQueries.isStartOfDay(self, checkMicroseconds)

## Check if the instance is end of day.
## [br] Returns bool
func isEndOfDay(checkMicroseconds: bool = false) -> bool:
	return GraphiteQueries.isEndOfDay(self, checkMicroseconds)

### Public accessors ###

### Comparison ###

## Determines if the instance is equal to another.
## [br] Returns bool
func eq(date) -> bool:
	return GraphiteComparison.eq(self, date)

## Determines if the instance is equal to another.
## [br] Returns bool
func equalTo(date) -> bool:
	return eq(date)

## Determines if the instance is not equal to another.
## [br] Returns bool
func ne(date) -> bool:
	return GraphiteComparison.ne(self, date)

## Determines if the instance is not equal to another.
## [br] Returns bool
func notEqualTo(date) -> bool:
	return ne(date)

## Determines if the instance is greater (after) than another.
## [br] Returns bool
func gt(date) -> bool:
	return GraphiteComparison.gt(self, date)

## Determines if the instance is greater (after) than another.
## [br] Returns bool
func greaterThan(date) -> bool:
	return gt(date)

## Determines if the instance is greater (after) than another.
## [br] Returns bool
func isAfter(date) -> bool:
	return gt(date)

## Determines if the instance is greater (after) than or equal to another.
## [br] Returns bool
func gte(date) -> bool:
	return GraphiteComparison.gte(self, date)

## Determines if the instance is greater (after) than or equal to another.
## [br] Returns bool
func greaterThanOrEqualTo(date) -> bool:
	return gte(date)

## Determines if the instance is less (before) than another.
## [br] Returns bool
func lt(date) -> bool:
	return GraphiteComparison.lt(self, date)

## Determines if the instance is less (before) than another.
## [br] Returns bool
func lessThan(date) -> bool:
	return lt(date)

## Determines if the instance is less (before) than another.
## [br] Returns bool
func isBefore(date) -> bool:
	return lt(date)

## Determines if the instance is less (before) than or equal to another.
## [br] Returns bool
func lte(date) -> bool:
	return GraphiteComparison.lte(self, date)

## Determines if the instance is less (before) than or equal to another.
## [br] Returns bool
func lessThanOrEqualTo(date) -> bool:
	return lte(date)

## Returns a string representation of the datetime in YYYY-MM-DD HH:MM:SS format.
func toString() -> String:
	return "%04d-%02d-%02d %02d:%02d:%02d" % [
		_datetime.year, _datetime.month, _datetime.day,
		_datetime.hour, _datetime.minute, _datetime.second
	]



## Returns the datetime dictionary.
func get_datetime() -> Dictionary:
	return _datetime

## Sets the datetime dictionary.
func set_datetime(datetime_dict: Dictionary) -> void:
	_datetime = datetime_dict

## Returns the timezone dictionary.
func get_timezone() -> Dictionary:
	return _timezone

## Sets the timezone dictionary.
func set_timezone(timezone_dict: Dictionary) -> void:
	_timezone = timezone_dict
