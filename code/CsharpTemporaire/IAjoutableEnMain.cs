using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

/// <summary>
/// Determine les methodes necessaires pour qu'un objet soit considere comme pouvant etre pris en main par un joueur.
/// </summary>
public interface IAjoutableEnMain
{
    void AjouterObjetDansMainDroite(JoueurCanard joueur);
    void RetirerObjetDansMainDroite(JoueurCanard joueur);
    void AjouterObjetDansMainGauche (JoueurCanard joueur);
    void RetirerObjetDansMainGauche (JoueurCanard joueur);
    void RetirerObjetDansMainDejaPresent(JoueurCanard joueur);
}