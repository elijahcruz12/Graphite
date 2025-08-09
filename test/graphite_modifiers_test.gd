extends GdUnitTestSuite

# Test suite for GraphiteModifiers utility class
# Tests start/end of period operations functionality

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Start of Day ##

func test_startOfDay():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOfDay(graphite)
	
	assert_that(result).is_same(graphite)  # Should return same instance
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOfDay_already_start():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 0, "minute": 0, "second": 0}, {})
	GraphiteModifiers.startOfDay(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

## Test End of Day ##

func test_endOfDay():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOfDay(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_endOfDay_already_end():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 23, "minute": 59, "second": 59}, {})
	GraphiteModifiers.endOfDay(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

## Test Start of Month ##

func test_startOfMonth():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOfMonth(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(1)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOfMonth_already_first_day():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 1, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOfMonth(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(1)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

## Test End of Month ##

func test_endOfMonth_january():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOfMonth(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(31)  # January has 31 days
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_endOfMonth_february_leap_year():
	var graphite = Graphite.from_dict({"year": 2024, "month": 2, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfMonth(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(29)  # February 2024 has 29 days (leap year)

func test_endOfMonth_february_normal_year():
	var graphite = Graphite.from_dict({"year": 2023, "month": 2, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfMonth(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(28)  # February 2023 has 28 days

func test_endOfMonth_april():
	var graphite = Graphite.from_dict({"year": 2024, "month": 4, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfMonth(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(30)  # April has 30 days

## Test Start of Year ##

func test_startOfYear():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOfYear(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOfYear_already_first_day():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOfYear(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

## Test End of Year ##

func test_endOfYear():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOfYear(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(31)
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_endOfYear_already_last_day():
	var graphite = Graphite.from_dict({"year": 2024, "month": 12, "day": 31, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfYear(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(31)
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

## Test Start of Week ##

func test_startOfWeek_default():
	# January 3, 2024 is a Wednesday, week starts Monday (default)
	var wednesday = Graphite.from_dict({"year": 2024, "month": 1, "day": 3, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOfWeek(wednesday)
	
	assert_that(result).is_same(wednesday)
	var datetime = wednesday.get_datetime()
	assert_that(datetime["day"]).is_equal(1)  # Should be January 1 (Monday)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOfWeek_sunday_start():
	# January 3, 2024 is a Wednesday, week starts Sunday
	var wednesday = Graphite.from_dict({"year": 2024, "month": 1, "day": 3, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOfWeek(wednesday, GraphiteInterface.SUNDAY)
	
	var datetime = wednesday.get_datetime()
	# Should go back to previous Sunday (December 31, 2023)
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(31)

func test_startOfWeek_already_monday():
	# January 1, 2024 is a Monday
	var monday = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOfWeek(monday, GraphiteInterface.MONDAY)
	
	var datetime = monday.get_datetime()
	assert_that(datetime["day"]).is_equal(1)  # Should stay January 1
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

## Test End of Week ##

func test_endOfWeek_default():
	# January 3, 2024 is a Wednesday, week ends Sunday (default)
	var wednesday = Graphite.from_dict({"year": 2024, "month": 1, "day": 3, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOfWeek(wednesday)
	
	assert_that(result).is_same(wednesday)
	var datetime = wednesday.get_datetime()
	assert_that(datetime["day"]).is_equal(7)  # Should be January 7 (Sunday)
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_endOfWeek_saturday_end():
	# January 3, 2024 is a Wednesday, week ends Saturday
	var wednesday = Graphite.from_dict({"year": 2024, "month": 1, "day": 3, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfWeek(wednesday, GraphiteInterface.SATURDAY)
	
	var datetime = wednesday.get_datetime()
	assert_that(datetime["day"]).is_equal(6)  # Should be January 6 (Saturday)

func test_endOfWeek_already_sunday():
	# January 7, 2024 is a Sunday
	var sunday = Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfWeek(sunday, GraphiteInterface.SUNDAY)
	
	var datetime = sunday.get_datetime()
	assert_that(datetime["day"]).is_equal(7)  # Should stay January 7
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

## Test Start of Hour ##

func test_startOfHour():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOfHour(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(14)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOfHour_already_start():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 0, "second": 0}, {})
	GraphiteModifiers.startOfHour(graphite)
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

## Test End of Hour ##

func test_endOfHour():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOfHour(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(14)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

## Test Start of Minute ##

func test_startOfMinute():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOfMinute(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(14)
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(0)

## Test End of Minute ##

func test_endOfMinute():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOfMinute(graphite)
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(14)
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(59)

## Test Generic Start/End Methods ##

func test_startOf_day():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.startOf(graphite, "day")
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOf_month():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOf(graphite, "month")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(1)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_startOf_year():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOf(graphite, "year")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_endOf_day():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteModifiers.endOf(graphite, "day")
	
	assert_that(result).is_same(graphite)
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_endOf_month():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOf(graphite, "month")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(31)  # January has 31 days
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_endOf_year():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOf(graphite, "year")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(31)
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

## Test Edge Cases ##

func test_month_boundaries():
	# Test end of short month (April -> May)
	var april_30 = Graphite.from_dict({"year": 2024, "month": 4, "day": 30, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.startOfMonth(april_30)
	
	var datetime = april_30.get_datetime()
	assert_that(datetime["month"]).is_equal(4)
	assert_that(datetime["day"]).is_equal(1)

func test_year_boundaries():
	# Test crossing year boundary
	var december = Graphite.from_dict({"year": 2023, "month": 12, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	GraphiteModifiers.endOfYear(december)
	
	var datetime = december.get_datetime()
	assert_that(datetime["year"]).is_equal(2023)
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(31)

## Test Return Value Consistency ##

func test_all_modifier_methods_return_graphite():
	var graphite = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	
	# Test that all modifier methods return Graphite instances
	assert_that(GraphiteModifiers.startOfDay(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOfDay(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.startOfMonth(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOfMonth(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.startOfYear(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOfYear(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.startOfWeek(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOfWeek(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.startOfHour(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOfHour(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.startOfMinute(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOfMinute(graphite)).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.startOf(graphite, "day")).is_instance_of(Graphite)
	assert_that(GraphiteModifiers.endOf(graphite, "day")).is_instance_of(Graphite)
