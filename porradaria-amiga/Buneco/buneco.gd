extends Node2D

signal encostou;

@export var velocidade = 300;
@export var andar_direita = "andar_direita-jogador1"; 
@export var andar_esquerda = "andar_esquerda-jogador1";
@export var pular = "pular-jogador1";
@export var atacar = "atacar-jogador1";
@export var abaixar = "abaixar-jogador1";
var no_ar = false;
var posicao = 0;
var abaixado = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hitbox_arma/CollisionShape2D.disabled = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocidade = Vector2.ZERO;
	
	if(Input.is_action_pressed(andar_direita)):
		velocidade.x += 1;
		$AnimatedSprite2D.animation = "andar";
	if(Input.is_action_pressed(andar_esquerda)):
		velocidade.x -= 1;
		$AnimatedSprite2D.animation = "andar";
		$AnimatedSprite2D.flip_v = true;
	if(Input.is_action_pressed(pular)):
		velocidade.y -= 1
		$AnimatedSprite2D.animation = "pular";
	if(no_ar == true):
		velocidade.y += 1;
		$AnimatedSprite2D.animation = "ar";
	if(Input.is_action_pressed(abaixar) and no_ar == true):
		velocidade.y += 2
		
	if(velocidade.length() > 0):
		velocidade = velocidade.normalized() * velocidade;
		$AnimatedSprite2D.play();
	else:
		$AnimatedSprite2D.animation = "parado";
		$AnimatedSprite2D.play();
		
	posicao += velocidade * delta;
	
	if(Input.is_action_pressed(atacar)):
		golpear();
	

func _on_hitbox_buneco_area_entered(area: Area2D) -> void:
	hide();
	encostou.emit();
	$Hitbox_buneco/CollisionShape2D.set_deferred("disabled", true)
	
	

func iniciar(pos):
	posicao = pos;
	$Hitbox_buneco/CollisionShape2D.disabled = false;
	$Hitbox_arma/CollisionShape2D.disabled = true;
	
func golpear():
	$Hitbox_arma/CollisionShape2D.disabled = true;
	if(no_ar == false):
		$AnimatedSprite2D.animation = "atacar";
	if(no_ar == true):
		$AnimatedSprite2D.animation = "ar_atacar";
	$AnimatedSprite2D.play();
	
	encostou.connect(_on_hitbox_buneco_area_entered)
