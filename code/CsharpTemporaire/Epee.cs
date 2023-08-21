using Godot;
using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public partial class Epee : Outils
{
	private const string NomEpee = "Epee";
	
	//TODO utiliser interface plutot que JoueurCanard
	public override void EffectuerProcedureSelectionDepuisInventaire(JoueurCanard joueur)
	{
		GD.Print("PROCEDURE EPEE CHANGEMENT");
		if (EstEnMain)
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
		return ValeurObjetMainDroite;
	}

	public override void EffectuerActionPrincipale(double delta)
	{
		//TODO
	}

	public void RetirerObjetDansMain(JoueurCanard joueur)
	{
		GD.Print("RetirerObjetMain");
		//TODO
	}

	private void AjouterObjetDansMain(JoueurCanard joueur)
	{
		GD.Print("AjouterObjetDansMain");
		//TODO
		//Si objet est deja present dans main, tout d'abord retirer et ajouter this.
		RetirerObjetDansMainDejaPresent(joueur);
		
		joueur.AddChild(this);
		this.EstEnMain = true;
	}

	private void RetirerObjetDansMainDejaPresent(JoueurCanard joueur)
	{
		if (joueur.ObjetMainDroiteEnMain)
		{
			RetirerObjetDansMain(joueur);
		}
	}
	
}
