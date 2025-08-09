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

### Static Init

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

### Public accessors ###

## Returns a 
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
