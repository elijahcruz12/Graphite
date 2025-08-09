extends RefCounted
class_name GraphiteMath

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func add(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	
	match unit:
		"seconds":
			unix_time += amount
		"minutes":
			unix_time += amount * 60
		"hours":
			unix_time += amount * 3600
		"days":
			unix_time += amount * 86400
	
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_time))
	return graphite
