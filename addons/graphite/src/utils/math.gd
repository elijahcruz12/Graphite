class_name GraphiteMath
extends RefCounted

# Helper function to calculate seconds for various units
static func _get_seconds_per_unit(unit: String) -> int:
	match unit:
		"microseconds":
			return 1.0 / GraphiteInterface.MICROSECONDS_PER_SECOND
		"milliseconds":
			return 1.0 / GraphiteInterface.MILLISECONDS_PER_SECOND
		"seconds":
			return 1
		"minutes":
			return GraphiteInterface.SECONDS_PER_MINUTE
		"hours":
			return GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"days":
			return GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"weeks":
			return GraphiteInterface.DAYS_PER_WEEK * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"months":
			# Approximate: using 30.44 days per month (365.25/12)
			return int(30.44 * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE)
		"quarters":
			return GraphiteInterface.MONTHS_PER_QUARTER * int(30.44 * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE)
		"years":
			return GraphiteInterface.DAYS_PER_YEAR * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"decades":
			return GraphiteInterface.YEARS_PER_DECADE * GraphiteInterface.DAYS_PER_YEAR * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"centuries":
			return GraphiteInterface.YEARS_PER_CENTURY * GraphiteInterface.DAYS_PER_YEAR * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"millenniums", "millennia":
			return GraphiteInterface.YEARS_PER_MILLENNIUM * GraphiteInterface.DAYS_PER_YEAR * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		_:
			push_error("Unknown time unit: " + unit)
			return 0

# Helper function to add weekdays (Monday-Friday only)
static func _add_weekdays(graphite: Graphite, amount: int) -> Graphite:
	var datetime = graphite.get_datetime()
	var current_weekday = Time.get_datetime_dict_from_unix_time(Time.get_unix_time_from_datetime_dict(datetime)).weekday
	
	var days_to_add = 0
	var remaining_weekdays = amount
	
	while remaining_weekdays > 0:
		days_to_add += 1
		var new_weekday = (current_weekday + days_to_add - 1) % 7 + 1
		
		# Skip weekends (Saturday = 6, Sunday = 7)
		if new_weekday != 6 and new_weekday != 7:
			remaining_weekdays -= 1
	
	return add(graphite, days_to_add, "days")

static func _sub_weekdays(graphite: Graphite, amount: int) -> Graphite:
	var datetime = graphite.get_datetime()
	var current_weekday = Time.get_datetime_dict_from_unix_time(Time.get_unix_time_from_datetime_dict(datetime)).weekday
	
	var days_to_sub = 0
	var remaining_weekdays = amount
	
	while remaining_weekdays > 0:
		days_to_sub += 1
		var new_weekday = ((current_weekday - days_to_sub - 1) % 7 + 7) % 7 + 1
		
		# Skip weekends (Saturday = 6, Sunday = 7)
		if new_weekday != 6 and new_weekday != 7:
			remaining_weekdays -= 1
	
	return sub(graphite, days_to_sub, "days")

# Addition functions

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func add(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
	if unit == "weekdays":
		return _add_weekdays(graphite, amount)
	
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	var seconds_to_add = _get_seconds_per_unit(unit) * amount
	
	unix_time += seconds_to_add
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_time))
	return graphite

# Plural addition functions
## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMicroseconds(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "microseconds")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMilliseconds(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "milliseconds")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addSeconds(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "seconds")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMinutes(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "minutes")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addHours(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "hours")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addDays(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "days")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addWeeks(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "weeks")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addWeekdays(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "weekdays")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMonths(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "months")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addQuarters(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "quarters")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addYears(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "years")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addDecades(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "decades")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addCenturies(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "centuries")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMillenniums(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "millenniums")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMillennia(graphite: Graphite, amount: int) -> Graphite:
	return add(graphite, amount, "millennia")

# Singular addition functions
## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMicrosecond(graphite: Graphite) -> Graphite:
	return addMicroseconds(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMillisecond(graphite: Graphite) -> Graphite:
	return addMilliseconds(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addSecond(graphite: Graphite) -> Graphite:
	return addSeconds(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMinute(graphite: Graphite) -> Graphite:
	return addMinutes(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addHour(graphite: Graphite) -> Graphite:
	return addHours(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addDay(graphite: Graphite) -> Graphite:
	return addDays(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addWeek(graphite: Graphite) -> Graphite:
	return addWeeks(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addWeekday(graphite: Graphite) -> Graphite:
	return addWeekdays(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMonth(graphite: Graphite) -> Graphite:
	return addMonths(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addQuarter(graphite: Graphite) -> Graphite:
	return addQuarters(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addYear(graphite: Graphite) -> Graphite:
	return addYears(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addDecade(graphite: Graphite) -> Graphite:
	return addDecades(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addCentury(graphite: Graphite) -> Graphite:
	return addCenturies(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func addMillennium(graphite: Graphite) -> Graphite:
	return addMillenniums(graphite, 1)

# Subtraction functions

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func sub(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
	if unit == "weekdays":
		return _sub_weekdays(graphite, amount)
	
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	var seconds_to_sub = _get_seconds_per_unit(unit) * amount
	
	unix_time -= seconds_to_sub
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_time))
	return graphite

# Plural subtraction functions
## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMicroseconds(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "microseconds")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMilliseconds(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "milliseconds")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subSeconds(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "seconds")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMinutes(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "minutes")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subHours(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "hours")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subDays(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "days")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subWeeks(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "weeks")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subWeekdays(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "weekdays")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMonths(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "months")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subQuarters(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "quarters")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subYears(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "years")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subDecades(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "decades")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subCenturies(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "centuries")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMillenniums(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "millenniums")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMillennia(graphite: Graphite, amount: int) -> Graphite:
	return sub(graphite, amount, "millennia")

# Singular subtraction functions
## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMicrosecond(graphite: Graphite) -> Graphite:
	return subMicroseconds(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMillisecond(graphite: Graphite) -> Graphite:
	return subMilliseconds(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subSecond(graphite: Graphite) -> Graphite:
	return subSeconds(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMinute(graphite: Graphite) -> Graphite:
	return subMinutes(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subHour(graphite: Graphite) -> Graphite:
	return subHours(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subDay(graphite: Graphite) -> Graphite:
	return subDays(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subWeek(graphite: Graphite) -> Graphite:
	return subWeeks(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subWeekday(graphite: Graphite) -> Graphite:
	return subWeekdays(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMonth(graphite: Graphite) -> Graphite:
	return subMonths(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subQuarter(graphite: Graphite) -> Graphite:
	return subQuarters(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subYear(graphite: Graphite) -> Graphite:
	return subYears(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subDecade(graphite: Graphite) -> Graphite:
	return subDecades(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subCentury(graphite: Graphite) -> Graphite:
	return subCenturies(graphite, 1)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func subMillennium(graphite: Graphite) -> Graphite:
	return subMillenniums(graphite, 1)
