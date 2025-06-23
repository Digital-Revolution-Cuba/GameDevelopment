extends CanvasLayer

#Key for show/hide the profiler
const key: Key = KEY_F3

#region Variables
@onready var panel: Panel = $Panel

@onready var fps_text: RichTextLabel = $Panel/VBoxContainer/FPS
@onready var memory_text: RichTextLabel = $Panel/VBoxContainer/Memory
@onready var vram_text: RichTextLabel = $Panel/VBoxContainer/VRAM
@onready var renderer_text: RichTextLabel = $Panel/VBoxContainer/Renderer
@onready var processor_text: RichTextLabel = $Panel/VBoxContainer/Processor

@onready var nodes_count_text: RichTextLabel = $Panel/VBoxContainer/NodesCount

var renderer: String = ProjectSettings.get('rendering/renderer/rendering_method')
var memory: Dictionary = {
	'current': '',
	'peak': ''
}

var visible_panel: bool
var can_tween: bool = true
#endregion

#region Functions
func _ready() -> void:
	match renderer:
		'mobile': renderer_text.text = 'Renderer: Forward Mobile'
		'forward_plus': renderer_text.text = 'Renderer: Forward+'
		'gl_compatibility': renderer_text.text = 'Renderer: OpenGL'

	var selectedKey = InputEventKey.new()
	selectedKey.keycode = key
	InputMap.add_action('Show/Hide')
	InputMap.action_add_event('Show/Hide', selectedKey)

func _process(_delta: float) -> void:
	panel.size.y = $Panel/VBoxContainer.size.y + 10
	memory.current = _format_memory_megas(OS.get_static_memory_usage())
	memory.peak = _format_memory_megas(OS.get_static_memory_peak_usage())

	fps_text.text = 'FPS: ' + str(int(Engine.get_frames_per_second()))
	memory_text.text = 'RAM: ' + memory.current + ' / ' + memory.peak
	vram_text.text = 'VRAM: ' + _format_memory_megas(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED))
	processor_text.text = 'Processor: ' + OS.get_processor_name()
	nodes_count_text.text = 'Nodes count: ' + str(int(Performance.get_monitor(Performance.OBJECT_NODE_COUNT)))

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('Show/Hide') and can_tween:
		if not visible_panel:
			visible_panel = true
		else:
			visible_panel = false
		showPanel(visible_panel)
#endregion

#region Custom Functions
#Ported from https://api.haxeflixel.com/flixel/util/FlxStringUtil.html#formatBytes
func _format_memory_megas(bytes: float) -> String:
	var types: Array = ['B', 'kB', 'MB', 'GB', 'TB', 'PB']
	var index: int = 0

	while bytes >= 1024 and index < types.size() - 1:
		bytes /= 1024
		index += 1

	return str(bytes).pad_decimals(2) + types[index]

func showPanel(value: bool) -> void:
	can_tween = false
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	var position: int

	if value:
		position = -4
	else:
		position = -250

	tween.tween_property(panel, 'position:x', position, lerp(0, 1, 0.5))
	await tween.finished
	can_tween = true
#endregion
