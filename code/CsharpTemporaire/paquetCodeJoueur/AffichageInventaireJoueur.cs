using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

public class AffichageInventaireJoueur
{
	private readonly IUsageInventaireJoueur _joueur;

	public AffichageInventaireJoueur(IUsageInventaireJoueur joueur)
	{
		_joueur = joueur;
	}

	public void EffectuerAffichageInventaireJoueur()
	{
		if (Input.IsActionPressed("inventaire_joueur") && AffichageInventaireEstPermis())
		{
			if (_joueur is Node nodeEnScene)
			{
				Inventaire inventaireJoueur = _joueur.InventaireJoueur;
				SceneTree sceneEnCours = nodeEnScene.GetTree();
				inventaireJoueur.AfficherInterface(sceneEnCours);
			}
		}
	}

	private bool AffichageInventaireEstPermis()
	{
		return EtatNiveauPermetAffichageInventaire() && EtatJoueurPermetAffichageInventaire();
	}

	private bool EtatNiveauPermetAffichageInventaire()
	{
		return !_joueur.NiveauDuJoueurEstEnPause();
	}

	private bool EtatJoueurPermetAffichageInventaire()
	{
		return _joueur.EstAuSol() && _joueur.PeutSeMouvoir();
	}
}
