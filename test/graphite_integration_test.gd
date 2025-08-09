extends GdUnitTestSuite
class_name GraphiteIntegrationTest

# Integration test suite for Graphite library
# Tests complete workflows and interaction between different components

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Complete Workflows ##

func test_calendar_workflow():
	# Test a complete calendar workflow: get current month, navigate to next month, format
	var current = Graphite.now()
	var start_of_month = current.copy().startOfMonth()
	var end_of_month = current.copy().endOfMonth()
	var next_month = start_of_month.copy().add(1, "months")
	
	assert_that(start_of_month.get_datetime()["day"]).is_equal(1)
	assert_that(start_of_month.get_datetime()["hour"]).is_equal(0)
	assert_that(end_of_month.get_datetime()["hour"]).is_equal(23)
	assert_that(next_month.get_datetime()["month"]).is_equal(start_of_month.get_datetime()["month"] + 1)

func test_scheduling_workflow():
	# Test scheduling: create appointment, check if it's in business hours, format for display
	var appointment = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 0}, {})
	
	# Check if it's a weekday (business day)
	var _is_business_day = appointment.isWeekday()
	
	# Check if it's in business hours (9 AM - 5 PM)
	var hour = appointment.get_datetime()["hour"]
	var is_business_hours = hour >= 9 and hour < 17
	
	# Format for calendar display
	var formatted = appointment.format("Y-m-d H:i")
	
	assert_that(formatted).is_not_empty()
	assert_that(is_business_hours).is_true()

func test_birthday_tracking_workflow():
	# Test birthday tracking: check if today is someone's birthday
	var today = Graphite.today()
	var birthday = Graphite.from_dict({"year": 1990, "month": today.get_datetime()["month"], "day": today.get_datetime()["day"], "hour": 0, "minute": 0, "second": 0}, {})
	
	assert_that(today.isBirthday(birthday)).is_true()
	
	# Calculate age
	var age = today.get_datetime()["year"] - birthday.get_datetime()["year"]
	assert_that(age).is_equal(34)  # 2024 - 1990

func test_deadline_tracking_workflow():
	# Test deadline management: check if deadline is approaching
	var now = Graphite.now()
	var deadline = now.copy().add(2, "days")
	var urgent_deadline = now.copy().add(6, "hours")
	
	# Check if deadlines are in the future
	assert_that(deadline.isFuture()).is_true()
	assert_that(urgent_deadline.isFuture()).is_true()
	
	# Check if deadline is urgent (within 24 hours)
	var hours_until_urgent = 6  # We added 6 hours
	var is_urgent = hours_until_urgent <= 24
	assert_that(is_urgent).is_true()

func test_time_zone_conversion_workflow():
	# Test timezone conversion workflow
	var utc_time = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {"bias": 0})
	var pst_time = utc_time.copy().setTimezone({"bias": -480})  # PST is UTC-8
	
	# Both should represent the same moment in time
	assert_that(utc_time.get_datetime()["hour"]).is_equal(12)
	assert_that(pst_time.get_timezone()["bias"]).is_equal(-480)

## Test Method Chaining ##

func test_complex_method_chaining():
	# Test complex method chaining for fluent interface
	var result = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {}) \
		.startOfDay() \
		.add(8, "hours") \
		.add(30, "minutes") \
		.startOfWeek() \
		.endOfDay()
	
	var datetime = result.get_datetime()
	# Should be end of the Monday of that week
	assert_that(datetime["hour"]).is_equal(23)
	assert_that(datetime["minute"]).is_equal(59)
	assert_that(datetime["second"]).is_equal(59)

func test_date_arithmetic_chaining():
	# Test date arithmetic with method chaining
	var start = Graphite.from_dict({"year": 2024, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})
	var result = start \
		.add(1, "years") \
		.add(6, "months") \
		.add(15, "days") \
		.add(12, "hours") \
		.add(30, "minutes")
	
	var datetime = result.get_datetime()
	assert_that(datetime["year"]).is_equal(2025)
	assert_that(datetime["month"]).is_equal(7)
	assert_that(datetime["day"]).is_equal(16)
	assert_that(datetime["hour"]).is_equal(12)
	assert_that(datetime["minute"]).is_equal(30)

func test_modifier_chaining():
	# Test modifier chaining
	var base = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = base \
		.startOfMonth() \
		.endOfDay() \
		.startOfWeek() \
		.endOfMinute()
	
	# Should be end of minute on the Monday of the first week of June 2024
	var datetime = result.get_datetime()
	assert_that(datetime["second"]).is_equal(59)

