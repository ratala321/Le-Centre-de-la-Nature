using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

public partial class InventaireJoueur : Inventaire
{
	public override void _Ready()
	{
		ListeInventaire.ItemClicked += EffectuerProcedureSelectionObjet;
		ChargerContenuInventaireSurReady();
		ProcessMode = ProcessModeEnum.WhenPaused;
	}

	private  JoueurCanard _joueur;
	public InventaireJoueur(JoueurCanard joueur)
	{
		_joueur = joueur;
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

			if (metaDataObjet.Obj is ISelectionnableDepuisInventaire objetSelectionnable)
			{
				//pour essayer
				GD.Print("La condition fonctionne! InventaireJoueur.cs");
				objetSelectionnable.EffectuerProcedureSelectionDepuisInventaire(_joueur);
			}
		}
	}

	public override void ChargerContenuInventaireSurReady()
	{
		ChargerContenuInventaire();
	}

	private bool JoueurTenteTransfererObjet()
	{
		return InventaireDestination is { Visible: true };
	}

}
