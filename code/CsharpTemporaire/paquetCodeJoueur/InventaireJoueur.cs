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
        if (JoueurTenteTransfererObjet())
        {
            TransfererObjetVersInventaireDestination((int)index);
        }
        else
        {
            Variant metaDataObjet = ListeInventaire.GetItemMetadata((int)index);
            
            if (metaDataObjet.Obj is ISelectionnableDepuisInventaire allo)
            {
                //pour essayer
                GD.Print("La condition fonctionne!");
                allo.EffectuerProcedureSelectionDepuisInventaire();
            }
        }
    }

    private bool JoueurTenteTransfererObjet()
    {
        return InventaireDestination is { Visible: true };
    }

}