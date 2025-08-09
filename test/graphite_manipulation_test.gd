extends GdUnitTestSuite

# Test suite for GraphiteManipulation utility class
# Tests date/time modification functionality

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Copy and Clone ##

func test_copy():
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var copy = GraphiteManipulation.copy(original)
	
	assert_that(copy).is_not_same(original)
	assert_that(copy).is_instance_of(Graphite)
	assert_that(copy.get_datetime()["year"]).is_equal(original.get_datetime()["year"])
	assert_that(copy.get_datetime()["month"]).is_equal(original.get_datetime()["month"])
	assert_that(copy.get_datetime()["day"]).is_equal(original.get_datetime()["day"])
	assert_that(copy.get_datetime()["hour"]).is_equal(original.get_datetime()["hour"])
	assert_that(copy.get_datetime()["minute"]).is_equal(original.get_datetime()["minute"])
	assert_that(copy.get_datetime()["second"]).is_equal(original.get_datetime()["second"])

func test_clone():
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var clone = GraphiteManipulation.clone(original)
	
	assert_that(clone).is_not_same(original)
	assert_that(clone).is_instance_of(Graphite)
	assert_that(clone.get_datetime()["year"]).is_equal(original.get_datetime()["year"])
	assert_that(clone.get_datetime()["month"]).is_equal(original.get_datetime()["month"])
	assert_that(clone.get_datetime()["day"]).is_equal(original.get_datetime()["day"])

func test_copy_with_timezone():
	var timezone = {"bias": -480}  # UTC-8
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, timezone)
	var copy = GraphiteManipulation.copy(original)
	
	assert_that(copy.get_timezone()["bias"]).is_equal(original.get_timezone()["bias"])

## Test Set Time ##

func test_setTime():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setTime(graphite, 9, 15, 30, 0)
	
	assert_that(result).is_same(graphite)  # Should return same instance
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)  # Date should remain unchanged
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(9)
	assert_that(datetime["minute"]).is_equal(15)
	assert_that(datetime["second"]).is_equal(30)

func test_setTime_defaults():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setTime(graphite, 10, 20)  # No seconds/microseconds specified
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(10)
	assert_that(datetime["minute"]).is_equal(20)
	assert_that(datetime["second"]).is_equal(0)  # Should default to 0

func test_setTime_edge_values():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setTime(graphite, 23, 59, 59, 999999)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

## Test Set Date ##

func test_setDate():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setDate(graphite, 2025, 12, 25)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2025)
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(25)
	assert_that(datetime["hour"]).is_equal(14)  # Time should remain unchanged
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(45)

func test_setDate_leap_year():
	var graphite = Graphite.from_dict({"year": 2023, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	GraphiteManipulation.setDate(graphite, 2024, 2, 29)  # Leap year February 29
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(2)
	assert_that(datetime["day"]).is_equal(29)

func test_setDate_month_boundaries():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setDate(graphite, 2024, 1, 1)  # January 1st
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)

## Test Set Timestamp ##

func test_setTimestamp():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var timestamp = 1609459200  # January 1, 2021 00:00:00 UTC
	var result = GraphiteManipulation.setTimestamp(graphite, timestamp)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2021)
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)

func test_setTimestamp_current():
	var graphite = Graphite.from_dict({"year": 2020, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})
	var current_timestamp = Time.get_unix_time_from_system()
	GraphiteManipulation.setTimestamp(graphite, current_timestamp)
	
	# The datetime should be updated to current time
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_greater_than(2020)

## Test Set Timezone ##

func test_setTimezone_dict():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var new_timezone = {"bias": -300}  # UTC-5
	var result = GraphiteManipulation.setTimezone(graphite, new_timezone)
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_timezone()["bias"]).is_equal(-300)

func test_setTimezone_string():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setTimezone(graphite, "UTC")
	
	assert_that(result).is_same(graphite)
	# The actual timezone handling depends on implementation

## Test UTC ##

func test_utc():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {"bias": -480})
	var result = GraphiteManipulation.utc(graphite)
	
	assert_that(result).is_same(graphite)
	# Should convert to UTC timezone
	var timezone = graphite.get_timezone()
	assert_that(timezone["bias"]).is_equal(0)  # UTC has 0 bias

## Test Set Date From ##

func test_setDateFrom():
	var source = Graphite.from_dict({"year": 2025, "month": 12, "day": 25, "hour": 9, "minute": 0, "second": 0}, {})
	var target = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setDateFrom(target, source)
	
	assert_that(result).is_same(target)
	var datetime = target.get_datetime()
	assert_that(datetime["year"]).is_equal(2025)
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(25)
	assert_that(datetime["hour"]).is_equal(14)  # Time should remain unchanged
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(45)

