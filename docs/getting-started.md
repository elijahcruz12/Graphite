# Getting Started with Graphite

This guide will help you get up and running with Graphite in your Godot project.

## Installation

1. Download the Graphite addon from the releases page
2. Extract the files to your project's `addons/` folder
3. The folder structure should look like:
   ```
   your_project/
   ├── addons/
   │   └── graphite/
   │       ├── plugin.cfg
   │       ├── graphite.gd
   │       └── src/
   ```
4. Enable the plugin in Project Settings > Plugins

## Basic Usage

### Creating Graphite Instances

```gdscript
# Current date and time
var now = Graphite.now()

# Today at midnight
var today = Graphite.today()

# Tomorrow at midnight
var tomorrow = Graphite.tomorrow()

# Yesterday at midnight
var yesterday = Graphite.yesterday()

# From specific date/time
var custom = Graphite.from_dict(
    {"year": 2025, "month": 12, "day": 25, "hour": 9, "minute": 30, "second": 0},
    {}  # timezone dict
)
```

### Setting Dates and Times

```gdscript
var date = Graphite.now()

# Set specific time
date.setTime(14, 30, 0)  # 2:30:00 PM

# Set specific date
date.setDate(2025, 12, 25)  # December 25, 2025

# Set from timestamp
date.setTimestamp(1234567890)

# Set timezone
date.setTimezone("UTC")
date.utc()  # Shortcut for UTC
```

### Basic Operations

```gdscript
var date = Graphite.now()

# Add time using generic functions
date.add(5, "minutes")    # Add 5 minutes
date.add(2, "hours")      # Add 2 hours
date.add(1, "days")       # Add 1 day

# Add time using specific functions
date.addMinutes(5)        # Add 5 minutes
date.addHours(2)          # Add 2 hours
date.addDay()             # Add 1 day

# Subtract time using generic functions
date.sub(30, "seconds")   # Subtract 30 seconds
date.sub(1, "hours")      # Subtract 1 hour

# Subtract time using specific functions
date.subSeconds(30)       # Subtract 30 seconds
date.subHour()            # Subtract 1 hour

# Business days (weekdays only)
date.addWeekdays(5)       # Add 5 business days (Mon-Fri)
date.subWeekdays(3)       # Subtract 3 business days

# Copy instances
var copy1 = date.copy()
var copy2 = date.clone()  # Same as copy()
```

For comprehensive coverage of all addition and subtraction functions, see [Addition and Subtraction](addition-subtraction.md).

### Formatting Output

```gdscript
var date = Graphite.now()

# Common formats
print(date.toDateTimeString())      # 2025-08-09 14:30:25
print(date.toDateString())          # 2025-08-09
print(date.toTimeString())          # 14:30:25
print(date.toFormattedDateString()) # August 9, 2025

# Standard formats
print(date.toIso8601String())       # 2025-08-09T14:30:25+00:00
print(date.toRfc3339String())       # 2025-08-09T14:30:25+00:00
print(date.toAtomString())          # 2025-08-09T14:30:25+00:00

# Custom formatting
print(date.format("Y-m-d H:i:s"))   # 2025-08-09 14:30:25
print(date.format("F j, Y"))        # August 9, 2025
print(date.format("l, F j, Y"))     # Friday, August 9, 2025
```

### Querying Dates

```gdscript
var date = Graphite.now()

# Day type queries
if date.isWeekday():
    print("It's a weekday")
    
if date.isWeekend():
    print("It's the weekend")

# Relative queries
if date.isToday():
    print("Today")
elif date.isYesterday():
    print("Yesterday")
elif date.isTomorrow():
    print("Tomorrow")

# Time queries
if date.isFuture():
    print("In the future")
elif date.isPast():
    print("In the past")

# Special queries
if date.isLeapYear():
    print("This is a leap year")
    
if date.isStartOfDay():
    print("Start of day (midnight)")
```

### Comparing Dates

```gdscript
var date1 = Graphite.now()
var date2 = Graphite.tomorrow()

# Equality
if date1.eq(date2):           # or date1.equalTo(date2)
    print("Dates are equal")

if date1.ne(date2):           # or date1.notEqualTo(date2)
    print("Dates are not equal")

# Comparison
if date1.lt(date2):           # or date1.lessThan(date2) or date1.isBefore(date2)
    print("date1 is before date2")

if date1.gt(date2):           # or date1.greaterThan(date2) or date1.isAfter(date2)
    print("date1 is after date2")

# Less/greater than or equal
if date1.lte(date2):          # or date1.lessThanOrEqualTo(date2)
    print("date1 is before or equal to date2")

if date1.gte(date2):          # or date1.greaterThanOrEqualTo(date2)
    print("date1 is after or equal to date2")
```

### Modifying Dates

```gdscript
var date = Graphite.now()

# Start of periods
date.startOfDay()     # 00:00:00
date.startOfMonth()   # First day of month at 00:00:00
date.startOfYear()    # January 1st at 00:00:00
date.startOfWeek()    # Monday at 00:00:00 (default)
date.startOfHour()    # Current hour at 00:00
date.startOfMinute()  # Current minute at :00

# End of periods
date.endOfDay()       # 23:59:59
date.endOfMonth()     # Last day of month at 23:59:59
date.endOfYear()      # December 31st at 23:59:59
date.endOfWeek()      # Sunday at 23:59:59 (default)
date.endOfHour()      # Current hour at 59:59
date.endOfMinute()    # Current minute at :59

# Generic start/end
date.startOf("day")
date.endOf("month")
```

## Method Chaining

One of Graphite's most powerful features is method chaining:

```gdscript
# Complex chaining example
var result = Graphite.now()
    .startOfMonth()           # Go to start of current month
    .addDays(15)              # Add 15 days
    .setTime(14, 30, 0)       # Set time to 2:30 PM
    .format("l, F j, Y g:i A") # Format as readable string

print(result)  # "Tuesday, August 15, 2025 2:30 PM"

# Another example
var weekend_check = Graphite.today()
    .addDays(2)
    .isWeekend()

if weekend_check:
    print("Two days from now is a weekend")
```

## Error Handling

Graphite includes built-in error handling for invalid inputs:

```gdscript
var date = Graphite.now()

# Invalid unit will print error and return unchanged instance
date.add(5, "invalid_unit")  # Prints error, no change

# Invalid date values will print error
date.setDate(2025, 13, 45)   # Prints error for invalid month/day
```

## Next Steps

- Check out the [API Reference](api-reference.md) for complete method documentation
- Browse [Examples](examples.md) for more complex use cases
- Learn about the [Architecture](architecture.md) to understand how Graphite works internally
