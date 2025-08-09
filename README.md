# Graphite 🗓️

<div align="center">

![Graphite Logo](logo.png)

**A powerful, intuitive DateTime manipulation library for Godot 4.4**

*Inspired by Carbon PHP, built for performance and simplicity*

[![Godot](https://img.shields.io/badge/Godot-4.4-blue.svg)](https://godotengine.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![GitHub release](https://img.shields.io/github/release/elijahcruz12/Graphite.svg)](https://github.com/elijahcruz12/Graphite/releases)

</div>

## ✨ What is Graphite?

Graphite makes working with dates and times in Godot a breeze. Whether you're building a calendar app, scheduling system, or just need to format dates beautifully, Graphite provides an elegant, chainable API that feels natural and powerful.

```gdscript
# Simple, elegant, and powerful
var birthday = Graphite.now()
    .setDate(1990, 5, 15)
    .startOfDay()
    .format("l, F j, Y")  # "Monday, May 15, 1990"

# Check if it's the weekend
if Graphite.now().isWeekend():
    print("Time to relax! 🎉")

# Add time naturally
var deadline = Graphite.today()
    .add(5, "days")
    .setTime(17, 0, 0)  # 5 days from now at 5 PM
```

## 🚀 Key Features

- **🔗 Fluent API** - Chain methods together naturally
- **⚡ Lightning Fast** - Optimized with static methods and RefCounted memory management
- **🎨 Rich Formatting** - Support for RFC standards, custom formats, and readable strings
- **🔍 Smart Queries** - Easy checks for weekends, holidays, leap years, and more
- **📅 Date Math** - Add, subtract, and calculate time differences effortlessly
- **🌍 Timezone Ready** - Built-in timezone support for global applications
- **🧠 Memory Safe** - Automatic memory management with Godot's RefCounted system

## 📦 Installation

### Option 1: Godot Asset Library (Recommended)

**AS OF WRITING, GODOT HAS NOT APPROVED THIS IN THE ASSET LIBRARY, YET.**

1. Open Godot 4.4
2. Go to AssetLib tab
3. Search for "Graphite"
4. Download and install

### Option 2: Manual Installation
1. Download the latest release from [GitHub Releases](https://github.com/elijahcruz12/Graphite/releases)
2. Extract to your project's `addons/` folder
3. Enable the plugin in Project Settings > Plugins

### Option 3: Git Clone
```bash
cd your_project/addons/
git clone https://github.com/elijahcruz12/Graphite.git graphite
```

## 🎯 Quick Start

```gdscript
# Create dates
var now = Graphite.now()
var today = Graphite.today()
var birthday = Graphite.from_dict(
    {"year": 1990, "month": 5, "day": 15, "hour": 0, "minute": 0, "second": 0},
    {}
)

# Format output
print(now.toDateTimeString())        # "2025-08-09 14:30:25"
print(today.toFormattedDateString()) # "August 9, 2025"
print(birthday.format("M j, Y"))     # "May 15, 1990"

# Math operations
var tomorrow = today.add(1, "days")
var next_week = now.add(7, "days")
var last_month = now.sub(1, "months")

# Queries and validation
if now.isWeekday():
    print("It's a work day!")

if birthday.isBirthday():
    print("Happy Birthday! 🎂")

# Comparisons
if deadline.isFuture():
    print("Still have time!")

# Period operations
var month_start = now.startOfMonth()
var year_end = now.endOfYear()
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| **[📖 Complete Documentation](docs/README.md)** | Full documentation hub and navigation |
| **[🚀 Getting Started](docs/getting-started.md)** | Installation and basic usage guide |
| **[📋 API Reference](docs/api-reference.md)** | Complete method and property documentation |
| **[💡 Examples](docs/examples.md)** | Practical examples and use cases |
| **[🏗️ Architecture](docs/architecture.md)** | Internal design and performance details |

## 🎨 Common Use Cases

### Event Scheduling
```gdscript
func schedule_meeting(days_from_now: int, hour: int, minute: int) -> Graphite:
    return Graphite.today()
        .add(days_from_now, "days")
        .setTime(hour, minute, 0)

var meeting = schedule_meeting(3, 14, 30)  # 3 days from now at 2:30 PM
```

### Age Calculation
```gdscript
func calculate_age(birth_date: Graphite) -> int:
    var now = Graphite.now()
    var age = now.get_datetime().year - birth_date.get_datetime().year
    
    var birthday_this_year = birth_date.copy().setUnit("year", now.get_datetime().year)
    if now.lt(birthday_this_year):
        age -= 1
    
    return age
```

### Business Days
```gdscript
func add_business_days(start: Graphite, days: int) -> Graphite:
    var current = start.copy()
    var added = 0
    
    while added < days:
        current.add(1, "days")
        if current.isWeekday():
            added += 1
    
    return current
```

## 🎭 Why Graphite?

### Before Graphite 😤
```gdscript
# Verbose and error-prone
var datetime = Time.get_datetime_dict_from_system()
datetime.day += 5
datetime.hour = 14
datetime.minute = 30
var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
var formatted = "%04d-%02d-%02d %02d:%02d:%02d" % [
    datetime.year, datetime.month, datetime.day,
    datetime.hour, datetime.minute, datetime.second
]
```

### With Graphite 😍
```gdscript
# Clean, readable, and chainable
var formatted = Graphite.now()
    .add(5, "days")
    .setTime(14, 30, 0)
    .toDateTimeString()
```

## ⚡ Performance

Graphite is designed for speed:
- **Static utility methods** - No object creation overhead
- **RefCounted memory management** - Automatic cleanup without `free()` calls
- **Minimal state** - Only stores datetime and timezone data
- **Godot native** - Built on Godot's optimized `Time` class

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **🐛 Report Issues** - Found a bug? Let us know!
2. **💡 Suggest Features** - Have an idea? Open a discussion!
3. **📝 Improve Docs** - Help make the documentation even better
4. **🔧 Submit PRs** - Fix bugs or add Carbon-compatible features

### Development Guidelines
- Follow the existing code style
- Focus on Carbon PHP parity for now
- Add tests for new functionality
- Update documentation for any API changes

## 📄 License

Graphite is released under the [MIT License](LICENSE). Use it freely in your projects!

## 🙏 Acknowledgments

- **[Carbon PHP](https://carbon.nesbot.com/)** - The inspiration behind Graphite's API design
- **[Godot Engine](https://godotengine.org/)** - The amazing game engine that makes this possible
- **Community** - Thanks to all contributors and users!

## 🔗 Links

- **[GitHub Repository](https://github.com/elijahcruz12/Graphite)**
- **[Documentation](docs/README.md)**
- **[Issue Tracker](https://github.com/elijahcruz12/Graphite/issues)**
- **[Discussions](https://github.com/elijahcruz12/Graphite/discussions)**

---

<div align="center">

**Made with ❤️ for the Godot community by TheECGaming**

**Shoutout to [Carbon PHP](https://carbon.nesbot.com/), for being the 🐐 and inspiration for this project**

*If Graphite helps your project, consider giving it a ⭐ on GitHub!*

</div>