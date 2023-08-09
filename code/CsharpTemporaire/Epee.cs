using Godot;
using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public class Epee : Outils
{
    private const string NomEpee = "Epee";
    
    public override void EffectuerProcedureSelectionDepuisInventaire(JoueurCanard joueur)
    {
        GD.Print("PROCEDURE EPEE");
        if (OutilsEstEnMain)
        {
            RetirerObjetDansMain(joueur);
        }
        else
        {
            AjouterObjetDansMain(joueur);
        }
    }

    public override int EstObjetDeMain()
    {
        GD.Print("temporaire");
        return ValeurObjetMainDroite;
    }

    private void RetirerObjetDansMain(JoueurCanard joueur)
    {
        //TODO
    }

    private void AjouterObjetDansMain(JoueurCanard joueur)
    {
        //TODO
        //Si objet est deja present dans main, tout d'abord retirer et ajouter this.
    }
    
}