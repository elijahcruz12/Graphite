# API Reference

Complete reference for all Graphite methods and properties.

## Table of Contents

- [Static Creation Methods](#static-creation-methods)
- [Math Operations](#math-operations)
- [Manipulation Methods](#manipulation-methods)
- [Formatting Methods](#formatting-methods)
- [Modifier Methods](#modifier-methods)
- [Query Methods](#query-methods)
- [Comparison Methods](#comparison-methods)
- [Accessor Methods](#accessor-methods)
- [Constants](#constants)

For comprehensive examples and detailed coverage of addition and subtraction operations, see [Addition and Subtraction](addition-subtraction.md).

## Static Creation Methods

### `Graphite.now(timezone_dict: Dictionary = {}) -> Graphite`
Creates a new Graphite instance with the current date and time.

**Parameters:**
- `timezone_dict` (optional): Dictionary containing timezone information

**Returns:** `Graphite` instance

**Example:**
```gdscript
var now = Graphite.now()
var now_utc = Graphite.now({"name": "UTC"})
```

### `Graphite.from_dict(datetime_dict: Dictionary, timezone_dict: Dictionary) -> Graphite`
Creates a new Graphite instance from the given dictionaries.

**Parameters:**
- `datetime_dict`: Dictionary with datetime information (year, month, day, hour, minute, second)
- `timezone_dict`: Dictionary with timezone information

**Returns:** `Graphite` instance

**Example:**
```gdscript
var custom_date = Graphite.from_dict(
    {"year": 2025, "month": 12, "day": 25, "hour": 9, "minute": 30, "second": 0},
    {"name": "UTC"}
)
```

### `Graphite.today(timezone_dict: Dictionary = {}) -> Graphite`
Creates a new Graphite instance representing the start of today (00:00:00).

**Example:**
```gdscript
var today = Graphite.today()
```

### `Graphite.tomorrow(timezone_dict: Dictionary = {}) -> Graphite`
Creates a new Graphite instance representing the start of tomorrow (00:00:00).

**Example:**
```gdscript
var tomorrow = Graphite.tomorrow()
```

### `Graphite.yesterday(timezone_dict: Dictionary = {}) -> Graphite`
Creates a new Graphite instance representing the start of yesterday (00:00:00).

**Example:**
```gdscript
var yesterday = Graphite.yesterday()
```

## Math Operations

### Generic Math Functions

#### `add(amount: int, unit: String = "seconds") -> Graphite`
Adds the specified amount of time to the Graphite instance.

**Parameters:**
- `amount`: The amount to add
- `unit`: Unit of measurement (see supported units below)

**Returns:** Modified `Graphite` instance (chainable)

**Supported units:** `"microseconds"`, `"milliseconds"`, `"seconds"`, `"minutes"`, `"hours"`, `"days"`, `"weeks"`, `"weekdays"`, `"months"`, `"quarters"`, `"years"`, `"decades"`, `"centuries"`, `"millenniums"`, `"millennia"`

**Example:**
```gdscript
var future = Graphite.now().add(5, "minutes").add(2, "hours")
var business_days = Graphite.now().add(5, "weekdays")  # Skips weekends
```

#### `sub(amount: int, unit: String = "seconds") -> Graphite`
Subtracts the specified amount of time from the Graphite instance.

**Parameters:**
- `amount`: The amount to subtract
- `unit`: Unit of measurement (same supported units as `add()`)

**Returns:** Modified `Graphite` instance (chainable)

**Example:**
```gdscript
var past = Graphite.now().sub(30, "minutes").sub(1, "days")
var business_past = Graphite.now().sub(3, "weekdays")
```

### Addition Functions (Plural)

#### Time Units
- `addMicroseconds(amount: int) -> Graphite` - Add microseconds
- `addMilliseconds(amount: int) -> Graphite` - Add milliseconds  
- `addSeconds(amount: int) -> Graphite` - Add seconds
- `addMinutes(amount: int) -> Graphite` - Add minutes
- `addHours(amount: int) -> Graphite` - Add hours

#### Date Units
- `addDays(amount: int) -> Graphite` - Add days
- `addWeeks(amount: int) -> Graphite` - Add weeks
- `addWeekdays(amount: int) -> Graphite` - Add weekdays (Monday-Friday only)
- `addMonths(amount: int) -> Graphite` - Add months
- `addQuarters(amount: int) -> Graphite` - Add quarters
- `addYears(amount: int) -> Graphite` - Add years

#### Large Time Units
- `addDecades(amount: int) -> Graphite` - Add decades
- `addCenturies(amount: int) -> Graphite` - Add centuries
- `addMillenniums(amount: int) -> Graphite` - Add millenniums
- `addMillennia(amount: int) -> Graphite` - Add millennia (alternative spelling)

### Addition Functions (Singular)

#### Time Units
- `addMicrosecond() -> Graphite` - Add 1 microsecond
- `addMillisecond() -> Graphite` - Add 1 millisecond
- `addSecond() -> Graphite` - Add 1 second
- `addMinute() -> Graphite` - Add 1 minute
- `addHour() -> Graphite` - Add 1 hour

#### Date Units
- `addDay() -> Graphite` - Add 1 day
- `addWeek() -> Graphite` - Add 1 week
- `addWeekday() -> Graphite` - Add 1 weekday (Monday-Friday only)
- `addMonth() -> Graphite` - Add 1 month
- `addQuarter() -> Graphite` - Add 1 quarter
- `addYear() -> Graphite` - Add 1 year

#### Large Time Units
- `addDecade() -> Graphite` - Add 1 decade
- `addCentury() -> Graphite` - Add 1 century  
- `addMillennium() -> Graphite` - Add 1 millennium

### Subtraction Functions (Plural)

#### Time Units
- `subMicroseconds(amount: int) -> Graphite` - Subtract microseconds
- `subMilliseconds(amount: int) -> Graphite` - Subtract milliseconds
- `subSeconds(amount: int) -> Graphite` - Subtract seconds
- `subMinutes(amount: int) -> Graphite` - Subtract minutes
- `subHours(amount: int) -> Graphite` - Subtract hours

#### Date Units
- `subDays(amount: int) -> Graphite` - Subtract days
- `subWeeks(amount: int) -> Graphite` - Subtract weeks
- `subWeekdays(amount: int) -> Graphite` - Subtract weekdays (Monday-Friday only)
- `subMonths(amount: int) -> Graphite` - Subtract months
- `subQuarters(amount: int) -> Graphite` - Subtract quarters
- `subYears(amount: int) -> Graphite` - Subtract years

#### Large Time Units
- `subDecades(amount: int) -> Graphite` - Subtract decades
- `subCenturies(amount: int) -> Graphite` - Subtract centuries
- `subMillenniums(amount: int) -> Graphite` - Subtract millenniums
- `subMillennia(amount: int) -> Graphite` - Subtract millennia (alternative spelling)

### Subtraction Functions (Singular)

#### Time Units
- `subMicrosecond() -> Graphite` - Subtract 1 microsecond
- `subMillisecond() -> Graphite` - Subtract 1 millisecond
- `subSecond() -> Graphite` - Subtract 1 second
- `subMinute() -> Graphite` - Subtract 1 minute
- `subHour() -> Graphite` - Subtract 1 hour

#### Date Units
- `subDay() -> Graphite` - Subtract 1 day
- `subWeek() -> Graphite` - Subtract 1 week
- `subWeekday() -> Graphite` - Subtract 1 weekday (Monday-Friday only)
- `subMonth() -> Graphite` - Subtract 1 month
- `subQuarter() -> Graphite` - Subtract 1 quarter
- `subYear() -> Graphite` - Subtract 1 year

#### Large Time Units
- `subDecade() -> Graphite` - Subtract 1 decade
- `subCentury() -> Graphite` - Subtract 1 century
- `subMillennium() -> Graphite` - Subtract 1 millennium

### Weekdays Functionality

The `addWeekdays()`, `addWeekday()`, `subWeekdays()`, and `subWeekday()` functions only consider Monday through Friday as valid weekdays, automatically skipping weekends.

**Example:**
```gdscript
# If today is Thursday and you add 5 weekdays:
var thursday = Graphite.today()  # Assuming today is Thursday
var result = thursday.addWeekdays(5)
# Result: Thursday of next week (Thu->Fri->Mon->Tue->Wed->Thu)

# Business day calculations
var project_start = Graphite.today()
var phase1_deadline = project_start.addWeekdays(10)  # 10 business days later
```

## Manipulation Methods

### `copy() -> Graphite`
Creates a copy of the current instance.

**Returns:** New `Graphite` instance

### `clone() -> Graphite`
Alias for `copy()`. Creates a copy of the current instance.

### `setTime(hour: int, minute: int, second: int = 0, microseconds: int = 0) -> Graphite`
Sets the time component of the datetime.

**Parameters:**
- `hour`: Hour (0-23)
- `minute`: Minute (0-59)
- `second`: Second (0-59, optional)
- `microseconds`: Microseconds (optional, not used in Godot)

**Returns:** Modified `Graphite` instance (chainable)

### `setDate(year: int, month: int, day: int) -> Graphite`
Sets the date component of the datetime.

**Parameters:**
- `year`: Year
- `month`: Month (1-12)
- `day`: Day (1-31)

**Returns:** Modified `Graphite` instance (chainable)

### `setTimestamp(timestamp) -> Graphite`
Sets the instance's timestamp.

**Parameters:**
- `timestamp`: Unix timestamp (int, float, or string)

**Returns:** Modified `Graphite` instance (chainable)

### `setTimezone(timeZone) -> Graphite`
Sets the instance's timezone.

**Parameters:**
- `timeZone`: Timezone (string or dictionary)

**Returns:** Modified `Graphite` instance (chainable)

### `utc() -> Graphite`
Sets the instance's timezone to UTC.

**Returns:** Modified `Graphite` instance (chainable)

### `setDateFrom(date) -> Graphite`
Sets the date from another Graphite instance or date string.

### `setTimeFrom(date) -> Graphite`
Sets the time from another Graphite instance or time string.

### `setDateTimeFrom(date) -> Graphite`
Sets both date and time from another instance.

### `setUnit(unit: String, value) -> Graphite`
Sets a specific unit to a new value.

**Parameters:**
- `unit`: "year", "month", "day", "hour", "minute", "second"
- `value`: New value for the unit

## Formatting Methods

### `format(format_string: String) -> String`
Returns a formatted date string using PHP-style format codes.

**Format Codes:**
- `Y`: 4-digit year (2025)
- `y`: 2-digit year (25)
- `m`: Month with leading zeros (01-12)
- `n`: Month without leading zeros (1-12)
- `F`: Full month name (January)
- `M`: Short month name (Jan)
- `d`: Day with leading zeros (01-31)
- `j`: Day without leading zeros (1-31)
- `l`: Full day name (Monday)
- `D`: Short day name (Mon)
- `H`: Hour with leading zeros (00-23)
- `G`: Hour without leading zeros (0-23)
- `i`: Minutes with leading zeros (00-59)
- `s`: Seconds with leading zeros (00-59)

**Example:**
```gdscript
var formatted = date.format("Y-m-d H:i:s")  # "2025-08-09 14:30:25"
var readable = date.format("l, F j, Y")     # "Friday, August 9, 2025"
```

### `toDateTimeString() -> String`
Formats as "YYYY-MM-DD HH:MM:SS".

### `toDateString() -> String`
Formats as "YYYY-MM-DD".

### `toTimeString() -> String`
Formats as "HH:MM:SS".

### `toFormattedDateString() -> String`
Formats as "Month Day, Year" (e.g., "August 9, 2025").

### `toDayDateTimeString() -> String`
Formats as "Weekday, Month Day, Year Hour:Minute AM/PM".

### Standard Format Methods

All return formatted strings according to their respective standards:

- `toAtomString() -> String`
- `toCookieString() -> String`
- `toIso8601String() -> String`
- `toIso8601ZuluString() -> String`
- `toRfc822String() -> String`
- `toRfc850String() -> String`
- `toRfc1036String() -> String`
- `toRfc1123String() -> String`
- `toRfc2822String() -> String`
- `toRfc3339String() -> String`
- `toRssString() -> String`
- `toW3cString() -> String`

## Modifier Methods

### Start of Period Methods

- `startOfDay() -> Graphite`: Sets time to 00:00:00
- `startOfMonth() -> Graphite`: First day of month at 00:00:00
- `startOfYear() -> Graphite`: January 1st at 00:00:00
- `startOfWeek(weekStartsAt: int = 1) -> Graphite`: Start of week
- `startOfHour() -> Graphite`: Current hour at 00:00
- `startOfMinute() -> Graphite`: Current minute at :00

### End of Period Methods

- `endOfDay() -> Graphite`: Sets time to 23:59:59
- `endOfMonth() -> Graphite`: Last day of month at 23:59:59
- `endOfYear() -> Graphite`: December 31st at 23:59:59
- `endOfWeek(weekEndsAt: int = 0) -> Graphite`: End of week
- `endOfHour() -> Graphite`: Current hour at 59:59
- `endOfMinute() -> Graphite`: Current minute at :59

### Generic Methods

- `startOf(unit: String, params = null) -> Graphite`
- `endOf(unit: String, params = null) -> Graphite`

**Units:** "day", "month", "year", "week", "hour", "minute"

## Query Methods

### Day Type Queries

- `isWeekday() -> bool`: True if Monday-Friday
- `isWeekend() -> bool`: True if Saturday-Sunday

### Relative Queries

- `isYesterday() -> bool`: True if yesterday
- `isToday() -> bool`: True if today
- `isTomorrow() -> bool`: True if tomorrow
- `isFuture() -> bool`: True if after current time
- `isPast() -> bool`: True if before current time

### Special Queries

- `isLeapYear() -> bool`: True if current year is leap year
- `isSameMonth(date, ofSameYear: bool = true) -> bool`: Compare months
- `isDayOfWeek(dayOfWeek) -> bool`: Check specific day of week
- `isBirthday(date = null) -> bool`: Check if birthday
- `isLastOfMonth() -> bool`: True if last day of month
- `isStartOfDay(checkMicroseconds: bool = false) -> bool`: True if midnight
- `isEndOfDay(checkMicroseconds: bool = false) -> bool`: True if end of day

## Comparison Methods

### Equality

- `eq(date) -> bool` / `equalTo(date) -> bool`: Equal to
- `ne(date) -> bool` / `notEqualTo(date) -> bool`: Not equal to

### Greater Than

- `gt(date) -> bool` / `greaterThan(date) -> bool` / `isAfter(date) -> bool`: After
- `gte(date) -> bool` / `greaterThanOrEqualTo(date) -> bool`: After or equal

### Less Than

- `lt(date) -> bool` / `lessThan(date) -> bool` / `isBefore(date) -> bool`: Before
- `lte(date) -> bool` / `lessThanOrEqualTo(date) -> bool`: Before or equal

## Accessor Methods

### `get_datetime() -> Dictionary`
Returns the internal datetime dictionary.

### `set_datetime(datetime_dict: Dictionary) -> void`
Sets the internal datetime dictionary.

### `get_timezone() -> Dictionary`
Returns the internal timezone dictionary.

### `set_timezone(timezone_dict: Dictionary) -> void`
Sets the internal timezone dictionary.

### `toString() -> String`
Returns string representation in "YYYY-MM-DD HH:MM:SS" format.

## Constants

### Day Constants
```gdscript
GraphiteInterface.SUNDAY = 0
GraphiteInterface.MONDAY = 1
GraphiteInterface.TUESDAY = 2
GraphiteInterface.WEDNESDAY = 3
GraphiteInterface.THURSDAY = 4
GraphiteInterface.FRIDAY = 5
GraphiteInterface.SATURDAY = 6
```

### Month Constants
```gdscript
GraphiteInterface.JANUARY = 1
GraphiteInterface.FEBRUARY = 2
GraphiteInterface.MARCH = 3
GraphiteInterface.APRIL = 4
GraphiteInterface.MAY = 5
GraphiteInterface.JUNE = 6
GraphiteInterface.JULY = 7
GraphiteInterface.AUGUST = 8
GraphiteInterface.SEPTEMBER = 9
GraphiteInterface.OCTOBER = 10
GraphiteInterface.NOVEMBER = 11
GraphiteInterface.DECEMBER = 12
```

### Time Constants
```gdscript
GraphiteInterface.HOURS_PER_DAY = 24
GraphiteInterface.MINUTES_PER_HOUR = 60
GraphiteInterface.SECONDS_PER_MINUTE = 60
GraphiteInterface.DAYS_PER_WEEK = 7
GraphiteInterface.MONTHS_PER_YEAR = 12
GraphiteInterface.WEEKS_PER_YEAR = 52
GraphiteInterface.DAYS_PER_YEAR = 365
```

### Format Constants
```gdscript
GraphiteInterface.DEFAULT_TO_STRING_FORMAT = 'Y-m-d H:i:s'
GraphiteInterface.RFC7231_FORMAT = 'D, d M Y H:i:s \\G\\M\\T'
GraphiteInterface.MOCK_DATETIME_FORMAT = 'Y-m-d H:i:s.u'
```
