# Graphite Testing Guide

This document provides a comprehensive guide for testing the Graphite datetime library using GDUnit4.

## Test Structure

The test suite is organized into several files, each focusing on specific aspects of the library:

### Core Test Files

1. **`graphite_test.gd`** - Main Graphite class functionality
   - Static creation methods (`now()`, `today()`, `tomorrow()`, `yesterday()`)
   - Basic math operations (`add()`, `sub()`, `addDays()`, `subWeeks()`, etc.)
   - Copy/clone operations
   - Method chaining
   - Query methods
   - Comparison methods

2. **`graphite_math_test.gd`** - GraphiteMath utility class
   - Addition operations (seconds, minutes, hours, days)
   - Subtraction operations
   - Time overflow/underflow handling
   - Edge cases and large values

3. **`graphite_formatting_test.gd`** - GraphiteFormatting utility class
   - Basic formatting methods (`toDateString()`, `toTimeString()`, etc.)
   - Standard format methods (ISO 8601, RFC formats, etc.)
   - Custom format strings
   - Zero-padding and consistency

4. **`graphite_comparison_test.gd`** - GraphiteComparison utility class
   - Equality comparisons (`eq()`, `ne()`)
   - Greater/less than comparisons (`gt()`, `lt()`, `gte()`, `lte()`)
   - Logical consistency tests
   - Edge cases with timezones and boundaries

5. **`graphite_queries_test.gd`** - GraphiteQueries utility class
   - Weekday/weekend detection
   - Relative date queries (`isToday()`, `isTomorrow()`, etc.)
   - Leap year detection
   - Month and day comparisons
   - Start/end of day detection

6. **`graphite_modifiers_test.gd`** - GraphiteModifiers utility class
   - Start/end of day, month, year
   - Start/end of week, hour, minute
   - Generic `startOf()`/`endOf()` methods
   - Month and year boundary handling

7. **`graphite_manipulation_test.gd`** - GraphiteManipulation utility class
   - Copy and clone operations
   - Set time, date, timestamp methods
   - Timezone manipulation
   - Unit setting operations
   - Independence of copied instances

8. **`graphite_integration_test.gd`** - Integration tests
   - Complete workflows (calendar, scheduling, deadlines)
   - Method chaining scenarios
   - Cross-component integration
   - Real-world use cases
   - Performance and memory tests

## Running Tests

### Prerequisites

1. **Install GDUnit4**: Add the GDUnit4 addon to your project
   - Download from Godot Asset Library, or
   - Clone from GitHub: `git clone https://github.com/MikeSchulze/gdUnit4.git addons/gdUnit4`

2. **Enable Plugin**: Go to Project → Project Settings → Plugins and enable "gdUnit4"

### Running All Tests

**Option 1: From Godot Editor**
1. Open your project in Godot
2. Go to Project → Tools → GdUnit4 → Run Tests
3. The test runner will discover and execute all tests in the `test/` directory

**Option 2: From Command Line**
```bash
# Navigate to your project directory
cd "C:\Users\ecweb\Godot\Projects\Graphite"

# Run tests (requires Godot in PATH)
godot --headless --script addons/gdUnit4/bin/ProjectScanner.gd
```

**Option 3: Run Specific Test Files**
```bash
# Run only math tests
godot --headless --script addons/gdUnit4/bin/ProjectScanner.gd --test-file test/graphite_math_test.gd

# Run only formatting tests
godot --headless --script addons/gdUnit4/bin/ProjectScanner.gd --test-file test/graphite_formatting_test.gd
```

### VS Code Integration

For easier test management in VS Code, consider installing GDUnit4 extensions or creating tasks:

