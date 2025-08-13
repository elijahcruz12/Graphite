# Addition and Subtraction Operations

This document covers all the time addition and subtraction operations available in Graphite.

## Table of Contents

- [Overview](#overview)
- [Generic Functions](#generic-functions)
- [Addition Functions](#addition-functions)
  - [Plural Forms](#plural-addition-forms)
  - [Singular Forms](#singular-addition-forms)
- [Subtraction Functions](#subtraction-functions)
  - [Plural Forms](#plural-subtraction-forms)
  - [Singular Forms](#singular-subtraction-forms)
- [Weekdays Functionality](#weekdays-functionality)
- [Examples](#examples)

## Overview

Graphite provides comprehensive time manipulation capabilities through addition and subtraction operations. You can work with time units from microseconds to millennia, and each operation supports both plural forms (taking an amount parameter) and singular forms (adding/subtracting exactly one unit).

All functions return a new Graphite instance, allowing for method chaining and fluent operations.

## Generic Functions

### add(amount: int, unit: String) -> Graphite

Adds the specified amount of time to the Graphite instance.

```gdscript
var date = Graphite.now()
date.add(5, "days")         # Add 5 days
date.add(2, "hours")        # Add 2 hours
date.add(30, "minutes")     # Add 30 minutes
```

### sub(amount: int, unit: String) -> Graphite

Subtracts the specified amount of time from the Graphite instance.

```gdscript
var date = Graphite.now()
date.sub(3, "weeks")        # Subtract 3 weeks
date.sub(1, "year")         # Subtract 1 year
date.sub(45, "seconds")     # Subtract 45 seconds
```

**Supported units:** `"microseconds"`, `"milliseconds"`, `"seconds"`, `"minutes"`, `"hours"`, `"days"`, `"weeks"`, `"weekdays"`, `"months"`, `"quarters"`, `"years"`, `"decades"`, `"centuries"`, `"millenniums"`, `"millennia"`

## Addition Functions

### Plural Addition Forms

These functions take an amount parameter and add that many units to the date.

#### Time Units

```gdscript
# Microseconds and milliseconds
date.addMicroseconds(1000)    # Add 1000 microseconds
date.addMilliseconds(500)     # Add 500 milliseconds

# Basic time units
date.addSeconds(30)           # Add 30 seconds
date.addMinutes(15)           # Add 15 minutes
date.addHours(3)              # Add 3 hours
```

#### Date Units

```gdscript
# Day-based units
date.addDays(7)               # Add 7 days
date.addWeeks(2)              # Add 2 weeks
date.addWeekdays(5)           # Add 5 weekdays (Mon-Fri only)

# Month and year units
date.addMonths(6)             # Add 6 months
date.addQuarters(2)           # Add 2 quarters (6 months)
date.addYears(1)              # Add 1 year
```

#### Large Time Units

```gdscript
# Large time periods
date.addDecades(1)            # Add 1 decade (10 years)
date.addCenturies(1)          # Add 1 century (100 years)
date.addMillenniums(1)        # Add 1 millennium (1000 years)
date.addMillennia(1)          # Alternative spelling for millenniums
```

### Singular Addition Forms

These functions add exactly one unit to the date.

#### Time Units

```gdscript
# Microseconds and milliseconds
date.addMicrosecond()         # Add 1 microsecond
date.addMillisecond()         # Add 1 millisecond

# Basic time units
date.addSecond()              # Add 1 second
date.addMinute()              # Add 1 minute
date.addHour()                # Add 1 hour
```

#### Date Units

```gdscript
# Day-based units
date.addDay()                 # Add 1 day
date.addWeek()                # Add 1 week
date.addWeekday()             # Add 1 weekday (Mon-Fri only)

# Month and year units
date.addMonth()               # Add 1 month
date.addQuarter()             # Add 1 quarter
date.addYear()                # Add 1 year
```

#### Large Time Units

```gdscript
# Large time periods
date.addDecade()              # Add 1 decade
date.addCentury()             # Add 1 century
date.addMillennium()          # Add 1 millennium
```

## Subtraction Functions

### Plural Subtraction Forms

These functions take an amount parameter and subtract that many units from the date.

#### Time Units

```gdscript
# Microseconds and milliseconds
date.subMicroseconds(1000)    # Subtract 1000 microseconds
date.subMilliseconds(500)     # Subtract 500 milliseconds

# Basic time units
date.subSeconds(30)           # Subtract 30 seconds
date.subMinutes(15)           # Subtract 15 minutes
date.subHours(3)              # Subtract 3 hours
```

#### Date Units

```gdscript
# Day-based units
date.subDays(7)               # Subtract 7 days
date.subWeeks(2)              # Subtract 2 weeks
date.subWeekdays(5)           # Subtract 5 weekdays (Mon-Fri only)

# Month and year units
date.subMonths(6)             # Subtract 6 months
date.subQuarters(2)           # Subtract 2 quarters (6 months)
date.subYears(1)              # Subtract 1 year
```

#### Large Time Units

```gdscript
# Large time periods
date.subDecades(1)            # Subtract 1 decade (10 years)
date.subCenturies(1)          # Subtract 1 century (100 years)
date.subMillenniums(1)        # Subtract 1 millennium (1000 years)
date.subMillennia(1)          # Alternative spelling for millenniums
```

### Singular Subtraction Forms

These functions subtract exactly one unit from the date.

#### Time Units

```gdscript
# Microseconds and milliseconds
date.subMicrosecond()         # Subtract 1 microsecond
date.subMillisecond()         # Subtract 1 millisecond

# Basic time units
date.subSecond()              # Subtract 1 second
date.subMinute()              # Subtract 1 minute
date.subHour()                # Subtract 1 hour
```

#### Date Units

```gdscript
# Day-based units
date.subDay()                 # Subtract 1 day
date.subWeek()                # Subtract 1 week
date.subWeekday()             # Subtract 1 weekday (Mon-Fri only)

# Month and year units
date.subMonth()               # Subtract 1 month
date.subQuarter()             # Subtract 1 quarter
date.subYear()                # Subtract 1 year
```

#### Large Time Units

```gdscript
# Large time periods
date.subDecade()              # Subtract 1 decade
date.subCentury()             # Subtract 1 century
date.subMillennium()          # Subtract 1 millennium
```

## Weekdays Functionality

The weekdays functionality is special in that it only considers Monday through Friday as valid weekdays, automatically skipping weekends.

### Adding Weekdays

```gdscript
# If today is Thursday and you add 5 weekdays:
var thursday = Graphite.today()  # Assuming today is Thursday
var result = thursday.addWeekdays(5)
# Result: Thursday of next week (Thu->Fri->Mon->Tue->Wed->Thu)

# This is different from adding 5 regular days:
var regular_add = thursday.addDays(5)  # Would include weekend days
```

### Subtracting Weekdays

```gdscript
# If today is Tuesday and you subtract 3 weekdays:
var tuesday = Graphite.today()  # Assuming today is Tuesday
var result = tuesday.subWeekdays(3)
# Result: Thursday of previous week (Tue->Mon->Fri->Thu)
```

### Weekday Examples

```gdscript
# Adding weekdays for project scheduling
var project_start = Graphite.today()
var milestone_1 = project_start.addWeekdays(10)  # 10 business days later
var milestone_2 = milestone_1.addWeekdays(5)     # 5 more business days

# Calculating delivery dates
var order_date = Graphite.now()
var delivery_date = order_date.addWeekdays(3)    # 3 business days for delivery

# Working backwards from deadlines
var deadline = Graphite.from_dict(
    {"year": 2025, "month": 12, "day": 15, "hour": 17, "minute": 0, "second": 0},
    {}
)
var start_work = deadline.subWeekdays(20)  # Start 20 business days before deadline
```

## Examples

### Basic Addition and Subtraction

```gdscript
# Create a base date
var base_date = Graphite.from_dict(
    {"year": 2025, "month": 8, "day": 15, "hour": 14, "minute": 30, "second": 0},
    {}
)

# Various additions
print("Original: ", base_date.toDateTimeString())        # 2025-08-15 14:30:00
print("+ 1 hour: ", base_date.copy().addHour().toDateTimeString())     # 2025-08-15 15:30:00
print("+ 3 days: ", base_date.copy().addDays(3).toDateTimeString())    # 2025-08-18 14:30:00
print("+ 1 month: ", base_date.copy().addMonth().toDateTimeString())   # 2025-09-15 14:30:00

# Various subtractions
print("- 30 min: ", base_date.copy().subMinutes(30).toDateTimeString()) # 2025-08-15 14:00:00
print("- 1 week: ", base_date.copy().subWeek().toDateTimeString())      # 2025-08-08 14:30:00
print("- 1 year: ", base_date.copy().subYear().toDateTimeString())      # 2024-08-15 14:30:00
```

### Method Chaining

```gdscript
# Chain multiple operations
var complex_date = Graphite.now()
    .addYears(1)        # Add 1 year
    .addMonths(3)       # Add 3 months
    .subDays(5)         # Subtract 5 days
    .addHours(2)        # Add 2 hours
    .subMinutes(15)     # Subtract 15 minutes

print("Complex calculation: ", complex_date.toDateTimeString())
```

### Working with Different Time Scales

```gdscript
# Precise timing (microseconds/milliseconds)
var precise_time = Graphite.now()
    .addMilliseconds(500)
    .addMicroseconds(250)

# Human-scale timing (seconds/minutes/hours)
var meeting_time = Graphite.today()
    .addHours(9)        # 9 AM
    .addMinutes(30)     # 9:30 AM

# Long-term planning (years/decades/centuries)
var historical_date = Graphite.now()
    .subCenturies(2)    # 200 years ago
    .addDecades(3)      # Plus 30 years
```

### Business Day Calculations

```gdscript
# Project timeline using weekdays
func calculate_project_timeline():
    var project_start = Graphite.today()
    
    # Phase 1: 15 business days
    var phase1_end = project_start.addWeekdays(15)
    
    # Phase 2: 20 business days after phase 1
    var phase2_end = phase1_end.addWeekdays(20)
    
    # Phase 3: 10 business days after phase 2
    var project_end = phase2_end.addWeekdays(10)
    
    return {
        "start": project_start.toDateString(),
        "phase1_end": phase1_end.toDateString(),
        "phase2_end": phase2_end.toDateString(),
        "project_end": project_end.toDateString(),
        "total_business_days": 45
    }

# Usage
var timeline = calculate_project_timeline()
print("Project timeline: ", timeline)
```

### Age Calculations

```gdscript
# Calculate someone's age in different units
func calculate_age_breakdown(birth_date: Graphite):
    var now = Graphite.now()
    var age_years = 0
    var temp_date = birth_date.copy()
    
    # Count years
    while temp_date.addYear().lte(now):
        age_years += 1
        temp_date = temp_date.addYear()
    
    # Calculate remaining months, days, etc.
    var remaining_time = birth_date.copy().addYears(age_years)
    var age_months = 0
    while remaining_time.addMonth().lte(now):
        age_months += 1
        remaining_time = remaining_time.addMonth()
    
    return {
        "years": age_years,
        "months": age_months,
        "in_days": (Time.get_unix_time_from_datetime_dict(now.get_datetime()) - 
                   Time.get_unix_time_from_datetime_dict(birth_date.get_datetime())) / (24 * 60 * 60),
        "in_hours": (Time.get_unix_time_from_datetime_dict(now.get_datetime()) - 
                    Time.get_unix_time_from_datetime_dict(birth_date.get_datetime())) / (60 * 60)
    }

# Usage
var birth = Graphite.from_dict(
    {"year": 1990, "month": 5, "day": 15, "hour": 0, "minute": 0, "second": 0},
    {}
)
var age = calculate_age_breakdown(birth)
print("Age: %d years, %d months" % [age.years, age.months])
print("That's %.0f days or %.0f hours" % [age.in_days, age.in_hours])
```

### Appointment Scheduling

```gdscript
# Schedule recurring appointments
func schedule_weekly_appointments(start_date: Graphite, weeks: int) -> Array:
    var appointments = []
    var current_date = start_date.copy()
    
    for i in range(weeks):
        appointments.append({
            "week": i + 1,
            "date": current_date.toDateString(),
            "time": current_date.toTimeString()
        })
        current_date = current_date.addWeek()
    
    return appointments

# Schedule daily check-ins (weekdays only)
func schedule_daily_checkins(start_date: Graphite, business_days: int) -> Array:
    var checkins = []
    var current_date = start_date.copy()
    
    for i in range(business_days):
        checkins.append({
            "day": i + 1,
            "date": current_date.toDateString(),
            "weekday": current_date.format("l")  # Full weekday name
        })
        current_date = current_date.addWeekday()
    
    return checkins

# Usage
var start = Graphite.today().addHours(9)  # 9 AM today
var weekly = schedule_weekly_appointments(start, 4)
var daily = schedule_daily_checkins(start, 10)

print("Weekly appointments:")
for apt in weekly:
    print("Week %d: %s at %s" % [apt.week, apt.date, apt.time])

print("\nDaily check-ins:")
for checkin in daily:
    print("Day %d (%s): %s" % [checkin.day, checkin.weekday, checkin.date])
```

## Performance Notes

- All functions create new Graphite instances rather than modifying the original
- Weekday calculations involve additional logic to skip weekends, so they may be slightly slower than regular day operations
- For bulk operations, consider using the generic `add()` and `sub()` functions with loops rather than chaining many individual calls
- Month and year calculations use approximations (30.44 days per month) for intermediate calculations but are accurate for final results

## See Also

- [Getting Started](getting-started.md) - Basic Graphite usage
- [Examples](examples.md) - More complex usage patterns
- [API Reference](api-reference.md) - Complete function reference
- [Modifiers](modifiers.md) - Start/end of period functions
