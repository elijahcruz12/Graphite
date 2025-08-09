extends GdUnitTestSuite
class_name GraphiteTest

# Test suite for the main Graphite class functionality
# This covers static creation methods, basic operations, and public API

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Static Creation Methods ##

func test_now_creates_valid_graphite_instance():
	var graphite = Graphite.now()
	assert_that(graphite).is_not_null()
	assert_that(graphite).is_class("Graphite")
	assert_that(graphite.get_datetime()).is_not_empty()
	assert_that(graphite.get_timezone()).is_not_empty()

func test_from_dict_creates_graphite_with_custom_datetime():
	var custom_datetime = {"year": 2024, "month": 12, "day": 25, "hour": 15, "minute": 30, "second": 45}
	var custom_timezone = {"bias": -480}  # UTC-8
	var graphite = Graphite.from_dict(custom_datetime, custom_timezone)
	
	assert_that(graphite).is_not_null()
	assert_that(graphite.get_datetime()["year"]).is_equal(2024)
	assert_that(graphite.get_datetime()["month"]).is_equal(12)
	assert_that(graphite.get_datetime()["day"]).is_equal(25)
	assert_that(graphite.get_datetime()["hour"]).is_equal(15)

func test_today_creates_start_of_today():
	var graphite = Graphite.today()
	var datetime = graphite.get_datetime()
	
	assert_that(graphite).is_not_null()
	assert_that(datetime["hour"]).is_equal(0)
	assert_that(datetime["minute"]).is_equal(0)
	assert_that(datetime["second"]).is_equal(0)

func test_tomorrow_creates_start_of_tomorrow():
	var today = Graphite.today()
	var tomorrow = Graphite.tomorrow()
	
	assert_that(tomorrow).is_not_null()
	assert_that(tomorrow.get_datetime()["day"]).is_equal(today.get_datetime()["day"] + 1)
	assert_that(tomorrow.get_datetime()["hour"]).is_equal(0)
	assert_that(tomorrow.get_datetime()["minute"]).is_equal(0)
	assert_that(tomorrow.get_datetime()["second"]).is_equal(0)

func test_yesterday_creates_start_of_yesterday():
	var today = Graphite.today()
	var yesterday = Graphite.yesterday()
	
	assert_that(yesterday).is_not_null()
	assert_that(yesterday.get_datetime()["day"]).is_equal(today.get_datetime()["day"] - 1)
	assert_that(yesterday.get_datetime()["hour"]).is_equal(0)
	assert_that(yesterday.get_datetime()["minute"]).is_equal(0)
	assert_that(yesterday.get_datetime()["second"]).is_equal(0)

## Test Math Operations ##

func test_add_seconds():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	graphite.add(30, "seconds")
	
	assert_that(graphite.get_datetime()["second"]).is_equal(30)

func test_add_minutes():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	graphite.add(15, "minutes")
	
	assert_that(graphite.get_datetime()["minute"]).is_equal(15)

func test_add_hours():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	graphite.add(3, "hours")
	
	assert_that(graphite.get_datetime()["hour"]).is_equal(15)

func test_add_days():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	graphite.add(5, "days")
	
	assert_that(graphite.get_datetime()["day"]).is_equal(6)

func test_sub_seconds():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 30}, {})
	graphite.sub(15, "seconds")
	
	assert_that(graphite.get_datetime()["second"]).is_equal(15)

func test_sub_minutes():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 30, "second": 0}, {})
	graphite.sub(10, "minutes")
	
	assert_that(graphite.get_datetime()["minute"]).is_equal(20)

func test_sub_hours():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 15, "minute": 0, "second": 0}, {})
	graphite.sub(2, "hours")
	
	assert_that(graphite.get_datetime()["hour"]).is_equal(13)

func test_sub_days():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 10, "hour": 12, "minute": 0, "second": 0}, {})
	graphite.sub(3, "days")
	
	assert_that(graphite.get_datetime()["day"]).is_equal(7)

## Test Copy/Clone Operations ##

func test_copy_creates_new_instance():
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 10, "minute": 30, "second": 45}, {})
	var copy = original.copy()
	
	assert_that(copy).is_not_same(original)
	assert_that(copy.get_datetime()["year"]).is_equal(original.get_datetime()["year"])
	assert_that(copy.get_datetime()["month"]).is_equal(original.get_datetime()["month"])
	assert_that(copy.get_datetime()["day"]).is_equal(original.get_datetime()["day"])

func test_clone_creates_new_instance():
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 10, "minute": 30, "second": 45}, {})
	var clone = original.clone()
	
	assert_that(clone).is_not_same(original)
	assert_that(clone.get_datetime()["year"]).is_equal(original.get_datetime()["year"])
	assert_that(clone.get_datetime()["month"]).is_equal(original.get_datetime()["month"])
	assert_that(clone.get_datetime()["day"]).is_equal(original.get_datetime()["day"])

## Test Basic Formatting ##

func test_toString_format():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = graphite.toString()
	
	assert_that(result).is_equal("2024-03-15 14:30:45")

## Test Method Chaining ##

func test_method_chaining():
	var result = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {}) \
		.add(1, "hours") \
		.add(30, "minutes") \
		.add(15, "seconds")
	
	var datetime = result.get_datetime()
	assert_that(datetime["hour"]).is_equal(1)
	assert_that(datetime["minute"]).is_equal(30)
	assert_that(datetime["second"]).is_equal(15)

## Test Query Methods ##

func test_isWeekday():
	# Create a Monday (weekday)
	var monday = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})  # Jan 1, 2024 is Monday
	var sunday = Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 12, "minute": 0, "second": 0}, {})  # Jan 7, 2024 is Sunday
	
	assert_that(monday.isWeekday()).is_true()
	assert_that(sunday.isWeekday()).is_false()

func test_isWeekend():
	# Create a Sunday (weekend)
	var sunday = Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 12, "minute": 0, "second": 0}, {})  # Jan 7, 2024 is Sunday
	var monday = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})  # Jan 1, 2024 is Monday
	
	assert_that(sunday.isWeekend()).is_true()
	assert_that(monday.isWeekend()).is_false()

func test_isLeapYear():
	var leap_year = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})  # 2024 is a leap year
	var normal_year = Graphite.from_dict({"year": 2023, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})  # 2023 is not a leap year
	
	assert_that(leap_year.isLeapYear()).is_true()
	assert_that(normal_year.isLeapYear()).is_false()

## Test Comparison Methods ##

func test_eq_comparison():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date3 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 0, "second": 0}, {})
	
	assert_that(date1.eq(date2)).is_true()
	assert_that(date1.eq(date3)).is_false()

func test_gt_comparison():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 0, "second": 0}, {})
	
	assert_that(later.gt(earlier)).is_true()
	assert_that(earlier.gt(later)).is_false()

func test_lt_comparison():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 0, "second": 0}, {})
	
	assert_that(earlier.lt(later)).is_true()
	assert_that(later.lt(earlier)).is_false()

## Test Edge Cases ##

func test_add_with_overflow():
	# Test adding time that causes day overflow
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 31, "hour": 23, "minute": 30, "second": 0}, {})
	graphite.add(1, "hours")
	
	# Should roll over to next day
	assert_that(graphite.get_datetime()["day"]).is_equal(1)  # February 1st
	assert_that(graphite.get_datetime()["month"]).is_equal(2)  # February

func test_default_unit_is_seconds():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	graphite.add(30)  # Should default to seconds
	
	assert_that(graphite.get_datetime()["second"]).is_equal(30)