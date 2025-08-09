Graphite - DateTime Manipulation Library for Godot 4.4

A powerful, intuitive DateTime library inspired by Carbon PHP. Graphite makes working with dates and times in Godot elegant and performant.

KEY FEATURES:
• Fluent, chainable API for natural date operations
• Lightning fast with static methods and RefCounted memory management
• Rich formatting options (RFC standards, custom formats, readable strings)
• Smart queries (weekends, holidays, leap years, birthdays)
• Easy date math (add, subtract, calculate differences)
• Timezone support for global applications
• Memory safe with automatic cleanup

QUICK EXAMPLES:

// Create and format dates
var now = Graphite.now()
var formatted = now.format("F j, Y") // "August 9, 2025"

// Chain operations naturally
var deadline = Graphite.today()
    .add(5, "days")
    .setTime(17, 0, 0)
    .toDateTimeString()

// Smart queries
if Graphite.now().isWeekend():
    print("It's the weekend!")

// Easy comparisons
var birthday = Graphite.from_dict(birth_dict, {})
if birthday.isBirthday():
    print("Happy Birthday!")

// Period operations
var month_start = Graphite.now().startOfMonth()
var year_end = Graphite.now().endOfYear()

PERFECT FOR:
• Calendar and scheduling applications
• Event management systems
• Time tracking and logging
• Date validation and formatting
• Business day calculations
• Age and duration calculations

PERFORMANCE OPTIMIZED:
Built with performance in mind using static utility methods, minimal object creation, and Godot's native Time class for maximum efficiency.

EASY TO USE:
If you've used Carbon PHP, you'll feel right at home. Clean, readable API that makes complex date operations simple.

Comprehensive documentation and examples included. Compatible with Godot 4.4.

Visit GitHub for full documentation: github.com/elijahcruz12/Graphite