**`.vscode/tasks.json`**
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Run All Tests",
            "type": "shell",
            "command": "godot",
            "args": ["--headless", "--script", "addons/gdUnit4/bin/ProjectScanner.gd"],
            "group": "test",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared",
                "showReuseMessage": true,
                "clear": false
            },
            "problemMatcher": []
        }
    ]
}
```

## Test Coverage

The test suite covers:

### ✅ Functional Coverage
- **Creation Methods**: Static factory methods
- **Math Operations**: Addition and subtraction with various units
- **Formatting**: All standard and custom format methods
- **Comparisons**: All comparison operators with edge cases
- **Queries**: Boolean checks for various date properties
- **Modifiers**: Start/end of time periods
- **Manipulation**: Date/time setting and modification

### ✅ Edge Cases
- **Leap Years**: February 29th handling
- **Month Boundaries**: 30/31 day months, February variations
- **Year Boundaries**: December 31st to January 1st transitions
- **Time Zones**: UTC conversions and offset handling
- **Overflow/Underflow**: Time arithmetic beyond normal ranges

### ✅ Integration Testing
- **Method Chaining**: Fluent interface validation
- **Component Interaction**: Cross-utility class operations
- **Real-World Scenarios**: Calendar, scheduling, payroll workflows
- **Memory Management**: RefCounted behavior and leak prevention

## Expected Test Results

When all tests pass, you should see output similar to:

```
GdUnit4 Test Results:
==========================================
Tests Run: 150+ 
Passed: 150+
Failed: 0
Errors: 0
Skipped: 0
Time: ~5-10 seconds
==========================================
```

## Troubleshooting

### Common Issues

1. **GDUnit4 Not Found**
   - Ensure the addon is properly installed in `addons/gdUnit4/`
   - Check that the plugin is enabled in Project Settings

2. **Tests Not Discovered**
   - Verify test files are in the `test/` directory
   - Ensure test files extend `GdUnitTestSuite`
   - Check that test methods start with `test_`

3. **Graphite Classes Not Found**
   - Ensure the main Graphite addon is in `addons/graphite/`
   - Check that all utility classes are properly autoloaded

4. **Assertion Failures**
   - Review the specific assertion that failed
   - Check if the test expects specific behavior that differs from implementation
   - Verify date/time values are within expected ranges

### Debugging Tests

To debug failing tests:

1. **Add Debug Output**:
   ```gdscript
   func test_debug_example():
       var result = Graphite.now()
       print("Current datetime: ", result.get_datetime())
       assert_that(result).is_not_null()
   ```

2. **Use Specific Assertions**:
   ```gdscript
   # Instead of generic checks
   assert_that(result).is_true()
   
   # Use specific assertions for better error messages
   assert_that(datetime["year"]).is_equal(2024)
   assert_that(datetime["month"]).is_between(1, 12)
   ```

3. **Isolate Problems**:
   - Run individual test methods
   - Comment out passing assertions to focus on failures
   - Create minimal reproduction test cases

## Continuous Integration

For automated testing in CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
name: Run Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Godot
        uses: lihop/setup-godot@v1
        with:
          godot-version: 4.4
      - name: Run Tests
        run: godot --headless --script addons/gdUnit4/bin/ProjectScanner.gd
```

## Contributing Tests

When adding new functionality to Graphite:

1. **Write Tests First**: Follow TDD principles
2. **Test Edge Cases**: Include boundary conditions
3. **Test Integration**: Ensure new features work with existing ones
4. **Update Documentation**: Add test descriptions to this guide
5. **Maintain Coverage**: Aim for comprehensive test coverage

## Performance Benchmarks

The test suite includes basic performance tests to ensure:
- Memory usage remains stable during many operations
- Method chaining doesn't cause memory leaks
- Large date calculations complete in reasonable time

For detailed performance analysis, consider adding dedicated benchmark tests:

```gdscript
func test_performance_benchmark():
    var start_time = Time.get_time_from_system()
    
    # Perform many operations
    for i in range(10000):
        var date = Graphite.now().addDays(i).format("Y-m-d")
    
    var end_time = Time.get_time_from_system()
    var duration = end_time - start_time
    
    # Should complete within reasonable time
    assert_that(duration).is_less_than(1.0)  # 1 second
```

---

This comprehensive test suite ensures that Graphite provides reliable datetime functionality for your Godot 4.4 projects. Regular testing helps maintain code quality and prevents regressions as the library evolves.
