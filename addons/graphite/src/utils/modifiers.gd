class_name GraphiteModifiers
extends RefCounted

### Modifier Functions ###

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOfDay(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.hour = 0
	datetime.minute = 0
	datetime.second = 0
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOfDay(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.hour = GraphiteInterface.HOURS_PER_DAY - 1  # 23
	datetime.minute = GraphiteInterface.MINUTES_PER_HOUR - 1  # 59
	datetime.second = GraphiteInterface.SECONDS_PER_MINUTE - 1  # 59
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOfMonth(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.day = 1
	datetime.hour = 0
	datetime.minute = 0
	datetime.second = 0
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOfMonth(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	# Get last day of month
	var year = datetime.year
	var month = datetime.month
	var last_day = _get_last_day_of_month(year, month)
	
	datetime.day = last_day
	datetime.hour = 23
	datetime.minute = 59
	datetime.second = 59
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOfYear(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.month = GraphiteInterface.JANUARY
	datetime.day = 1
	datetime.hour = 0
	datetime.minute = 0
	datetime.second = 0
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOfYear(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.month = GraphiteInterface.DECEMBER
	datetime.day = 31
	datetime.hour = GraphiteInterface.HOURS_PER_DAY - 1  # 23
	datetime.minute = GraphiteInterface.MINUTES_PER_HOUR - 1  # 59
	datetime.second = GraphiteInterface.SECONDS_PER_MINUTE - 1  # 59
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOfHour(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.minute = 0
	datetime.second = 0
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOfHour(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.minute = GraphiteInterface.MINUTES_PER_HOUR - 1  # 59
	datetime.second = GraphiteInterface.SECONDS_PER_MINUTE - 1  # 59
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOfMinute(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.second = 0
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOfMinute(graphite: Graphite) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.second = GraphiteInterface.SECONDS_PER_MINUTE - 1  # 59
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOfWeek(graphite: Graphite, weekStartsAt: int = GraphiteInterface.MONDAY) -> Graphite:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	var current_weekday = Time.get_datetime_dict_from_unix_time(unix_time).weekday
	
	# Calculate days to subtract to get to start of week
	var days_to_subtract = (current_weekday - weekStartsAt + GraphiteInterface.DAYS_PER_WEEK) % GraphiteInterface.DAYS_PER_WEEK
	unix_time -= days_to_subtract * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
	
	var start_datetime = Time.get_datetime_dict_from_unix_time(unix_time)
	start_datetime.hour = 0
	start_datetime.minute = 0
	start_datetime.second = 0
	
	graphite.set_datetime(start_datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOfWeek(graphite: Graphite, weekEndsAt: int = GraphiteInterface.SUNDAY) -> Graphite:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	var current_weekday = Time.get_datetime_dict_from_unix_time(unix_time).weekday
	
	# Calculate days to add to get to end of week
	var days_to_add = (weekEndsAt - current_weekday + GraphiteInterface.DAYS_PER_WEEK) % GraphiteInterface.DAYS_PER_WEEK
	if days_to_add == 0:
		days_to_add = GraphiteInterface.DAYS_PER_WEEK
	unix_time += days_to_add * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
	
	var end_datetime = Time.get_datetime_dict_from_unix_time(unix_time)
	end_datetime.hour = GraphiteInterface.HOURS_PER_DAY - 1  # 23
	end_datetime.minute = GraphiteInterface.MINUTES_PER_HOUR - 1  # 59
	end_datetime.second = GraphiteInterface.SECONDS_PER_MINUTE - 1  # 59
	
	graphite.set_datetime(end_datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func startOf(graphite: Graphite, unit: String, params = null) -> Graphite:
	match unit.to_lower():
		"day":
			return startOfDay(graphite)
		"month":
			return startOfMonth(graphite)
		"year":
			return startOfYear(graphite)
		"hour":
			return startOfHour(graphite)
		"minute":
			return startOfMinute(graphite)
		"week":
			var weekStartsAt = params if params != null else GraphiteInterface.MONDAY
			return startOfWeek(graphite, weekStartsAt)
		_:
			push_error("Invalid unit for startOf: " + unit)
			return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func endOf(graphite: Graphite, unit: String, params = null) -> Graphite:
	match unit.to_lower():
		"day":
			return endOfDay(graphite)
		"month":
			return endOfMonth(graphite)
		"year":
			return endOfYear(graphite)
		"hour":
			return endOfHour(graphite)
		"minute":
			return endOfMinute(graphite)
		"week":
			var weekEndsAt = params if params != null else GraphiteInterface.SUNDAY
			return endOfWeek(graphite, weekEndsAt)
		_:
			push_error("Invalid unit for endOf: " + unit)
			return graphite

### Helper Functions ###

static func _get_last_day_of_month(year: int, month: int) -> int:
	var days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	
	# Check for leap year
	if month == GraphiteInterface.FEBRUARY and _is_leap_year(year):
		return 29
	
	return days_in_month[month - 1]

static func _is_leap_year(year: int) -> bool:
	return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)
