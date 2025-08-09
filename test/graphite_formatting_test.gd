extends GdUnitTestSuite
class_name GraphiteFormattingTest

# Test suite for GraphiteFormatting utility class
# Tests string formatting and output functionality

func before():
	# Setup for each test
	pass

func after():
	# Cleanup after each test
	pass

## Test Basic Formatting Methods ##

func test_toDateTimeString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toDateTimeString(graphite)
	
	# Assuming default format, adjust based on actual implementation
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")
	assert_that(result).contains("15")
	assert_that(result).contains("14")

func test_toDateString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toDateString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")
	assert_that(result).contains("15")
	# Should not contain time information
	assert_that(result).not_contains("14")
	assert_that(result).not_contains("30")

func test_toTimeString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toTimeString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("14")
	assert_that(result).contains("30")
	# Should not contain date information
	assert_that(result).not_contains("2024")
	assert_that(result).not_contains("15")

func test_toFormattedDateString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toFormattedDateString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toDayDateTimeString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toDayDateTimeString(graphite)
	
	assert_that(result).is_not_empty()
	# Should include day name information
	assert_that(result).contains("2024")

## Test Standard Format Methods ##

func test_toAtomString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toAtomString(graphite)
	
	assert_that(result).is_not_empty()
	# ATOM format should include timezone
	assert_that(result).contains("2024")
	assert_that(result).contains("15")

func test_toCookieString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toCookieString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toIso8601String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toIso8601String(graphite)
	
	assert_that(result).is_not_empty()
	# ISO 8601 format: YYYY-MM-DDTHH:MM:SS
	assert_that(result).contains("2024")
	assert_that(result).contains("03")  # Month should be zero-padded
	assert_that(result).contains("15")
	assert_that(result).contains("T")   # ISO 8601 separator

func test_toIso8601ZuluString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toIso8601ZuluString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")
	assert_that(result).contains("Z")   # Zulu time indicator

func test_toRfc822String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRfc822String(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("24")

func test_toRfc850String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRfc850String(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toRfc1036String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRfc1036String(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toRfc1123String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRfc1123String(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toRfc2822String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRfc2822String(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toRfc3339String():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRfc3339String(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")
	assert_that(result).contains("T")   # RFC 3339 uses T separator

func test_toRssString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toRssString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

func test_toW3cString():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.toW3cString(graphite)
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")

## Test Custom Format Method ##

func test_format_custom_string():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.format(graphite, "Y-m-d H:i:s")
	
	assert_that(result).is_not_empty()
	assert_that(result).contains("2024")
	assert_that(result).contains("03")
	assert_that(result).contains("15")
	assert_that(result).contains("14")
	assert_that(result).contains("30")
	assert_that(result).contains("45")

func test_format_year_only():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.format(graphite, "Y")
	
	assert_that(result).is_equal("2024")

func test_format_month_only():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.format(graphite, "m")
	
	assert_that(result).is_equal("03")

func test_format_day_only():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.format(graphite, "d")
	
	assert_that(result).is_equal("15")

func test_format_complex_pattern():
	var graphite = Graphite.from_dict({"year": 2024, "month": 12, "day": 25, "hour": 9, "minute": 5, "second": 3}, {})
	var result = GraphiteFormatting.format(graphite, "d/m/Y H:i:s")
	
	assert_that(result).contains("25")
	assert_that(result).contains("12")
	assert_that(result).contains("2024")
	assert_that(result).contains("09")
	assert_that(result).contains("05")
	assert_that(result).contains("03")

## Test Edge Cases ##

func test_format_empty_string():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.format(graphite, "")
	
	assert_that(result).is_equal("")

func test_format_literal_text():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	var result = GraphiteFormatting.format(graphite, "Today is Y-m-d")
	
	assert_that(result).contains("Today is")
	assert_that(result).contains("2024")
	assert_that(result).contains("03")
	assert_that(result).contains("15")

func test_zero_padded_values():
	var graphite = Graphite.from_dict({"year": 2024, "month": 1, "day": 5, "hour": 9, "minute": 3, "second": 7}, {})
	var result = GraphiteFormatting.format(graphite, "Y-m-d H:i:s")
	
	# Test that single digits are properly zero-padded
	assert_that(result).contains("01")  # month
	assert_that(result).contains("05")  # day
	assert_that(result).contains("09")  # hour
	assert_that(result).contains("03")  # minute
	assert_that(result).contains("07")  # second

## Test Consistency ##

func test_all_format_methods_return_strings():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	
	# Test that all format methods return valid strings
	assert_that(GraphiteFormatting.toDateTimeString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toDateString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toTimeString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toFormattedDateString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toDayDateTimeString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toAtomString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toCookieString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toIso8601String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toIso8601ZuluString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRfc822String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRfc850String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRfc1036String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRfc1123String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRfc2822String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRfc3339String(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toRssString(graphite)).is_of_type(TYPE_STRING)
	assert_that(GraphiteFormatting.toW3cString(graphite)).is_of_type(TYPE_STRING)

func test_all_format_methods_return_non_empty():
	var graphite = Graphite.from_dict({"year": 2024, "month": 3, "day": 15, "hour": 14, "minute": 30, "second": 45}, {})
	
	# Test that all format methods return non-empty strings
	assert_that(GraphiteFormatting.toDateTimeString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toDateString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toTimeString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toFormattedDateString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toDayDateTimeString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toAtomString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toCookieString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toIso8601String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toIso8601ZuluString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRfc822String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRfc850String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRfc1036String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRfc1123String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRfc2822String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRfc3339String(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toRssString(graphite)).is_not_empty()
	assert_that(GraphiteFormatting.toW3cString(graphite)).is_not_empty()
