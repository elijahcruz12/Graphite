class_name GraphiteMath
extends RefCounted

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func add(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	
	match unit:
		"seconds":
			unix_time += amount
		"minutes":
			unix_time += amount * GraphiteInterface.SECONDS_PER_MINUTE
		"hours":
			unix_time += amount * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"days":
			unix_time += amount * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
	
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_time))
	return graphite

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func sub(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	
	match unit:
		"seconds":
			unix_time -= amount
		"minutes":
			unix_time -= amount * GraphiteInterface.SECONDS_PER_MINUTE
		"hours":
			unix_time -= amount * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
		"days":
			unix_time -= amount * GraphiteInterface.HOURS_PER_DAY * GraphiteInterface.MINUTES_PER_HOUR * GraphiteInterface.SECONDS_PER_MINUTE
	
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_time))
	return graphite
