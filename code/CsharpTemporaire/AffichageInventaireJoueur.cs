using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class AffichageInventaireJoueur
{
    private readonly IAccesJoueurDepuisInventaire _joueur;

    public AffichageInventaireJoueur(IAccesJoueurDepuisInventaire joueur)
    {
        _joueur = joueur;
    }

    public void EffectuerAffichageInventaireJoueur()
    {
        if (Input.IsActionPressed("inventaire_joueur"))
        {
            if (AffichageInventaireEstPermis())
            {
                _joueur.InventaireJoueur.montrerInterface();
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