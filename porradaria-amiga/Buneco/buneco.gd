extends Node2D

signal apanhou;
signal eliminou;

@export var velocidade = 300;
@export var andar_direita = "andar_direita-jogador1"; 
@export var andar_esquerda = "andar_esquerda-jogador1";
@export var pular = "pilar-jogador1";
@export var atacar = "atacar-jogador1";
@export var abaixar = "abaixar-jogador1";


var tamanho_tela;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
