# Graphite

Graphite is a tool for dealing with DateTime, in a similar fashion to CarbonPHP by Nesbot. The difference is this is done in Godot.

**IS BUILT FOR GODOT 4.4, HAVE NOT TESTED BELOW OR ABOVE THIS YET**

This project is a WIP, but I've gotten a pretty good grasp of how this will work.

First is, we have a Graphite class, and *most* functions will be done using subclasses.

A simple example is for the `add()` function. When you call `add()`, it will actually run from `utils/math.gd` (class name `GraphiteMath`). This implementation will allow us to not have to create multiple objects.

Another spectacular thing we're doing is using `RefCounted`, which means that you don't have to call `graphite.free()` to save memory, instead it will be free'd when it's no longer in use!

## Facts:

- It's FAST (in part to it being a single object that doesn't need to create other objects, AND it free's when completed)
- It's simple (If you've ever used Carbon for PHP, it'll feel like you're at home)
- It's a WIP (as expected, I'm not going to be able to carbon copy {heh} the entirety of Carbon in one go)
- The methods are chainable (So doing `Graphite.add(5, "MINUTES").diffForHumans()` is possible!)
- It will support timezones (because I LOVE a good timezone converter)
- It will support MANY Carbon functions (yes, even `longAbsoluteDiffForHumans()` and `toDayDateTimeString()`)

It cannot be understated that this IS a work in progress. Before releasing, I hope to have at least 15% of the original Carbon functionality ready to go.

## Installation

This project is not yet on the Godot Asset Library (Waiting for Approval).

However, you can download the latest release from the release tab!

## Contributing
If you wish to contribute, you may send a PR or Issue, but PLEASE note I would prefer if you styled the code how I did, as well as make sure that any contributions bring Graphite closer to parity with Carbon for now.

I would appreciate not getting PR's for things that aren't required (such as adding functions that don't exist in Carbon) for now. If we reach 80% parity, I'll reconsider this.

## Deeper dive into Graphite and it's inner-workings

With Graphite (as well as Carbon), each function does 1 of two things.

1. Returns a String or int.
2. Returns itself (Graphite).

You may notice that functionality of functions typically aren't put directly into the Graphite class (More like a Reference to it, and documentation for it).

This is actually purposeful. If we put the functionality of EVERY function of Graphite in `graphite.gd`, we'd be looking at **THOUSANDS** of lines of code before we even hit 20% parity.

To fix this we instead call the function from a specific folder.

```gdscript
# graphite.gd

## Adds the specified [param amount] of time to the Graphite instance.
## Requires a [param unit] of measurement, such as [code]seconds[/code], [code]minutes[/code],
## or [code]hours[/code]. Defaults to [i]seconds[/i].
## [br] The [param unit] is plural.
## [br] Returns Graphite
func add(amount: int, unit: String = "seconds") -> Graphite:
	return GraphiteMath.add(self, amount, unit)
```

This give us an instance of `GraphiteMath`, which accepts the amount and unit, same as what you'd expect from the docs, but also accept the `Graphite` instance itself (using `self`).

`GraphiteMath` can be found at `utils/math.gd`

Here's the actual code for `add()`:

```gdscript
# math.gd

## This function should [b]NOT[/b] be used directly. Instead please use the [code]Graphite[/code] class.
static func add(graphite: Graphite, amount: int, unit: String = "seconds") -> Graphite:
	var datetime = graphite.get_datetime()
	var unix_time = Time.get_unix_time_from_datetime_dict(datetime)
	
	match unit:
		"seconds":
			unix_time += amount
		"minutes":
			unix_time += amount * 60
		"hours":
			unix_time += amount * 3600
		"days":
			unix_time += amount * 86400
	
	graphite.set_datetime(Time.get_datetime_dict_from_unix_time(unix_time))
	return graphite
```

You'll notice that it returns the Graphite instance itself. This allows us to have fluent functions (e.g. `add(5).toDateTimeString()`).

You'll also notice that it's a static method. This serves a few purposes:

- No Object Creation Overhead (it won't create a new object when used)
- Memory Efficiency (Static methods don't need to store instance data, so they use less memory and are faster to call.)
- Pure Functions (Static utility methods are typically "pure" - they take inputs, process them, and return outputs without side effects.)
- Clear Intent
- No State Management (specifically, for the function used. Graphite's only state management is the DateTime and timezone themselves.)

This is why Graphite is so fast. This actually also makes graphite super clean to work with.
