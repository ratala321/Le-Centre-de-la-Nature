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
			Variant metaDataObjetSelectionne = ListeInventaire.GetItemMetadata((int)index);
			LancerProcedurePourObjetSelectionnable(metaDataObjetSelectionne);
		}
	}

	private void LancerProcedurePourObjetSelectionnable(Variant metaDataObjetSelectionne)
	{
		if (metaDataObjetSelectionne.AsGodotObject() is PackedScene sceneObjetInventaire)
		{
			Node objetSelectionne = sceneObjetInventaire.Instantiate();
			ISelectionnableDepuisInventaire objetInventaire = objetSelectionne as ISelectionnableDepuisInventaire;
			
			objetInventaire?.EffectuerProcedureSelectionDepuisInventaire(_joueur);
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
