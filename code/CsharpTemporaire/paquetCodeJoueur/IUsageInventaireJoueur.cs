namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

/// <summary>
/// Interface specifiant les pre-requis pour utiliser la composante d'inventaire joueur.
/// </summary>
public interface IUsageInventaireJoueur
{
    bool EstAuSol();
    bool PeutSeMouvoir();
    bool NiveauDuJoueurEstEnPause();
    InventaireJoueur InventaireJoueur { get; }
}