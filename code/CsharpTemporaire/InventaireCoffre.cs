using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public partial class InventaireCoffre : Inventaire
{
	public override void _Ready()
	{
		base._Ready();
		ListeInventaire.ItemClicked += EffectuerProcedureSelectionObjet;
		ChargerContenuInventaireSurReady();
		ProcessMode = ProcessModeEnum.WhenPaused;
	}

	public override void EffectuerProcedureSelectionObjet(long index, Vector2 atPosition, long mouseButtonIndex)
	{
		TransfererObjetVersInventaireDestination((int)index);
	}

	public override void ChargerContenuInventaireSurReady()
	{
		ChargerContenuInventaire();
	}
}
