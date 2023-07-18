extends AnimationPlayer

##permet d'appliquer une animation passee en parametre
func appliquerAnimation(animation : String) -> void:
	self.play(animation)


##permet d'ajuster la vitesse d'excution des animations liees au joueur
func ajusterVitesseAnimation(vitesse) -> void:
	self.speed_scale = vitesse
