using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

public partial class InventaireJoueur : Inventaire
{
	private JoueurCanard _joueur;
	public override void _Ready()
	{
		base._Ready();
		_joueur = GetParent<JoueurCanard>();
		ListeInventaire.ItemClicked += EffectuerProcedureSelectionObjet;
		ChargerContenuInventaireSurReady();
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
			//TODO section ne fonctionne pas, metaData / Variant ne permettent pas de verifier la classe/interface,
			//on veut pouvoir utiliser ISelectionnableDepuisInventaire
			Variant metaDataObjet = ListeInventaire.GetItemMetadata((int)index);

			if (metaDataObjet.Obj is PackedScene objetInventaire)
			{
				ISelectionnableDepuisInventaire instanceObjet = objetInventaire.Instantiate<ISelectionnableDepuisInventaire>();
				//pour essayer
				GD.Print("La condition fonctionne! InventaireJoueur.cs");
				instanceObjet.EffectuerProcedureSelectionDepuisInventaire(_joueur);
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
