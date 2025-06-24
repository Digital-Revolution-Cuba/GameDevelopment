extends Node

var utilsFolder: String = get_script().resource_path.get_base_dir() + '/scenes/'

func _ready() -> void:
	if OS.has_feature('editor'):
		load_utils()

func load_utils() -> void:
	var dir = DirAccess.open(utilsFolder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "" and file_name.ends_with('.tscn'):
			if not dir.current_is_dir():
				var util: Node = load(utilsFolder + file_name).instantiate()
				add_child(util)
			file_name = dir.get_next()
