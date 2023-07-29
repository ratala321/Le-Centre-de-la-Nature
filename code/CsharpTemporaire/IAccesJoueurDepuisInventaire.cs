namespace PremierTest3d.code.CsharpTemporaire;

/// <summary>
/// Interface limitant l'acces aux methodes pour un inventaire joueur.
/// </summary>
public interface IAccesJoueurDepuisInventaire
{
    bool EstAuSol();
    bool PeutSeMouvoir();
    bool NiveauDuJoueurEstEnPause();
    InventaireJoueur InventaireJoueur { get; }
}