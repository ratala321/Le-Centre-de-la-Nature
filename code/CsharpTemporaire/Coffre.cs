using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public partial class Coffre : ObjetInteractif
{
	public override void EffectuerInteraction(Object interacteur)
	{
		if (interacteur is IProprietaireInventaire interacteurProprietaire)
		{
			Inventaire inventaireCoffre = (Inventaire)GetNode("InventaireCoffre");
			
			AfficherInterfaces(inventaireCoffre, interacteurProprietaire.InventaireJoueur);

			AjouterReferencesInventaireDestination(inventaireCoffre, interacteurProprietaire.InventaireJoueur);
		}
	}

	private void AfficherInterfaces(Inventaire inventaireCoffre, Inventaire inventaireInteracteur)
	{
		inventaireCoffre.AfficherInterface(this.GetTree());
		inventaireInteracteur.AfficherInterface(this.GetTree());
	}

	private void AjouterReferencesInventaireDestination(Inventaire inventaireCoffre,
		Inventaire inventaireInteracteur)
	{
		inventaireCoffre.InventaireDestination = inventaireInteracteur;
		inventaireInteracteur.InventaireDestination = inventaireCoffre;
	}
		
}
