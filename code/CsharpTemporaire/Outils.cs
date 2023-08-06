namespace PremierTest3d.code.CsharpTemporaire;

public abstract class Outils : ISelectionnableDepuisInventaire
{
        
    /// <summary>
    /// Permet d'effectuer une suite d'instructions lorsqu'un objet est selectionne dans l'inventaire.
    /// </summary>
    public abstract void EffectuerProcedureSelectionDepuisInventaire();

    protected const int ValeurObjetMainDroite = 1;
    protected const int ValeurObjetMainGauche = 2;
    /// <summary>
    /// Permet de determiner dans quelle main, gauche ou droite, un objet s'utilise.
    /// </summary>
    /// <returns>
    /// 1 si l'objet est de main droite, ou 2 si l'objet est de main gauche.
    /// </returns>
    public abstract int EstObjetDeMain();
}