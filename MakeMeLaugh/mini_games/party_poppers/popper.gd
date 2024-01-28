extends Node
class_name Popper

@onready var particle1: CPUParticles2D = $"CPUParticles2D"
@onready var particle2: CPUParticles2D = $"CPUParticles2D2"
@onready var particle3: CPUParticles2D = $"CPUParticles2D3"

func play():
    particle1.emitting = true
    particle2.emitting = true
    particle3.emitting = true
