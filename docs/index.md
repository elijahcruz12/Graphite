# Graphite Documentation

Graphite is a powerful DateTime manipulation library for Godot 4.4, inspired by Carbon PHP. It provides an intuitive and fluent API for working with dates and times in your Godot projects.

## Table of Contents

- [Getting Started](getting-started.md)
- [API Reference](api-reference.md)
- [Addition and Subtraction](addition-subtraction.md)
- [Examples](examples.md)
- [Architecture](architecture.md)

## Quick Start

```gdscript
# Create a new Graphite instance with current time
var now = Graphite.now()

# Create specific dates
var birthday = Graphite.today().setDate(1990, 5, 15)

# Format dates
print(now.toDateTimeString())  # 2025-08-09 14:30:25

# Add/subtract time
var tomorrow = now.addDay()
var lastWeek = now.subWeeks(1)

# Query dates
if now.isWeekend():
    print("It's the weekend!")

# Chain operations
var result = Graphite.now()
    .startOfDay()
    .addHours(5)
    .format("Y-m-d H:i:s")
```

## Key Features

- **Fluent API**: Chain multiple operations together
- **Memory Efficient**: Uses `RefCounted` for automatic memory management
- **Fast Performance**: Static utility methods for optimal speed
- **Timezone Support**: Built-in timezone handling
- **Rich Formatting**: Multiple format options including RFC standards
- **Comprehensive Queries**: Check for weekends, leap years, birthdays, and more
- **Date Manipulation**: Easy date/time modification and calculation

## Installation

1. Download the latest release from GitHub
2. Extract to your project's `addons/` folder
3. Enable the plugin in Project Settings

## Architecture

Graphite follows a modular architecture where the main `Graphite` class acts as a facade to specialized utility classes:

- **GraphiteMath**: Addition and subtraction operations
- **GraphiteFormatting**: String formatting and output
- **GraphiteManipulation**: Date/time modification
- **GraphiteComparison**: Date comparison operations
- **GraphiteQueries**: Boolean queries about dates
- **GraphiteModifiers**: Start/end of period operations

This design ensures clean code organization and optimal performance through static methods.
