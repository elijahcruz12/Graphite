extends GdUnitTestSuite
class_name GraphiteComparisonTest

# Test suite for GraphiteComparison utility class
# Tests date comparison operations functionality

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Equality Comparisons ##

func test_eq_same_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.eq(date1, date2)).is_true()

func test_eq_different_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.eq(date1, date2)).is_false()

func test_eq_different_years():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2023, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.eq(date1, date2)).is_false()

## Test Inequality Comparisons ##

func test_ne_same_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.ne(date1, date2)).is_false()

func test_ne_different_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.ne(date1, date2)).is_true()

## Test Greater Than Comparisons ##

func test_gt_later_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.gt(later, earlier)).is_true()

func test_gt_earlier_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.gt(earlier, later)).is_false()

func test_gt_same_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.gt(date1, date2)).is_false()

func test_gt_different_years():
	var date_2023 = Graphite.from_dict({"year": 2023, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date_2024 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.gt(date_2024, date_2023)).is_true()
	assert_that(GraphiteComparison.gt(date_2023, date_2024)).is_false()

func test_gt_different_months():
	var january = Graphite.from_dict({"year": 2024, "month": 1, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var february = Graphite.from_dict({"year": 2024, "month": 2, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.gt(february, january)).is_true()
	assert_that(GraphiteComparison.gt(january, february)).is_false()

func test_gt_different_days():
	var day_15 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var day_16 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.gt(day_16, day_15)).is_true()
	assert_that(GraphiteComparison.gt(day_15, day_16)).is_false()

func test_gt_different_hours():
	var hour_12 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var hour_13 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 13, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.gt(hour_13, hour_12)).is_true()
	assert_that(GraphiteComparison.gt(hour_12, hour_13)).is_false()

## Test Greater Than or Equal Comparisons ##

func test_gte_later_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.gte(later, earlier)).is_true()

func test_gte_same_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.gte(date1, date2)).is_true()

func test_gte_earlier_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.gte(earlier, later)).is_false()

## Test Less Than Comparisons ##

func test_lt_earlier_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.lt(earlier, later)).is_true()

func test_lt_later_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.lt(later, earlier)).is_false()

func test_lt_same_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.lt(date1, date2)).is_false()

## Test Less Than or Equal Comparisons ##

func test_lte_earlier_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.lte(earlier, later)).is_true()

func test_lte_same_datetime():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.lte(date1, date2)).is_true()

func test_lte_later_datetime():
	var earlier = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var later = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 46}, {})
	
	assert_that(GraphiteComparison.lte(later, earlier)).is_false()

## Test Edge Cases ##

func test_comparison_with_different_timezones():
	var tz1 = {"bias": -480}  # UTC-8
	var tz2 = {"bias": -300}  # UTC-5
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, tz1)
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, tz2)
	
	# The comparison behavior depends on implementation
	# This test ensures the function doesn't crash with different timezones
	var result = GraphiteComparison.eq(date1, date2)
	assert_that(result).is_instance_of(TYPE_BOOL)

func test_comparison_year_boundaries():
	var end_of_year = Graphite.from_dict({"year": 2023, "month": 12, "day": 31, "hour": 23, "minute": 59, "second": 59}, {})
	var start_of_year = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})
	
	assert_that(GraphiteComparison.lt(end_of_year, start_of_year)).is_true()
	assert_that(GraphiteComparison.gt(start_of_year, end_of_year)).is_true()

func test_comparison_leap_year():
	var feb_28_2023 = Graphite.from_dict({"year": 2023, "month": 2, "day": 28, "hour": 12, "minute": 0, "second": 0}, {})  # Not leap year
	var feb_29_2024 = Graphite.from_dict({"year": 2024, "month": 2, "day": 29, "hour": 12, "minute": 0, "second": 0}, {})  # Leap year
	
	assert_that(GraphiteComparison.lt(feb_28_2023, feb_29_2024)).is_true()
	assert_that(GraphiteComparison.gt(feb_29_2024, feb_28_2023)).is_true()

## Test Return Types ##

func test_all_comparison_methods_return_bool():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	
	assert_that(GraphiteComparison.eq(date1, date2)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteComparison.ne(date1, date2)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteComparison.gt(date1, date2)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteComparison.gte(date1, date2)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteComparison.lt(date1, date2)).is_instance_of(TYPE_BOOL)
	assert_that(GraphiteComparison.lte(date1, date2)).is_instance_of(TYPE_BOOL)

## Test Logical Consistency ##

func test_eq_and_ne_are_opposites():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	
	# eq and ne should be logical opposites
	assert_that(GraphiteComparison.eq(date1, date2)).is_not_equal(GraphiteComparison.ne(date1, date2))

func test_gt_and_lte_are_opposites():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	
	# gt and lte should be logical opposites
	assert_that(GraphiteComparison.gt(date1, date2)).is_not_equal(GraphiteComparison.lte(date1, date2))

func test_lt_and_gte_are_opposites():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	
	# lt and gte should be logical opposites
	assert_that(GraphiteComparison.lt(date1, date2)).is_not_equal(GraphiteComparison.gte(date1, date2))

func test_gte_includes_gt_and_eq():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	var date3 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	# gte should be true when gt is true
	if GraphiteComparison.gt(date2, date1):
		assert_that(GraphiteComparison.gte(date2, date1)).is_true()
	
	# gte should be true when eq is true
	if GraphiteComparison.eq(date1, date3):
		assert_that(GraphiteComparison.gte(date1, date3)).is_true()

func test_lte_includes_lt_and_eq():
	var date1 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	var date2 = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 12, "minute": 30, "second": 45}, {})
	var date3 = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 30, "second": 45}, {})
	
	# lte should be true when lt is true
	if GraphiteComparison.lt(date1, date2):
		assert_that(GraphiteComparison.lte(date1, date2)).is_true()
	
	# lte should be true when eq is true
	if GraphiteComparison.eq(date1, date3):
		assert_that(GraphiteComparison.lte(date1, date3)).is_true()
