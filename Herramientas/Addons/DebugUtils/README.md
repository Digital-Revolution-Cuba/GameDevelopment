Godot Engine - Debug Utils
---
#### Un par de herramientas desarrolladas para mejorar la experiencia en el proceso de depuración.
> (Requiere Godot Engine v4.x)
 > Versión actual del addon: 1.0.0
 
 #### Planeo implementar más funciones con el pasar del tiempo. 
 #### Sé libre de utilizar este complemento en cualquier tipo de proyecto.
 
Instalación
---
 - Descarga el archivo [debug_utils.zip](https://github.com/Digital-Revolution-Cuba/GameDevelopment/raw/refs/heads/main/Herramientas/Addons/DebugUtils/debug_utils.zip) y extráelo donde quieras.
 - Copia la carpeta addons/debug_utils en la carpeta donde se encuentre ubicado tu proyecto.
 - Abre el proyecto y actívalo en Configuración del Proyecto → Plugins → Debug Utils.

 ---
 
# Funciones implementadas
 ***Perfilador***
 - Te permite observar información importante sobre el estado de tu
   juego (Uso de RAM, VRAM, FPS, entre otros).

> Para mostrar / ocultar el Perfilador, pulsa la tecla seleccionada(Por defecto F3). Puedes cambiar la tecla en scripts/profiler.gd
```gdscript
const key: Key = KEY_F3 #Reemplaza KEY_F3 por la tecla que quieras.
```
