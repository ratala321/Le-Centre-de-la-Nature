class_name Collectionnable
extends Area3D


## Nom correspondant au collectionnable. Sera afficher dans l'inventaire.
@export var nom : String

## Valeur du collectionnable a la vente
@export var valeur_monetaire : int

@onready var icone_inventaire : Texture2D = (get_node("Sprite3D") as Sprite3D).texture


## Nombre de collectionnables correspondant contenu.
## Si le joueur ramasse cet objet alors qu'il possede deja un objet de ce type
## dans son inventaire, alors le compteur sera incremente.
var compteur_collectionnable : int = 0


func _ready():
	self.connect("body_entered", lancer_procedure_ramassage)


@onready var image_collectionnable : Sprite3D = $Sprite3D
func _physics_process(_delta):
	image_collectionnable.rotate(Vector3(0,1,0), 0.05)
	_effectuer_mouvement_haut_bas()


var _est_en_montee : bool = true
func _effectuer_mouvement_haut_bas() -> void:
	if _est_en_montee:
		_est_en_montee = position.y <= 2
	
	if not _est_en_montee:
		_est_en_montee = position.y <= 1
	
	if _est_en_montee:
		position.y += 0.020
	else:
		position.y -= 0.020


func lancer_procedure_ramassage(objet_en_collision) -> void:
	if objet_en_collision.has_method("collecter_objet"):
		objet_en_collision.collecter_objet(self)


func lancer_processus_retrait_self_du_scene_tree() -> void:
	var chrono_retrait_self : Timer = Timer.new()
	
	chrono_retrait_self.wait_time = 0.05
	
	chrono_retrait_self.autostart = true
	
	chrono_retrait_self.connect("timeout", _retirer_self_du_scene_tree)
	
	add_child(chrono_retrait_self)


func _retirer_self_du_scene_tree() -> void:
	get_parent().remove_child(self)
	
	_liberer_chrono_retirer_self()


func _liberer_chrono_retirer_self() -> void:
	for enfant in get_children():
		if enfant is Timer:
			enfant.queue_free()


## Permet de construire un dictionnaire contenant les donnees a sauvegardees du collectionnable
func construire_dictionnaire_donnees_a_sauvegarder() -> Dictionary:
	return {
		"nom" : nom,
		"valeur_monetaire" : valeur_monetaire,
		"compteur_collectionnable" : compteur_collectionnable,
	}


func charger_dictionnaire_donnees_sauvegardees(donnees_sauvegardees : Dictionary) -> void:
	nom = donnees_sauvegardees.get("nom")

	valeur_monetaire = donnees_sauvegardees.get("valeur_monetaire")

	compteur_collectionnable = donnees_sauvegardees.get("compteur_collectionnable")
