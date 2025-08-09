extends GdUnitTestSuite
class_name GraphiteMathTest

# Test suite for GraphiteMath utility class
# Tests mathematical operations (add/subtract) functionality

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Addition Operations ##

func test_add_seconds_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	var result = GraphiteMath.add(graphite, 45, "seconds")
	
	assert_that(result).is_same(graphite)  # Should return same instance
	assert_that(graphite.get_datetime()["second"]).is_equal(45)

func test_add_minutes_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	var result = GraphiteMath.add(graphite, 25, "minutes")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["minute"]).is_equal(25)

func test_add_hours_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	var result = GraphiteMath.add(graphite, 6, "hours")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["hour"]).is_equal(18)

func test_add_days_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	var result = GraphiteMath.add(graphite, 10, "days")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["day"]).is_equal(11)

func test_add_large_seconds():
	# Test adding seconds that should roll over to minutes/hours
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	GraphiteMath.add(graphite, 3665, "seconds")  # 1 hour, 1 minute, 5 seconds
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["hour"]).is_equal(13)
	assert_that(datetime["minute"]).is_equal(1)
	assert_that(datetime["second"]).is_equal(5)

func test_add_minutes_with_hour_overflow():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 23, "minute": 45, "second": 0}, {})
	GraphiteMath.add(graphite, 30, "minutes")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["day"]).is_equal(2)  # Should roll to next day
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(15)

func test_add_negative_amount():
	# Adding negative should act like subtraction
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 30, "second": 0}, {})
	GraphiteMath.add(graphite, -15, "minutes")
	
	assert_that(graphite.get_datetime()["minute"]).is_equal(15)

## Test Subtraction Operations ##

func test_sub_seconds_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 45}, {})
	var result = GraphiteMath.sub(graphite, 20, "seconds")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["second"]).is_equal(25)

func test_sub_minutes_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 30, "second": 0}, {})
	var result = GraphiteMath.sub(graphite, 15, "minutes")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["minute"]).is_equal(15)

func test_sub_hours_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 18, "minute": 0, "second": 0}, {})
	var result = GraphiteMath.sub(graphite, 4, "hours")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["hour"]).is_equal(14)

func test_sub_days_directly():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var result = GraphiteMath.sub(graphite, 7, "days")
	
	assert_that(result).is_same(graphite)
	assert_that(graphite.get_datetime()["day"]).is_equal(8)

func test_sub_with_underflow():
	# Test subtracting that causes day underflow
	var graphite = Graphite.from_dict({"year": 2024, "month": 2, "day": 1, "hour": 1, "minute": 0, "second": 0}, {})
	GraphiteMath.sub(graphite, 2, "hours")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(1)  # Should roll back to January
	assert_that(datetime["day"]).is_equal(31)   # January 31st
	assert_that(datetime["hour"]).is_equal(23)

func test_sub_negative_amount():
	# Subtracting negative should act like addition
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 15, "second": 0}, {})
	GraphiteMath.sub(graphite, -10, "minutes")
	
	assert_that(graphite.get_datetime()["minute"]).is_equal(25)

## Test Default Parameters ##

func test_add_default_unit():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	GraphiteMath.add(graphite, 30)  # Should default to "seconds"
	
	assert_that(graphite.get_datetime()["second"]).is_equal(30)

func test_sub_default_unit():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 45}, {})
	GraphiteMath.sub(graphite, 15)  # Should default to "seconds"
	
	assert_that(graphite.get_datetime()["second"]).is_equal(30)

## Test Edge Cases ##

func test_add_zero_amount():
	var original_datetime = {"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}
	var graphite = Graphite.from_dict(original_datetime, {})
	GraphiteMath.add(graphite, 0, "hours")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(14)
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(45)

func test_sub_zero_amount():
	var original_datetime = {"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}
	var graphite = Graphite.from_dict(original_datetime, {})
	GraphiteMath.sub(graphite, 0, "days")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(6)
	assert_that(datetime["day"]).is_equal(15)
	assert_that(datetime["hour"]).is_equal(14)
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(45)

func test_add_month_boundary():
	# Test adding days at end of month
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 31, "hour": 12, "minute": 0, "second": 0}, {})
	GraphiteMath.add(graphite, 1, "days")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["month"]).is_equal(2)  # February
	assert_that(datetime["day"]).is_equal(1)

func test_add_year_boundary():
	# Test adding days at end of year
	var graphite = Graphite.from_dict({"year": 2024, "month": 12, "day": 31, "hour": 12, "minute": 0, "second": 0}, {})
	GraphiteMath.add(graphite, 1, "days")
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2025)
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(1)

## Test Large Values ##

func test_add_large_values():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})
	GraphiteMath.add(graphite, 365, "days")  # Add a full year
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)  # 2024 is leap year, so still in same year
	assert_that(datetime["month"]).is_equal(12)
	assert_that(datetime["day"]).is_equal(31)

func test_sub_large_values():
	var graphite = Graphite.from_dict({"year": 2025, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})
	GraphiteMath.sub(graphite, 365, "days")  # Subtract a full year
	
	var datetime = graphite.get_datetime()
	assert_that(datetime["year"]).is_equal(2024)
	assert_that(datetime["month"]).is_equal(1)
	assert_that(datetime["day"]).is_equal(2)  # 2024 is leap year, so Jan 2nd
