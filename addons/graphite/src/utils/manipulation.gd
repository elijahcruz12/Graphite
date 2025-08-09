extends RefCounted
class_name GraphiteManipulation

### Manipulation Functions ###

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func copy(graphite: Graphite) -> Graphite:
	return Graphite.new(graphite.get_datetime().duplicate(), graphite.get_timezone().duplicate())

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func clone(graphite: Graphite) -> Graphite:
	return copy(graphite)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setTime(graphite: Graphite, hour: int, minute: int, second: int = 0, microseconds: int = 0) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.hour = hour
	datetime.minute = minute
	datetime.second = second
	# Note: Godot doesn't have microseconds in datetime dict
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setDate(graphite: Graphite, year: int, month: int, day: int) -> Graphite:
	var datetime = graphite.get_datetime()
	datetime.year = year
	datetime.month = month
	datetime.day = day
	graphite.set_datetime(datetime)
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setTimestamp(graphite: Graphite, timestamp) -> Graphite:
	var unix_timestamp: int
	if timestamp is String:
		unix_timestamp = int(timestamp)
	elif timestamp is int or timestamp is float:
		unix_timestamp = int(timestamp)
	else:
		push_error("Invalid timestamp format")
		return graphite
	
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_timestamp))
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setTimezone(graphite: Graphite, timeZone) -> Graphite:
	# For now, we'll store the timezone info in the graphite instance
	# Full timezone conversion would require more complex implementation
	if timeZone is String:
		graphite.set_timezone({"name": timeZone})
	elif timeZone is Dictionary:
		graphite.set_timezone(timeZone)
	else:
		push_error("Invalid timezone format")
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func utc(graphite: Graphite) -> Graphite:
	return setTimezone(graphite, "UTC")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setDateFrom(graphite: Graphite, date) -> Graphite:
	var source_datetime: Dictionary
	if date is Graphite:
		source_datetime = date.get_datetime()
	elif date is String:
		# Parse date string - simplified implementation
		var parts = date.split("-")
		if parts.size() >= 3:
			source_datetime = {"year": int(parts[0]), "month": int(parts[1]), "day": int(parts[2])}
		else:
			push_error("Invalid date string format")
			return graphite
	else:
		push_error("Invalid date format")
		return graphite
	
	return setDate(graphite, source_datetime.year, source_datetime.month, source_datetime.day)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setTimeFrom(graphite: Graphite, date) -> Graphite:
	var source_datetime: Dictionary
	if date is Graphite:
		source_datetime = date.get_datetime()
	elif date is String:
		# Parse time string - simplified implementation
		var parts = date.split(":")
		if parts.size() >= 2:
			var hour = int(parts[0])
			var minute = int(parts[1])
			var second = int(parts[2]) if parts.size() > 2 else 0
			return setTime(graphite, hour, minute, second)
		else:
			push_error("Invalid time string format")
			return graphite
	else:
		push_error("Invalid time format")
		return graphite
	
	return setTime(graphite, source_datetime.hour, source_datetime.minute, source_datetime.second)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setDateTimeFrom(graphite: Graphite, date) -> Graphite:
	var source_datetime: Dictionary
	if date is Graphite:
		source_datetime = date.get_datetime()
		graphite.set_datetime(source_datetime.duplicate())
	elif date is String:
		# Parse datetime string - simplified implementation
		var parts = date.split(" ")
		if parts.size() >= 2:
			setDateFrom(graphite, parts[0])
			setTimeFrom(graphite, parts[1])
		else:
			push_error("Invalid datetime string format")
			return graphite
	else:
		push_error("Invalid datetime format")
		return graphite
	
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func setUnit(graphite: Graphite, unit: String, value) -> Graphite:
	var datetime = graphite.get_datetime()
	var int_value = int(value) if value != null else 0
	
	match unit.to_lower():
		"year":
			datetime.year = int_value
		"month":
			datetime.month = int_value
		"day":
			datetime.day = int_value
		"hour":
			datetime.hour = int_value
		"minute":
			datetime.minute = int_value
		"second":
			datetime.second = int_value
		_:
			push_error("Invalid unit: " + unit)
			return graphite
	
	graphite.set_datetime(datetime)
	return graphite