## Test Set Time From ##

func test_setTimeFrom():
	var source = Graphite.from_dict({"year": 2025, "month": 12, "day": 25, "hour": 9, "minute": 15, "second": 30}, {})
	var target = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setTimeFrom(target, source)
	
	assert_that(result).is_same(target)
	var datetime = target.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)  # Date should remain unchanged
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(9)
	assert_that(datetime["minute"]).is_equal(15)
	assert_that(datetime["second"]).is_equal(30)

## Test Set DateTime From ##

func test_setDateTimeFrom():
	var source = Graphite.from_dict({"year": 2025, "month": 12, "day": 25, "hour": 9, "minute": 15, "second": 30}, {})
	var target = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setDateTimeFrom(target, source)
	
	assert_that(result).is_same(target)
	var datetime = target.get_datetime()
	assert_that(datetime["year"]).is_equal(2025)
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(25)
	assert_that(datetime["hour"]).is_equal(9)
	assert_that(datetime["minute"]).is_equal(15)
	assert_that(datetime["second"]).is_equal(30)

## Test Set Unit ##

func test_setUnit_year():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteManipulation.setUnit(graphite, "year", 2025)
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["year"]).is_equal(2025)

func test_setUnit_month():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setUnit(graphite, "month", 12)
	
	assert_that(graphite.get_datetime()["month"]).is_equal(12)

func test_setUnit_day():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setUnit(graphite, "day", 25)
	
	assert_that(graphite.get_datetime()["day"]).is_equal(25)

func test_setUnit_hour():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setUnit(graphite, "hour", 23)
	
	assert_that(graphite.get_datetime()["hour"]).is_equal(23)

func test_setUnit_minute():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setUnit(graphite, "minute", 45)
	
	assert_that(graphite.get_datetime()["minute"]).is_equal(45)

func test_setUnit_second():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setUnit(graphite, "second", 59)
	
	assert_that(graphite.get_datetime()["second"]).is_equal(59)

## Test Edge Cases ##

func test_setTime_midnight():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteManipulation.setTime(graphite, 0, 0, 0, 0)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_setDate_new_year():
	var graphite = Graphite.from_dict({"year": 2024, "month": 12, "day": 31, "hour": 23, "minute": 59, "second": 59}, {})
	GraphiteManipulation.setDate(graphite, 2025, 1, 1)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2025)
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)
	# Time should remain unchanged
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_copy_independence():
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var copy = GraphiteManipulation.copy(original)
	
	# Modify the copy
	GraphiteManipulation.setDate(copy, 2025, 12, 25)
	
	# Original should remain unchanged
	assert_that(original.get_datetime()["year"]).is_equal(2024)
	assert_that(original.get_datetime()["month"]).is_equal(6)
	assert_that(original.get_datetime()["day"]).is_equal(15)
	
	# Copy should be changed
	assert_that(copy.get_datetime()["year"]).is_equal(2025)
	assert_that(copy.get_datetime()["month"]).is_equal(12)
	assert_that(copy.get_datetime()["day"]).is_equal(25)

## Test Return Value Consistency ##

func test_all_manipulation_methods_return_graphite():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var other = Graphite.from_dict({"year": 2025, "month": 12, "day": 25, "hour": 9, "minute": 15, "second": 30}, {})
	
	# Test that manipulation methods return Graphite instances
	assert_that(GraphiteManipulation.copy(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.clone(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setTime(graphite, 10, 30)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setDate(graphite, 2024, 7, 20)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setTimestamp(graphite, 1609459200)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setTimezone(graphite, {})).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.utc(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setDateFrom(graphite, other)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setTimeFrom(graphite, other)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setDateTimeFrom(graphite, other)).is_instance_of(Graphite)
	assert_that(GraphiteManipulation.setUnit(graphite, "year", 2024)).is_instance_of(Graphite)

func test_modification_methods_modify_same_instance():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	
	# Test that modification methods return the same instance (not copies)
	assert_that(GraphiteManipulation.setTime(graphite, 10, 30)).is_same(graphite)
	assert_that(GraphiteManipulation.setDate(graphite, 2024, 7, 20)).is_same(graphite)
	assert_that(GraphiteManipulation.setTimestamp(graphite, 1609459200)).is_same(graphite)
	assert_that(GraphiteManipulation.setUnit(graphite, "year", 2024)).is_same(graphite)
