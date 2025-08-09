extends GdUnitTestSuite
class_name GraphiteQueriesTest

# Test suite for GraphiteQueries utility class
# Tests boolean query operations functionality

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Weekday/Weekend Queries ##

func test_isWeekday_monday():
	# January 1, 2024 is a Monday
	var monday = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekday(monday)).is_true()

func test_isWeekday_tuesday():
	# January 2, 2024 is a Tuesday
	var tuesday = Graphite.from_dict({"year": 2024, "month": 1, "day": 2, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekday(tuesday)).is_true()

func test_isWeekday_friday():
	# January 5, 2024 is a Friday
	var friday = Graphite.from_dict({"year": 2024, "month": 1, "day": 5, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekday(friday)).is_true()

func test_isWeekday_saturday():
	# January 6, 2024 is a Saturday
	var saturday = Graphite.from_dict({"year": 2024, "month": 1, "day": 6, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekday(saturday)).is_false()

func test_isWeekday_sunday():
	# January 7, 2024 is a Sunday
	var sunday = Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekday(sunday)).is_false()

func test_isWeekend_saturday():
	# January 6, 2024 is a Saturday
	var saturday = Graphite.from_dict({"year": 2024, "month": 1, "day": 6, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekend(saturday)).is_true()

func test_isWeekend_sunday():
	# January 7, 2024 is a Sunday
	var sunday = Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekend(sunday)).is_true()

func test_isWeekend_monday():
	# January 1, 2024 is a Monday
	var monday = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isWeekend(monday)).is_false()

## Test Relative Date Queries ##

func test_isYesterday():
	var _now = Graphite.now()
	var yesterday = Graphite.now().sub(1, "days")
	
	assert_that(GraphiteQueries.isYesterday(yesterday)).is_true()

func test_isToday():
	var now = Graphite.now()
	var today = Graphite.today()
	
	assert_that(GraphiteQueries.isToday(today)).is_true()

func test_isTomorrow():
	var _now = Graphite.now()
	var tomorrow = Graphite.now().add(1, "days")
	
	assert_that(GraphiteQueries.isTomorrow(tomorrow)).is_true()

func test_isFuture():
	var now = Graphite.now()
	var future = now.copy().add(1, "hours")
	
	assert_that(GraphiteQueries.isFuture(future)).is_true()

func test_isFuture_past_date():
	var now = Graphite.now()
	var past = now.copy().sub(1, "hours")
	
	assert_that(GraphiteQueries.isFuture(past)).is_false()

func test_isPast():
	var now = Graphite.now()
	var past = now.copy().sub(1, "hours")
	
	assert_that(GraphiteQueries.isPast(past)).is_true()

func test_isPast_future_date():
	var now = Graphite.now()
	var future = now.copy().add(1, "hours")
	
	assert_that(GraphiteQueries.isPast(future)).is_false()

## Test Leap Year Queries ##

func test_isLeapYear_2024():
	# 2024 is a leap year
	var leap_year = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLeapYear(leap_year)).is_true()

func test_isLeapYear_2023():
	# 2023 is not a leap year
	var normal_year = Graphite.from_dict({"year": 2023, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLeapYear(normal_year)).is_false()

func test_isLeapYear_2000():
	# 2000 is a leap year (divisible by 400)
	var leap_year = Graphite.from_dict({"year": 2000, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLeapYear(leap_year)).is_true()

func test_isLeapYear_1900():
	# 1900 is not a leap year (divisible by 100 but not 400)
	var normal_year = Graphite.from_dict({"year": 1900, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLeapYear(normal_year)).is_false()

func test_isLeapYear_2400():
	# 2400 is a leap year (divisible by 400)
	var leap_year = Graphite.from_dict({"year": 2400, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLeapYear(leap_year)).is_true()

## Test Month Comparison ##

func test_isSameMonth_same_month_same_year():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 20, "hour": 14, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteQueries.isSameMonth(date1, date2, true)).is_true()

func test_isSameMonth_different_month_same_year():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 7, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	
	assert_that(GraphiteQueries.isSameMonth(date1, date2, true)).is_false()

func test_isSameMonth_same_month_different_year():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 2023, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	
	assert_that(GraphiteQueries.isSameMonth(date1, date2, true)).is_false()

func test_isSameMonth_ignore_year():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 2023, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	
	assert_that(GraphiteQueries.isSameMonth(date1, date2, false)).is_true()

## Test Day of Week ##

func test_isDayOfWeek_monday():
	# January 1, 2024 is a Monday
	var monday = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isDayOfWeek(monday, GraphiteInterface.MONDAY)).is_true()
	assert_that(GraphiteQueries.isDayOfWeek(monday, GraphiteInterface.TUESDAY)).is_false()

func test_isDayOfWeek_sunday():
	# January 7, 2024 is a Sunday
	var sunday = Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isDayOfWeek(sunday, GraphiteInterface.SUNDAY)).is_true()
	assert_that(GraphiteQueries.isDayOfWeek(sunday, GraphiteInterface.SATURDAY)).is_false()

## Test Birthday ##

func test_isBirthday_same_date():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 1990, "month": 6, "day": 15, "hour": 8, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteQueries.isBirthday(date1, date2)).is_true()

