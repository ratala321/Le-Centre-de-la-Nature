using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class InventaireCoffre : Inventaire
{
    public override void _Ready()
    {
        ListeInventaire.ItemClicked += EffectuerProcedureSelectionObjet;
        //TODO chargement inventaire
        ProcessMode = ProcessModeEnum.WhenPaused;
    }

    public override void EffectuerProcedureSelectionObjet(long index, Vector2 atPosition, long mouseButtonIndex)
    {
        TransfererObjetVersInventaireDestination((int)index);
    }
}