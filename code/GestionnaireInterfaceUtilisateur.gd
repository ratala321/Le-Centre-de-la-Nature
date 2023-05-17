extends Node


##signal permettant de determiner si l'inventaire peut etre affiche
signal permissionInventaireJoueur_


func _ready():
	set_process_mode(PROCESS_MODE_ALWAYS)


func _process(delta):
	cacherInterface()
	demanderAfficherInventaireJoueur()

##permet de cacher l'ensemble des interfaces affichés et continuer le jeu
func cacherInterface() -> void:
	if Input.is_key_pressed(KEY_Q):
		get_tree().call_group("InterfaceEnJeu", "cacherInterface")


##permet d'emettre le signal permettant de determiner si l'inventaire peut etre affiche
func demanderAfficherInventaireJoueur() -> void:
	if Input.is_action_just_pressed("inventaire_joueur") and !get_tree().paused:
		emit_signal("permissionInventaireJoueur_")
		print("demande permission pour afficher inventaire joueur")


##permet d'afficher l'inventaire du joueur
func afficherInventaireJoueur() -> void:
	pass
