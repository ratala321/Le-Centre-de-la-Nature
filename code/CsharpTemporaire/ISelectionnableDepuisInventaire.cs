using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public interface ISelectionnableDepuisInventaire
{
    /// <summary>
    /// Permet d'effectuer une suite d'instructions lorsqu'un objet est selectionne dans l'inventaire.
    /// </summary>
    /// <param name="joueur"></param>
    public abstract void EffectuerProcedureSelectionDepuisInventaire(JoueurCanard joueur);
}