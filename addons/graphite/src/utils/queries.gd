extends RefCounted
class_name GraphiteQueries

### Query Functions ###

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isWeekday(graphite: Graphite) -> bool:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	var weekday = Time.get_datetime_dict_from_unix_time(unix_time).weekday
	# Monday = 1, Sunday = 0, so weekdays are Monday-Friday
	return weekday >= GraphiteInterface.MONDAY and weekday <= GraphiteInterface.FRIDAY

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isWeekend(graphite: Graphite) -> bool:
	return !isWeekday(graphite)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isToday(graphite: Graphite) -> bool:
	var now = Graphite.now()
	return _isSameDate(graphite, now)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isYesterday(graphite: Graphite) -> bool:
	var yesterday = Graphite.yesterday()
	return _isSameDate(graphite, yesterday)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isTomorrow(graphite: Graphite) -> bool:
	var tomorrow = Graphite.tomorrow()
	return _isSameDate(graphite, tomorrow)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isFuture(graphite: Graphite) -> bool:
	var now = Graphite.now()
	return GraphiteComparison.gt(graphite, now)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isPast(graphite: Graphite) -> bool:
	var now = Graphite.now()
	return GraphiteComparison.lt(graphite, now)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isLeapYear(graphite: Graphite) -> bool:
	var year = graphite.get_datetime().year
	return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isSameMonth(graphite: Graphite, date, ofSameYear: bool = true) -> bool:
	var other_datetime: Dictionary
	if date is Graphite:
		other_datetime = date.get_datetime()
	elif date is String:
		# Simple parsing - could be enhanced
		var parts = date.split("-")
		if parts.size() >= 2:
			other_datetime = {"year": int(parts[0]), "month": int(parts[1])}
		else:
			return false
	else:
		return false
	
	var our_datetime = graphite.get_datetime()
	if ofSameYear:
		return our_datetime.year == other_datetime.year and our_datetime.month == other_datetime.month
	else:
		return our_datetime.month == other_datetime.month

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isDayOfWeek(graphite: Graphite, dayOfWeek) -> bool:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	var current_weekday = Time.get_datetime_dict_from_unix_time(unix_time).weekday
	
	if dayOfWeek is int:
		return current_weekday == dayOfWeek
	elif dayOfWeek is String:
		var day_names = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
		var target_day = -1
		for i in range(day_names.size()):
			if day_names[i].to_lower() == dayOfWeek.to_lower():
				target_day = i
				break
		return current_weekday == target_day
	else:
		return false

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isBirthday(graphite: Graphite, date = null) -> bool:
	var compare_date: Graphite
	if date == null:
		compare_date = Graphite.now()
	elif date is Graphite:
		compare_date = date
	elif date is String:
		# Simple parsing
		var parts = date.split("-")
		if parts.size() >= 3:
			compare_date = Graphite.new({"year": int(parts[0]), "month": int(parts[1]), "day": int(parts[2])})
		else:
			return false
	else:
		return false
	
	var our_datetime = graphite.get_datetime()
	var compare_datetime = compare_date.get_datetime()
	
	return our_datetime.month == compare_datetime.month and our_datetime.day == compare_datetime.day

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isLastOfMonth(graphite: Graphite) -> bool:
	var datetime = graphite.get_datetime()
	var year = datetime.year
	var month = datetime.month
	var day = datetime.day
	
	# Get last day of the month
	var last_day = _get_last_day_of_month(year, month)
	return day == last_day

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isStartOfDay(graphite: Graphite, checkMicroseconds: bool = false) -> bool:
	var datetime = graphite.get_datetime()
	if checkMicroseconds:
		# Godot doesn't have microseconds in datetime dict, so we assume 0
		return datetime.hour == 0 and datetime.minute == 0 and datetime.second == 0
	else:
		return datetime.hour == 0 and datetime.minute == 0 and datetime.second == 0

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func isEndOfDay(graphite: Graphite, checkMicroseconds: bool = false) -> bool:
	var datetime = graphite.get_datetime()
	if checkMicroseconds:
		# For end of day with microseconds, we'd expect 23:59:59.999999
		return datetime.hour == 23 and datetime.minute == 59 and datetime.second == 59
	else:
		return datetime.hour == 23 and datetime.minute == 59 and datetime.second == 59

### Helper Functions ###

static func _isSameDate(graphite1: Graphite, graphite2: Graphite) -> bool:
	var dt1 = graphite1.get_datetime()
	var dt2 = graphite2.get_datetime()
	return dt1.year == dt2.year and dt1.month == dt2.month and dt1.day == dt2.day

static func _get_last_day_of_month(year: int, month: int) -> int:
	var days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	
	# Check for leap year
	if month == GraphiteInterface.FEBRUARY and _is_leap_year(year):
		return 29
	
	return days_in_month[month - 1]

static func _is_leap_year(year: int) -> bool:
	return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)