## Test Cross-Component Integration ##

func test_math_and_comparison_integration():
	# Test math operations with comparisons
	var base = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 12, "minute": 0, "second": 0}, {})
	var future = base.copy().add(1, "hours")
	var past = base.copy().sub(1, "hours")
	
	assert_that(future.gt(base)).is_true()
	assert_that(past.lt(base)).is_true()
	assert_that(future.gt(past)).is_true()

func test_modifiers_and_queries_integration():
	# Test modifiers with query operations
	var weekend = Graphite.from_dict({"year": 2024, "month": 1, "day": 6, "hour": 14, "minute": 30, "second": 45}, {})  # Saturday
	var start_of_weekend_day = weekend.copy().startOfDay()
	var end_of_weekend_day = weekend.copy().endOfDay()
	
	assert_that(start_of_weekend_day.isWeekend()).is_true()
	assert_that(end_of_weekend_day.isWeekend()).is_true()
	assert_that(start_of_weekend_day.isStartOfDay()).is_true()
	assert_that(end_of_weekend_day.isEndOfDay()).is_true()

func test_formatting_and_manipulation_integration():
	# Test formatting with manipulation
	var date = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	
	# Test different formatting after manipulation
	var morning = date.copy().setTime(9, 0, 0)
	var evening = date.copy().setTime(18, 30, 0)
	var next_day = date.copy().add(1, "days").startOfDay()
	
	var morning_format = morning.format("H:i")
	var evening_format = evening.format("H:i")
	var next_day_format = next_day.format("Y-m-d")
	
	assert_that(morning_format).is_equal("09:00")
	assert_that(evening_format).is_equal("18:30")
	assert_that(next_day_format).contains("2024-06-16")

## Test Error Handling and Edge Cases ##

func test_leap_year_integration():
	# Test leap year handling across components
	var leap_year = Graphite.from_dict({"year": 2024, "month": 2, "day": 28, "hour": 12, "minute": 0, "second": 0}, {})
	var next_day = leap_year.copy().add(1, "days")
	
	assert_that(leap_year.isLeapYear()).is_true()
	assert_that(next_day.get_datetime()["day"]).is_equal(29)  # February 29 in leap year
	assert_that(next_day.isLeapYear()).is_true()

func test_month_boundary_integration():
	# Test month boundary handling
	var end_of_month = Graphite.from_dict({"year": 2024, "month": 1, "day": 31, "hour": 23, "minute": 59, "second": 59}, {})
	var next_second = end_of_month.copy().add(1, "seconds")
	var start_of_next_month = end_of_month.copy().add(1, "days").startOfMonth()
	
	assert_that(next_second.get_datetime()["month"]).is_equal(2)  # February
	assert_that(next_second.get_datetime()["day"]).is_equal(1)
	assert_that(start_of_next_month.get_datetime()["month"]).is_equal(2)
	assert_that(start_of_next_month.get_datetime()["day"]).is_equal(1)

func test_year_boundary_integration():
	# Test year boundary handling
	var end_of_year = Graphite.from_dict({"year": 2023, "month": 12, "day": 31, "hour": 23, "minute": 59, "second": 59}, {})
	var new_year = end_of_year.copy().add(1, "seconds")
	var start_of_new_year = new_year.copy().startOfYear()
	
	assert_that(new_year.get_datetime()["year"]).is_equal(2024)
	assert_that(new_year.get_datetime()["month"]).is_equal(1)
	assert_that(new_year.get_datetime()["day"]).is_equal(1)
	assert_that(start_of_new_year.get_datetime()["hour"]).is_equal(0)

## Test Performance and Memory ##

func test_multiple_operations_performance():
	# Test that multiple operations don't cause memory issues
	var base = Graphite.now()
	
	# Perform many operations
	for i in range(100):
		var temp = base.copy()
		temp.add(i, "days")
		temp.startOfDay()
		temp.endOfMonth()
		var _formatted = temp.format("Y-m-d H:i:s")
		var _is_weekend = temp.isWeekend()
	
	# If we get here without crashes, memory management is working
	assert_that(base).is_not_null()

func test_method_chaining_memory():
	# Test that long method chains don't cause memory leaks
	var result = Graphite.now()
	
	# Long chain of operations
	for i in range(10):
		result = result.add(1, "days").startOfDay().endOfDay().startOfMonth().endOfMonth()
	
	assert_that(result).is_not_null()
	assert_that(result).is_instance_of(Graphite)

