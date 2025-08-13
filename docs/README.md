# Graphite Documentation Overview

Welcome to the complete documentation for Graphite - a powerful DateTime manipulation library for Godot 4.4.

## 📋 Documentation Structure

### 🚀 [Getting Started](getting-started.md)
**Perfect for beginners and quick setup**
- Installation instructions
- Basic usage examples
- First steps with Graphite
- Method chaining introduction
- Error handling basics

### 📖 [API Reference](api-reference.md)
**Complete method and property documentation**
- Static creation methods (`now()`, `today()`, `from_dict()`)
- Math operations (`add()`, `sub()`, `addDays()`, `subWeeks()`, etc.)
- Manipulation methods (`setTime()`, `setDate()`, `copy()`)
- Formatting methods (`format()`, `toDateTimeString()`, etc.)
- Modifier methods (`startOfDay()`, `endOfMonth()`, etc.)
- Query methods (`isWeekend()`, `isLeapYear()`, etc.)
- Comparison methods (`eq()`, `gt()`, `isBefore()`, etc.)
- Constants and enums

### ➕➖ [Addition and Subtraction](addition-subtraction.md)
**Comprehensive guide to time math operations**
- Generic functions (`add()`, `sub()`)
- Specialized functions (`addDays()`, `subWeeks()`, etc.)
- Weekdays functionality (business days)
- Plural and singular forms
- Performance considerations
- Practical examples

### 💡 [Examples](examples.md)
**Practical, real-world usage scenarios**
- Basic date operations
- Custom formatting examples
- Date calculations (age, days until event)
- Validation and queries
- Working with periods (weeks, months, years)
- Practical use cases (event scheduler, time logger, deadline tracker)

### 🏗️ [Architecture](architecture.md)
**Internal design and implementation details**
- Design principles and philosophy
- Class structure and organization
- Memory management with RefCounted
- Performance considerations
- Extension points for customization
- Thread safety guidelines

## 🎯 Quick Navigation

### I want to...

**Get started quickly**
→ [Getting Started Guide](getting-started.md)

**Learn about a specific method**
→ [API Reference](api-reference.md)

**See practical examples**
→ [Examples](examples.md)

**Understand how it works internally**
→ [Architecture](architecture.md)

**Format dates in different ways**
→ [Formatting Methods](api-reference.md#formatting-methods) & [Formatting Examples](examples.md#formatting-examples)

**Compare dates**
→ [Comparison Methods](api-reference.md#comparison-methods)

**Check date properties (weekend, leap year, etc.)**
→ [Query Methods](api-reference.md#query-methods) & [Validation Examples](examples.md#validation-and-queries)

**Add or subtract time**
→ [Addition and Subtraction](addition-subtraction.md) & [Math Operations](api-reference.md#math-operations) & [Date Calculations](examples.md#date-calculations)

**Work with periods (start/end of month, etc.)**
→ [Modifier Methods](api-reference.md#modifier-methods) & [Working with Periods](examples.md#working-with-periods)

## 🔍 Method Quick Reference

### Most Common Operations

```gdscript
# Creation
Graphite.now()              # Current date/time
Graphite.today()            # Today at midnight
Graphite.from_dict(dict, {}) # From custom date

# Formatting
.toDateTimeString()         # "2025-08-09 14:30:25"
.toDateString()             # "2025-08-09"
.format("Y-m-d H:i:s")      # Custom format

# Math
.add(5, "minutes")          # Add time (generic)
.addDays(3)                 # Add 3 days
.addWeekdays(5)             # Add 5 business days
.subHours(2)                # Subtract 2 hours

# Queries
.isToday()                  # Is today?
.isWeekend()                # Is weekend?
.isFuture()                 # Is in future?

# Comparisons
.eq(other_date)             # Equal to
.gt(other_date)             # Greater than (after)
.lt(other_date)             # Less than (before)

# Modifiers
.startOfDay()               # Beginning of day
.endOfMonth()               # End of month
.copy()                     # Create copy
```

## 📚 Documentation Standards

### Code Examples
All code examples in this documentation:
- Are tested and functional
- Use clear, descriptive variable names
- Include comments where helpful
- Show both basic and advanced usage patterns

### Method Signatures
Methods are documented with:
- Parameter types and descriptions
- Return types
- Usage examples
- Related methods

### Navigation
Each document includes:
- Table of contents for easy navigation
- Cross-references to related sections
- Progressive complexity (basic → advanced)

## 🤝 Contributing to Documentation

If you find areas where the documentation could be improved:
1. Check existing issues for documentation requests
2. Create an issue describing what's missing or unclear
3. Submit a pull request with improvements
4. Follow the existing documentation style and structure

## 📋 Version Information

This documentation covers Graphite for **Godot 4.4**.

- **Current Version**: Check the main README for version information
- **Compatibility**: Designed specifically for Godot 4.4
- **Dependencies**: Only requires Godot's built-in `Time` class

## 🎓 Learning Path

### Beginner Path
1. Start with [Getting Started](getting-started.md)
2. Try the basic examples in [Examples](examples.md#basic-date-operations)
3. Explore [formatting options](api-reference.md#formatting-methods)
4. Practice with [method chaining](getting-started.md#method-chaining)

### Intermediate Path
1. Study [date calculations](examples.md#date-calculations)
2. Learn about [queries and validation](examples.md#validation-and-queries)
3. Understand [period operations](examples.md#working-with-periods)
4. Implement practical use cases

### Advanced Path
1. Read the [Architecture](architecture.md) document
2. Study [performance considerations](architecture.md#performance-considerations)
3. Learn about [extension points](architecture.md#extension-points)
4. Consider contributing to the project

---

**Happy coding with Graphite! 🎉**

For questions, issues, or contributions, visit the [Graphite GitHub repository](https://github.com/elijahcruz12/Graphite).
