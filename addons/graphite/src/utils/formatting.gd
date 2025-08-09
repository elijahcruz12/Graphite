class_name GraphiteFormatting
extends RefCounted

### Format Functions ###

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func format(graphite: Graphite, format_string: String) -> String:
	var datetime = graphite.get_datetime()
	var result = format_string
	
	# PHP-style format codes
	result = result.replace("Y", str(datetime.year).pad_zeros(4))
	result = result.replace("y", str(datetime.year % 100).pad_zeros(2))
	result = result.replace("m", str(datetime.month).pad_zeros(2))
	result = result.replace("n", str(datetime.month))
	result = result.replace("d", str(datetime.day).pad_zeros(2))
	result = result.replace("j", str(datetime.day))
	result = result.replace("H", str(datetime.hour).pad_zeros(2))
	result = result.replace("G", str(datetime.hour))
	result = result.replace("i", str(datetime.minute).pad_zeros(2))
	result = result.replace("s", str(datetime.second).pad_zeros(2))
	
	# Day of week
	var weekday = Time.get_datetime_dict_from_unix_time(Time.get_unix_time_from_datetime_dict(datetime)).weekday
	var day_names = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	var short_day_names = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
	
	result = result.replace("l", day_names[weekday])
	result = result.replace("D", short_day_names[weekday])
	result = result.replace("w", str(weekday))
	
	# Month names
	var month_names = ["January", "February", "March", "April", "May", "June", 
					   "July", "August", "September", "October", "November", "December"]
	var short_month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
							 "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
	
	result = result.replace("F", month_names[datetime.month - 1])
	result = result.replace("M", short_month_names[datetime.month - 1])
	
	return result

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toDateTimeString(graphite: Graphite) -> String:
	return format(graphite, "Y-m-d H:i:s")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toDateString(graphite: Graphite) -> String:
	return format(graphite, "Y-m-d")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toTimeString(graphite: Graphite) -> String:
	return format(graphite, "H:i:s")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toFormattedDateString(graphite: Graphite) -> String:
	return format(graphite, "F j, Y")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toDayDateTimeString(graphite: Graphite) -> String:
	return format(graphite, "l, F j, Y g:i A")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toAtomString(graphite: Graphite) -> String:
	return format(graphite, "Y-m-d\\TH:i:sP")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toCookieString(graphite: Graphite) -> String:
	return format(graphite, "l, d-M-Y H:i:s T")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toIso8601String(graphite: Graphite) -> String:
	return format(graphite, "Y-m-d\\TH:i:sO")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toIso8601ZuluString(graphite: Graphite) -> String:
	# Convert to UTC first, then format
	var utc_graphite = graphite.copy().utc()
	return format(utc_graphite, "Y-m-d\\TH:i:s\\Z")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRfc822String(graphite: Graphite) -> String:
	return format(graphite, "D, d M y H:i:s O")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRfc850String(graphite: Graphite) -> String:
	return format(graphite, "l, d-M-y H:i:s T")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRfc1036String(graphite: Graphite) -> String:
	return format(graphite, "D, d M y H:i:s O")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRfc1123String(graphite: Graphite) -> String:
	return format(graphite, "D, d M Y H:i:s O")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRfc2822String(graphite: Graphite) -> String:
	return format(graphite, "D, d M Y H:i:s O")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRfc3339String(graphite: Graphite) -> String:
	return format(graphite, "Y-m-d\\TH:i:sP")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toRssString(graphite: Graphite) -> String:
	return format(graphite, "D, d M Y H:i:s O")

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func toW3cString(graphite: Graphite) -> String:
	return format(graphite, "Y-m-d\\TH:i:sP")
