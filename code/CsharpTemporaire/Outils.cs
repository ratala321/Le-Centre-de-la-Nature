using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public abstract class Outils : ISelectionnableDepuisInventaire
{
    /// <summary>
    /// Permet d'effectuer une suite d'instructions lorsqu'un objet est selectionne dans l'inventaire.
    /// </summary>
    /// <param name="joueur"></param>
    public abstract void EffectuerProcedureSelectionDepuisInventaire(JoueurCanard joueur);

    protected const int ValeurObjetMainDroite = 1;
    protected const int ValeurObjetMainGauche = 2;
    /// <summary>
    /// Permet de determiner dans quelle main, gauche ou droite, un objet s'utilise.
    /// </summary>
    /// <returns>
    /// 1 si l'objet est de main droite, ou 2 si l'objet est de main gauche.
    /// </returns>
    public abstract int EstObjetDeMain();
    
    protected static bool JoueurPossedeObjetEnMainDroite(JoueurCanard joueur)
    {
        return joueur.ObjetMainDroiteEnMain;
    }
    
    protected static bool JoueurPossedeObjetEnMainGauche(JoueurCanard joueur)
    {
        return joueur.ObjetMainGaucheEnMain;
    }

    private bool _outilsEstEnMain = false;

    protected bool OutilsEstEnMain
    {
        get => _outilsEstEnMain;
        set => _outilsEstEnMain = value;
    }
    
}