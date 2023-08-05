using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

public class InventaireJoueur : Inventaire
{
    public override void _Ready()
    {
        ListeInventaire.ItemClicked += EffectuerProcedureSelectionObjet;
        //TODO chargement contenu inventaire
        ProcessMode = ProcessModeEnum.WhenPaused;
    }

    public override void EffectuerProcedureSelectionObjet(long index, Vector2 atPosition, long mouseButtonIndex)
    {
        
    }

    private bool JoueurTenteTransfererObjet()
    {
        return false;
    }

}