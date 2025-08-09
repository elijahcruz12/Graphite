# Architecture

This document explains the internal architecture and design principles of Graphite.

## Table of Contents

- [Overview](#overview)
- [Design Principles](#design-principles)
- [Class Structure](#class-structure)
- [Memory Management](#memory-management)
- [Performance Considerations](#performance-considerations)
- [Extension Points](#extension-points)

## Overview

Graphite follows a modular architecture inspired by Carbon PHP, designed for optimal performance and clean code organization in Godot 4.4. The library uses a facade pattern where the main `Graphite` class acts as an interface to specialized utility classes.

## Design Principles

### 1. Single Responsibility
Each utility class handles one specific aspect of datetime operations:
- **GraphiteMath**: Mathematical operations (add/subtract)
- **GraphiteFormatting**: String formatting and output
- **GraphiteManipulation**: Date/time modification
- **GraphiteComparison**: Date comparison operations
- **GraphiteQueries**: Boolean queries about dates
- **GraphiteModifiers**: Start/end of period operations

### 2. Performance First
- **Static Methods**: All utility methods are static to avoid object creation overhead
- **RefCounted**: Automatic memory management without manual `free()` calls
- **Minimal State**: Graphite instances only store datetime and timezone dictionaries
- **No Deep Inheritance**: Flat class hierarchy for better performance

### 3. Fluent Interface
Most methods return the Graphite instance itself, enabling method chaining:
```gdscript
var result = Graphite.now()
    .startOfMonth()
    .add(15, "days")
    .setTime(14, 30, 0)
    .format("Y-m-d H:i:s")
```

### 4. Immutability Options
- `copy()` and `clone()` methods provide safe immutability when needed
- Most operations modify the instance in-place for performance
- Users can choose between mutable and immutable patterns

## Class Structure

```
Graphite (main class)
├── GraphiteInterface (constants and enums)
├── GraphiteMath (math operations)
├── GraphiteFormatting (string formatting)
├── GraphiteManipulation (date/time modification)
├── GraphiteComparison (comparison operations)
├── GraphiteQueries (boolean queries)
├── GraphiteModifiers (start/end operations)
└── GraphiteUnix (unix timestamp utilities)
```

### Main Graphite Class

The `Graphite` class serves as a facade that:
- Stores datetime and timezone state
- Provides public API methods
- Delegates actual work to utility classes
- Maintains method chaining capability

```gdscript
class_name Graphite
extends RefCounted

var _datetime: Dictionary
var _timezone: Dictionary

func add(amount: int, unit: String = "seconds") -> Graphite:
    return GraphiteMath.add(self, amount, unit)
```

### Utility Classes

Each utility class follows this pattern:
- Extends `RefCounted` (but instances are never created)
- Contains only static methods
- First parameter is always the `Graphite` instance
- Returns either the `Graphite` instance or a primitive type

```gdscript
class_name GraphiteMath
extends RefCounted

static func add(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
    # Implementation here
    return graphite
```

### GraphiteInterface

Contains constants, enums, and configuration values:
- Day/month constants (MONDAY, JANUARY, etc.)
- Time conversion constants (HOURS_PER_DAY, etc.)
- Format constants (DEFAULT_TO_STRING_FORMAT, etc.)
- Diff and translation options

## Memory Management

### RefCounted Benefits

Graphite uses Godot's `RefCounted` system:
- **Automatic Cleanup**: No need to call `free()` manually
- **Reference Counting**: Memory is freed when no references exist
- **Performance**: Minimal overhead compared to manual memory management

### Object Lifecycle

1. **Creation**: `Graphite.now()` creates a new instance
2. **Usage**: Methods are called, state is modified
3. **Destruction**: Automatic when instance goes out of scope

### Memory Patterns

```gdscript
# Short-lived usage - automatic cleanup
func get_formatted_date() -> String:
    return Graphite.now().format("Y-m-d")  # Graphite instance freed automatically

# Long-lived usage - stored as member
class_name MyClass
var creation_time: Graphite

func _init():
    creation_time = Graphite.now()  # Freed when MyClass instance is freed
```

## Performance Considerations

### Static Method Advantages

1. **No Object Creation**: Utility classes are never instantiated
2. **CPU Cache Friendly**: Static methods have better cache locality
3. **Memory Efficient**: No instance data overhead
4. **Direct Function Calls**: No virtual method lookup

### Performance Comparison

```gdscript
# Fast - static method call
GraphiteMath.add(graphite, 5, "minutes")

# Slower - would require object creation (not used in Graphite)
var math_helper = MathHelper.new()
math_helper.add(graphite, 5, "minutes")
```

### Godot Time Integration

Graphite leverages Godot's built-in `Time` class:
- `Time.get_datetime_dict_from_system()`
- `Time.get_unix_time_from_datetime_dict()`
- `Time.get_datetime_dict_from_unix_time()`

This ensures compatibility and optimal performance within the Godot ecosystem.

## Extension Points

### Adding New Utility Classes

To add new functionality:

1. Create a new utility class:
```gdscript
class_name GraphiteCustom
extends RefCounted

static func custom_operation(graphite: Graphite, param: String) -> Graphite:
    # Implementation
    return graphite
```

2. Add method to main Graphite class:
```gdscript
func customOperation(param: String) -> Graphite:
    return GraphiteCustom.custom_operation(self, param)
```

### Extending Formatting

Add new format codes to `GraphiteFormatting.format()`:
```gdscript
static func format(graphite: Graphite, format_string: String) -> String:
    var result = format_string
    # ... existing format codes ...
    
    # Add new format code
    result = result.replace("X", custom_format_logic(datetime))
    
    return result
```

### Custom Queries

Add domain-specific queries to `GraphiteQueries`:
```gdscript
static func isBusinessHour(graphite: Graphite) -> bool:
    var hour = graphite.get_datetime().hour
    return graphite.isWeekday() and hour >= 9 and hour < 17
```

## Error Handling

### Philosophy
- **Graceful Degradation**: Invalid inputs print errors but don't crash
- **Method Chaining Preservation**: Errors return the unchanged instance
- **Developer Feedback**: Clear error messages via `push_error()`

### Error Patterns

```gdscript
static func add(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
    match unit:
        "seconds", "minutes", "hours", "days":
            # Valid operations
            pass
        _:
            push_error("Invalid unit: " + unit)
            return graphite  # Return unchanged
```

## Thread Safety

### Current State
- Graphite instances are **not** thread-safe
- Static utility methods are stateless and thread-safe
- Godot's `Time` class is thread-safe

### Thread Safety Guidelines
- Don't share Graphite instances between threads
- Create separate instances for each thread
- Use `copy()` when passing between threads

```gdscript
# Thread-safe pattern
func thread_worker(datetime_dict: Dictionary):
    var local_graphite = Graphite.from_dict(datetime_dict, {})
    # Work with local_graphite safely
```

## Testing Considerations

### Testable Design
The architecture supports easy testing:
- Static methods can be tested independently
- Pure functions with predictable outputs
- Minimal dependencies (only Godot's Time class)

### Mock-Friendly
```gdscript
# Easy to test specific utility functions
func test_add_minutes():
    var test_date = Graphite.from_dict(test_datetime, {})
    var result = GraphiteMath.add(test_date, 30, "minutes")
    assert(result.get_datetime().minute == expected_minute)
```

## Future Considerations

### Potential Enhancements
1. **Timezone Support**: Full timezone conversion implementation
2. **Localization**: Multi-language date formatting
3. **Parser**: String-to-date parsing functionality
4. **Intervals**: Duration and period calculations
5. **Immutable Mode**: Optional immutable operation mode

### Backwards Compatibility
The modular architecture ensures that:
- New utility classes can be added without breaking existing code
- Method signatures remain stable
- Performance improvements can be made internally
