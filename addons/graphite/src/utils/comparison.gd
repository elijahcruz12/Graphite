extends RefCounted
class_name GraphiteComparison

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func eq(graphite: Graphite, date) -> bool:
	var unix_time = Time.get_unix_time_from_datetime_dict(graphite.get_datetime())
	var other_unix_time
	if date is Graphite:
		other_unix_time = Time.get_unix_time_from_datetime_dict(date.get_datetime())
	elif date is String:
		other_unix_time = Time.get_unix_time_from_datetime_string(date)
	else:
		return false
	return unix_time == other_unix_time

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func ne(graphite: Graphite, date) -> bool:
	return !eq(graphite, date)

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func gt(graphite: Graphite, date) -> bool:
	var unix_time = Time.get_unix_time_from_datetime_dict(graphite.get_datetime())
	var other_unix_time
	if date is Graphite:
		other_unix_time = Time.get_unix_time_from_datetime_dict(date.get_datetime())
	elif date is String:
		other_unix_time = Time.get_unix_time_from_datetime_string(date)
	else:
		return false
	return unix_time > other_unix_time

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func gte(graphite: Graphite, date) -> bool:
	var unix_time = Time.get_unix_time_from_datetime_dict(graphite.get_datetime())
	var other_unix_time
	if date is Graphite:
		other_unix_time = Time.get_unix_time_from_datetime_dict(date.get_datetime())
	elif date is String:
		other_unix_time = Time.get_unix_time_from_datetime_string(date)
	else:
		return false
	return unix_time >= other_unix_time

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func lt(graphite: Graphite, date) -> bool:
	var unix_time = Time.get_unix_time_from_datetime_dict(graphite.get_datetime())
	var other_unix_time
	if date is Graphite:
		other_unix_time = Time.get_unix_time_from_datetime_dict(date.get_datetime())
	elif date is String:
		other_unix_time = Time.get_unix_time_from_datetime_string(date)
	else:
		return false
	return unix_time < other_unix_time

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func lte(graphite: Graphite, date) -> bool:
	var unix_time = Time.get_unix_time_from_datetime_dict(graphite.get_datetime())
	var other_unix_time
	if date is Graphite:
		other_unix_time = Time.get_unix_time_from_datetime_dict(date.get_datetime())
	elif date is String:
		other_unix_time = Time.get_unix_time_from_datetime_string(date)
	else:
		return false
	return unix_time <= other_unix_time