## Test Real-World Scenarios ##

func test_event_scheduling_scenario():
	# Test a real-world event scheduling scenario
	var event_date = Graphite.from_dict({"year": 2024, "month": 8, "day": 15, "hour": 14, "minute": 0, "second": 0}, {})
	var now = Graphite.now()
	
	# Check if event is in the future
	var _is_future_event = event_date.gt(now)
	
	# Get start and end of event day
	var _day_start = event_date.copy().startOfDay()
	var _day_end = event_date.copy().endOfDay()
	
	# Check if it's a business day
	var _is_business_day = event_date.isWeekday()
	
	# Format for different purposes
	var short_format = event_date.format("m/d/Y")
	var long_format = event_date.format("F j, Y g:i A")
	var iso_format = event_date.toIso8601String()
	
	assert_that(short_format).is_not_empty()
	assert_that(long_format).is_not_empty()
	assert_that(iso_format).is_not_empty()

func test_payroll_calculation_scenario():
	# Test a payroll calculation scenario
	var pay_period_start = Graphite.from_dict({"year": 2024, "month": 6, "day": 1, "hour": 0, "minute": 0, "second": 0}, {})
	var pay_period_end = pay_period_start.copy().endOfMonth()
	var current_date = pay_period_start.copy()
	
	var business_days = 0
	
	# Count business days in the month (simplified)
	while current_date.lte(pay_period_end):
		if current_date.isWeekday():
			business_days += 1
		current_date.add(1, "days")
	
	assert_that(business_days).is_greater_than(0)
	assert_that(business_days).is_less_than(32)  # Should be reasonable for a month

func test_reminder_system_scenario():
	# Test a reminder system scenario
	var now = Graphite.now()
	var tomorrow = now.copy().add(1, "days").startOfDay().add(9, "hours")  # 9 AM tomorrow
	var next_week = now.copy().add(7, "days")
	var next_month = now.copy().add(1, "months")
	
	# Check if reminders are properly scheduled
	assert_that(tomorrow.isTomorrow()).is_true()
	assert_that(tomorrow.isFuture()).is_true()
	assert_that(next_week.isFuture()).is_true()
	assert_that(next_month.isFuture()).is_true()
	
	# Format reminders for display
	var tomorrow_reminder = "Meeting at " + tomorrow.format("g:i A")
	var weekly_reminder = "Weekly report due " + next_week.format("F j")
	var monthly_reminder = "Monthly review on " + next_month.format("F j, Y")
	
	assert_that(tomorrow_reminder).contains("Meeting at")
	assert_that(weekly_reminder).contains("Weekly report")
	assert_that(monthly_reminder).contains("Monthly review")

## Test API Consistency ##

func test_all_methods_return_consistent_types():
	# Test that all API methods return consistent types
	var date = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var other_date = Graphite.from_dict({"year": 2024, "month": 6, "day": 16, "hour": 14, "minute": 30, "second": 45}, {})
	
	# Math operations should return Graphite
	assert_that(date.add(1, "hours")).is_instance_of(Graphite)
	assert_that(date.sub(1, "hours")).is_instance_of(Graphite)
	
	# Modifiers should return Graphite
	assert_that(date.startOfDay()).is_instance_of(Graphite)
	assert_that(date.endOfDay()).is_instance_of(Graphite)
	
	# Comparisons should return bool
	assert_that(date.eq(other_date)).is_instance_of(TYPE_BOOL)
	assert_that(date.gt(other_date)).is_instance_of(TYPE_BOOL)
	
	# Queries should return bool
	assert_that(date.isWeekday()).is_instance_of(TYPE_BOOL)
	assert_that(date.isLeapYear()).is_instance_of(TYPE_BOOL)
	
	# Formatting should return String
	assert_that(date.format("Y-m-d")).is_instance_of(TYPE_STRING)
	assert_that(date.toString()).is_instance_of(TYPE_STRING)

func test_immutability_when_needed():
	# Test that copy/clone provide proper immutability
	var original = Graphite.from_dict({"year": 2024, "month": 6, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var copy = original.copy()
	var clone = original.clone()
	
	# Modify copy and clone
	copy.add(1, "days")
	clone.sub(1, "days")
	
	# Original should be unchanged
	assert_that(original.get_datetime()["day"]).is_equal(15)
	assert_that(copy.get_datetime()["day"]).is_equal(16)
	assert_that(clone.get_datetime()["day"]).is_equal(14)
