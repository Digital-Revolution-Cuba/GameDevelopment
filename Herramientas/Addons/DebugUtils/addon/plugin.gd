@tool
extends EditorPlugin

var utils_script: String = get_script().resource_path.get_base_dir() + '/main.gd'

func _enter_tree() -> void:
	add_autoload_singleton('DebugUtils', utils_script)

func _exit_tree() -> void:
	remove_autoload_singleton('DebugUtils')