func test_isBirthday_different_date():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 1990, "month": 6, "day": 16, "hour": 8, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteQueries.isBirthday(date1, date2)).is_false()

func test_isBirthday_different_month():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var date2 = Graphite.from_dict({"year": 1990, "month": 7, "day": 15, "hour": 8, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteQueries.isBirthday(date1, date2)).is_false()

func test_isBirthday_today():
	var today = Graphite.today()
	assert_that(GraphiteQueries.isBirthday(today, null)).is_true()

## Test Last of Month ##

func test_isLastOfMonth_january_31():
	var last_of_jan = Graphite.from_dict({"year": 2024, "month": 1, "day": 31, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLastOfMonth(last_of_jan)).is_true()

func test_isLastOfMonth_february_29_leap_year():
	var last_of_feb_leap = Graphite.from_dict({"year": 2024, "month": 2, "day": 29, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLastOfMonth(last_of_feb_leap)).is_true()

func test_isLastOfMonth_february_28_normal_year():
	var last_of_feb_normal = Graphite.from_dict({"year": 2023, "month": 2, "day": 28, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLastOfMonth(last_of_feb_normal)).is_true()

func test_isLastOfMonth_not_last_day():
	var not_last = Graphite.from_dict({"year": 2024, "month": 1, "day": 30, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLastOfMonth(not_last)).is_false()

func test_isLastOfMonth_april_30():
	var last_of_april = Graphite.from_dict({"year": 2024, "month": 4, "day": 30, "hour": 12, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isLastOfMonth(last_of_april)).is_true()

## Test Start/End of Day ##

func test_isStartOfDay_midnight():
	var midnight = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 0, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isStartOfDay(midnight, false)).is_true()

func test_isStartOfDay_not_midnight():
	var not_midnight = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 1, "minute": 0, "second": 0}, {})
	assert_that(GraphiteQueries.isStartOfDay(not_midnight, false)).is_false()

func test_isStartOfDay_with_seconds():
	var with_seconds = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 0, "minute": 0, "second": 30}, {})
	assert_that(GraphiteQueries.isStartOfDay(with_seconds, false)).is_false()

func test_isEndOfDay_end_of_day():
	var end_of_day = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 23, "minute": 59, "second": 59}, {})
	assert_that(GraphiteQueries.isEndOfDay(end_of_day, false)).is_true()

func test_isEndOfDay_not_end_of_day():
	var not_end = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 22, "minute": 59, "second": 59}, {})
	assert_that(GraphiteQueries.isEndOfDay(not_end, false)).is_false()

## Test Return Types ##

func test_all_query_methods_return_bool():
	var date = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var other_date = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteQueries.isWeekday(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isWeekend(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isYesterday(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isToday(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isTomorrow(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isFuture(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isPast(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isLeapYear(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isSameMonth(date, other_date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isDayOfWeek(date, GraphiteInterface.MONDAY)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isBirthday(date, other_date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isLastOfMonth(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isStartOfDay(date)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteQueries.isEndOfDay(date)).is_instance_of(TYPE_BOOL)

## Test Logical Consistency ##

func test_weekday_and_weekend_are_opposites():
	var dates = [
		Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 12, "minute": 0, "second": 0}, {}),  # Monday
		Graphite.from_dict({"year": 2024, "month": 1, "day": 6, "hour": 12, "minute": 0, "second": 0}, {}),  # Saturday
		Graphite.from_dict({"year": 2024, "month": 1, "day": 7, "hour": 12, "minute": 0, "second": 0}, {})   # Sunday
	]
	
	for date in dates:
		# A date cannot be both weekday and weekend
		var is_weekday = GraphiteQueries.isWeekday(date)
		var is_weekend = GraphiteQueries.isWeekend(date)
		assert_that(is_weekday).is_not_equal(is_weekend)

func test_future_and_past_consistency():
	var now = Graphite.now()
	var past_date = now.copy().sub(1, "hours")
	var future_date = now.copy().add(1, "hours")
	
	# Past dates should not be future
	assert_that(GraphiteQueries.isFuture(past_date)).is_false()
	assert_that(GraphiteQueries.isPast(past_date)).is_true()
	
	# Future dates should not be past
	assert_that(GraphiteQueries.isPast(future_date)).is_false()
	assert_that(GraphiteQueries.isFuture(future_date)).is_true()

## Test Edge Cases ##

func test_leap_year_edge_cases():
	# Test century years
	var year_1600 = Graphite.from_dict({"year": 1600, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})  # Leap
	var year_1700 = Graphite.from_dict({"year": 1700, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})  # Not leap
	var year_1800 = Graphite.from_dict({"year": 1800, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})  # Not leap
	var year_2000 = Graphite.from_dict({"year": 2000, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})  # Leap
	
	assert_that(GraphiteQueries.isLeapYear(year_1600)).is_true()
	assert_that(GraphiteQueries.isLeapYear(year_1700)).is_false()
	assert_that(GraphiteQueries.isLeapYear(year_1800)).is_false()
	assert_that(GraphiteQueries.isLeapYear(year_2000)).is_true()
