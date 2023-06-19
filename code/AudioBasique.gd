extends AudioStreamPlayer

func appliquerSon(son) -> void:
	self.stream = son
	self.play()
