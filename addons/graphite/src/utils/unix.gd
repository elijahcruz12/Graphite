class_name GraphiteUnix
extends RefCounted

static func toUnixTimestamp(graphite: Graphite) -> int:
	return Time.get_unix_time_from_datetime_dict(graphite.get_datetime())
