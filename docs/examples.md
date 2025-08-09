# Examples

This document contains practical examples of using Graphite in real-world scenarios.

## Table of Contents

- [Basic Date Operations](#basic-date-operations)
- [Formatting Examples](#formatting-examples)
- [Date Calculations](#date-calculations)
- [Validation and Queries](#validation-and-queries)
- [Working with Periods](#working-with-periods)
- [Practical Use Cases](#practical-use-cases)

## Basic Date Operations

### Creating and Displaying Dates

```gdscript
# Different ways to create dates
var now = Graphite.now()
var today = Graphite.today()
var tomorrow = Graphite.tomorrow()
var custom = Graphite.from_dict(
    {"year": 2025, "month": 12, "day": 25, "hour": 10, "minute": 30, "second": 0},
    {}
)

print("Now: ", now.toDateTimeString())
print("Today: ", today.toDateTimeString())
print("Tomorrow: ", tomorrow.toDateTimeString())
print("Christmas: ", custom.toFormattedDateString())
```

### Modifying Dates

```gdscript
var date = Graphite.now()

# Set specific components
date.setDate(2025, 6, 15)  # June 15, 2025
date.setTime(14, 30, 0)    # 2:30 PM

print("Modified date: ", date.toDateTimeString())

# Copy and modify
var weekend = date.copy().add(2, "days")
print("Weekend date: ", weekend.toDateTimeString())
```

## Formatting Examples

### Standard Formats

```gdscript
var date = Graphite.from_dict(
    {"year": 2025, "month": 8, "day": 9, "hour": 14, "minute": 30, "second": 25},
    {}
)

# Different format outputs
print("DateTime: ", date.toDateTimeString())        # 2025-08-09 14:30:25
print("Date only: ", date.toDateString())           # 2025-08-09
print("Time only: ", date.toTimeString())           # 14:30:25
print("Formatted: ", date.toFormattedDateString())  # August 9, 2025
print("Full: ", date.toDayDateTimeString())         # Saturday, August 9, 2025 2:30 PM

# Standard formats
print("ISO 8601: ", date.toIso8601String())         # 2025-08-09T14:30:25+00:00
print("RFC 3339: ", date.toRfc3339String())         # 2025-08-09T14:30:25+00:00
print("ATOM: ", date.toAtomString())                # 2025-08-09T14:30:25+00:00
```

### Custom Formatting

```gdscript
var date = Graphite.now()

# Various custom formats
print(date.format("Y-m-d"))                    # 2025-08-09
print(date.format("d/m/Y"))                    # 09/08/2025
print(date.format("F j, Y"))                   # August 9, 2025
print(date.format("l, F j, Y"))                # Friday, August 9, 2025
print(date.format("H:i:s"))                    # 14:30:25
print(date.format("g:i A"))                    # 2:30 PM
print(date.format("D, M j, Y g:i A"))          # Fri, Aug 9, 2025 2:30 PM

# Database-friendly formats
print(date.format("Y-m-d H:i:s"))              # 2025-08-09 14:30:25
```

## Date Calculations

### Age Calculation

```gdscript
func calculate_age(birth_date: Graphite) -> int:
    var now = Graphite.now()
    var birth_this_year = birth_date.copy()
        .setDate(now.get_datetime().year, birth_date.get_datetime().month, birth_date.get_datetime().day)
    
    var age = now.get_datetime().year - birth_date.get_datetime().year
    
    if now.lt(birth_this_year):
        age -= 1
    
    return age

# Usage
var birthday = Graphite.from_dict(
    {"year": 1990, "month": 5, "day": 15, "hour": 0, "minute": 0, "second": 0},
    {}
)
var age = calculate_age(birthday)
print("Age: ", age)
```

### Days Until Event

```gdscript
func days_until_event(event_date: Graphite) -> int:
    var now = Graphite.now()
    var now_unix = Time.get_unix_time_from_datetime_dict(now.get_datetime())
    var event_unix = Time.get_unix_time_from_datetime_dict(event_date.get_datetime())
    
    var diff_seconds = event_unix - now_unix
    return int(diff_seconds / (24 * 60 * 60))

# Usage
var christmas = Graphite.from_dict(
    {"year": 2025, "month": 12, "day": 25, "hour": 0, "minute": 0, "second": 0},
    {}
)
var days_left = days_until_event(christmas)
print("Days until Christmas: ", days_left)
```

### Business Days Calculator

```gdscript
func add_business_days(start_date: Graphite, business_days: int) -> Graphite:
    var current = start_date.copy()
    var added_days = 0
    
    while added_days < business_days:
        current.add(1, "days")
        if current.isWeekday():
            added_days += 1
    
    return current

# Usage
var today = Graphite.today()
var delivery_date = add_business_days(today, 5)
print("Delivery date (5 business days): ", delivery_date.toFormattedDateString())
```

## Validation and Queries

### Date Validation

```gdscript
func validate_date_range(date: Graphite, start_date: Graphite, end_date: Graphite) -> bool:
    return date.gte(start_date) and date.lte(end_date)

func is_business_hour(time: Graphite) -> bool:
    var hour = time.get_datetime().hour
    return time.isWeekday() and hour >= 9 and hour < 17

# Usage
var appointment = Graphite.now().setTime(14, 30, 0)
var start_range = Graphite.today().setTime(9, 0, 0)
var end_range = Graphite.today().setTime(17, 0, 0)

if validate_date_range(appointment, start_range, end_range) and is_business_hour(appointment):
    print("Valid business appointment time")
```

### Weekend and Holiday Checks

```gdscript
func is_holiday(date: Graphite) -> bool:
    # Simple holiday check (extend as needed)
    var month = date.get_datetime().month
    var day = date.get_datetime().day
    
    # New Year's Day
    if month == 1 and day == 1:
        return true
    
    # Christmas
    if month == 12 and day == 25:
        return true
    
    return false

func next_working_day(date: Graphite) -> Graphite:
    var next_day = date.copy().add(1, "days")
    
    while next_day.isWeekend() or is_holiday(next_day):
        next_day.add(1, "days")
    
    return next_day

# Usage
var today = Graphite.today()
var next_work = next_working_day(today)
print("Next working day: ", next_work.toFormattedDateString())
```

## Working with Periods

### Month Operations

```gdscript
func get_month_info(date: Graphite) -> Dictionary:
    var start_of_month = date.copy().startOfMonth()
    var end_of_month = date.copy().endOfMonth()
    
    return {
        "start": start_of_month.toDateString(),
        "end": end_of_month.toDateString(),
        "is_leap_year": date.isLeapYear(),
        "month_name": date.format("F")
    }

# Usage
var current_month = get_month_info(Graphite.now())
print("Month info: ", current_month)
```

### Week Operations

```gdscript
func get_week_dates(date: Graphite) -> Array:
    var week_start = date.copy().startOfWeek()
    var dates = []
    
    for i in range(7):
        var day = week_start.copy().add(i, "days")
        dates.append({
            "date": day.toDateString(),
            "day_name": day.format("l"),
            "is_today": day.isToday()
        })
    
    return dates

# Usage
var week_dates = get_week_dates(Graphite.now())
for day_info in week_dates:
    print(day_info.day_name, ": ", day_info.date, " (Today: ", day_info.is_today, ")")
```

### Year Operations

```gdscript
func get_year_info(year: int) -> Dictionary:
    var start_of_year = Graphite.from_dict(
        {"year": year, "month": 1, "day": 1, "hour": 0, "minute": 0, "second": 0},
        {}
    )
    
    return {
        "year": year,
        "is_leap": start_of_year.isLeapYear(),
        "start_day": start_of_year.format("l"),
        "days_in_year": 366 if start_of_year.isLeapYear() else 365
    }

# Usage
var year_info = get_year_info(2025)
print("Year 2025 info: ", year_info)
```

## Practical Use Cases

### Event Scheduler

```gdscript
class_name EventScheduler

var events: Array = []

func add_event(name: String, date: Graphite):
    events.append({
        "name": name,
        "date": date,
        "unix_time": Time.get_unix_time_from_datetime_dict(date.get_datetime())
    })
    
    # Sort events by date
    events.sort_custom(func(a, b): return a.unix_time < b.unix_time)

func get_upcoming_events(days_ahead: int = 7) -> Array:
    var now = Graphite.now()
    var cutoff = now.copy().add(days_ahead, "days")
    
    var upcoming = []
    for event in events:
        var event_date = Graphite.from_dict(event.date.get_datetime(), {})
        if event_date.gte(now) and event_date.lte(cutoff):
            upcoming.append(event)
    
    return upcoming

func get_events_today() -> Array:
    var today_events = []
    for event in events:
        if event.date.isToday():
            today_events.append(event)
    
    return today_events

# Usage
var scheduler = EventScheduler.new()
scheduler.add_event("Meeting", Graphite.now().add(2, "days").setTime(10, 0, 0))
scheduler.add_event("Deadline", Graphite.now().add(5, "days").setTime(17, 0, 0))

var upcoming = scheduler.get_upcoming_events()
for event in upcoming:
    print("Upcoming: ", event.name, " on ", event.date.toFormattedDateString())
```

### Time Logger

```gdscript
class_name TimeLogger

var log_entries: Array = []

func start_timer(task_name: String):
    log_entries.append({
        "task": task_name,
        "start_time": Graphite.now(),
        "end_time": null,
        "duration": 0
    })

func stop_timer(task_name: String):
    for entry in log_entries:
        if entry.task == task_name and entry.end_time == null:
            entry.end_time = Graphite.now()
            
            var start_unix = Time.get_unix_time_from_datetime_dict(entry.start_time.get_datetime())
            var end_unix = Time.get_unix_time_from_datetime_dict(entry.end_time.get_datetime())
            entry.duration = end_unix - start_unix
            break

func get_total_time_today(task_name: String) -> int:
    var total_seconds = 0
    
    for entry in log_entries:
        if entry.task == task_name and entry.end_time != null:
            if entry.start_time.isToday():
                total_seconds += entry.duration
    
    return total_seconds

func format_duration(seconds: int) -> String:
    var hours = seconds / 3600
    var minutes = (seconds % 3600) / 60
    var secs = seconds % 60
    
    return "%02d:%02d:%02d" % [hours, minutes, secs]

# Usage
var logger = TimeLogger.new()
logger.start_timer("Development")
# ... work happens ...
logger.stop_timer("Development")

var total_dev_time = logger.get_total_time_today("Development")
print("Total development time today: ", logger.format_duration(total_dev_time))
```

### Date Range Picker

```gdscript
class_name DateRangePicker

func get_date_range(start_date: Graphite, end_date: Graphite) -> Array:
    var dates = []
    var current = start_date.copy()
    
    while current.lte(end_date):
        dates.append({
            "date": current.copy(),
            "formatted": current.toDateString(),
            "day_name": current.format("D"),
            "is_weekend": current.isWeekend(),
            "is_today": current.isToday()
        })
        current.add(1, "days")
    
    return dates

func get_business_days_in_range(start_date: Graphite, end_date: Graphite) -> Array:
    var all_dates = get_date_range(start_date, end_date)
    var business_days = []
    
    for date_info in all_dates:
        if not date_info.is_weekend:
            business_days.append(date_info)
    
    return business_days

# Usage
var start = Graphite.today()
var end = start.copy().add(14, "days")
var business_days = DateRangePicker.new().get_business_days_in_range(start, end)

print("Business days in next 2 weeks:")
for day in business_days:
    print(day.day_name, " ", day.formatted)
```

### Deadline Tracker

```gdscript
class_name DeadlineTracker

enum Priority {
    LOW,
    MEDIUM,
    HIGH,
    CRITICAL
}

var deadlines: Array = []

func add_deadline(name: String, due_date: Graphite, priority: Priority):
    deadlines.append({
        "name": name,
        "due_date": due_date,
        "priority": priority,
        "is_overdue": false
    })

func check_overdue():
    var now = Graphite.now()
    for deadline in deadlines:
        deadline.is_overdue = deadline.due_date.lt(now)

func get_urgent_deadlines(hours_ahead: int = 24) -> Array:
    var urgent = []
    var cutoff = Graphite.now().add(hours_ahead, "hours")
    
    for deadline in deadlines:
        if deadline.due_date.lte(cutoff) and not deadline.is_overdue:
            urgent.append(deadline)
    
    return urgent

func get_deadline_status(deadline: Dictionary) -> String:
    if deadline.is_overdue:
        return "OVERDUE"
    
    var now = Graphite.now()
    var hours_left = (Time.get_unix_time_from_datetime_dict(deadline.due_date.get_datetime()) - 
                     Time.get_unix_time_from_datetime_dict(now.get_datetime())) / 3600
    
    if hours_left < 24:
        return "Due within 24 hours"
    elif hours_left < 72:
        return "Due within 3 days"
    else:
        return "Due %s" % deadline.due_date.toFormattedDateString()

# Usage
var tracker = DeadlineTracker.new()
tracker.add_deadline("Project Report", Graphite.now().add(2, "days"), DeadlineTracker.Priority.HIGH)
tracker.add_deadline("Code Review", Graphite.now().add(6, "hours"), DeadlineTracker.Priority.MEDIUM)

tracker.check_overdue()
var urgent = tracker.get_urgent_deadlines()

for deadline in urgent:
    print("URGENT: ", deadline.name, " - ", tracker.get_deadline_status(deadline))
```
