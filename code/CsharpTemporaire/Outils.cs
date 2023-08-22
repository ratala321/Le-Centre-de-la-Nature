using Godot;
using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public abstract partial class Outils : Node3D, ISelectionnableDepuisInventaire, IPossesseurActionPrincipale,
	IAjoutableEnMain
{
	public void EffectuerProcedureSelectionDepuisInventaire(JoueurCanard joueur)
	{
		GD.Print("PROCEDURE SELECTION OBJET");
		if (EstEnMain)
		{
			RetirerObjetDansMain(joueur);
		}
		else
		{
			AjouterObjetDansMain(joueur);
		}
	}

	private void RetirerObjetDansMain(JoueurCanard joueur)
	{
		if (EstObjetDeMainDroite()) {
			RetirerObjetDansMainDroite(joueur);
		}

		if (EstObjetDeMainGauche())
		{
			RetirerObjetDansMainGauche(joueur);
		}
	}

	private void AjouterObjetDansMain(JoueurCanard joueur)
	{
		if (EstObjetDeMainDroite()) {
			AjouterObjetDansMainDroite(joueur);
		}

		if (EstObjetDeMainGauche())
		{
			AjouterObjetDansMainGauche(joueur);
		}
	}

	protected const int ValeurObjetMainDroite = 1;
	private bool EstObjetDeMainDroite()
	{
		return this.EstObjetDeMain() == ValeurObjetMainDroite;
	}
	
	protected const int ValeurObjetMainGauche = 2;
	private bool EstObjetDeMainGauche()
	{
		return this.EstObjetDeMain() == ValeurObjetMainGauche;
	}
	
	
	public void AjouterObjetDansMainDroite(JoueurCanard joueur)
	{
		GD.Print("Ajouter Objet Dans Main droite");
		RetirerObjetDansMainDejaPresent(joueur);
		
		joueur.MainDroiteJoueur.AddChild(this);
		joueur.ObjetMainDroiteEnMain = true;
		_outilsEstEnMain = true;
	}

	public void RetirerObjetDansMainDroite(JoueurCanard joueur)
	{
		GD.Print("Retirer Objet Main droite");
		joueur.MainDroiteJoueur.RemoveChild(this);
		joueur.ObjetMainDroiteEnMain = false;
		_outilsEstEnMain = false;
	}

	public void AjouterObjetDansMainGauche(JoueurCanard joueur)
	{
		GD.Print("Ajouter Objet Dans Main gauche");
		RetirerObjetDansMainDejaPresent(joueur);
		
		joueur.MainGaucheJoueur.AddChild(this);
		joueur.ObjetMainGaucheEnMain = true;
		_outilsEstEnMain = true;
	}

	public void RetirerObjetDansMainGauche(JoueurCanard joueur)
	{
		GD.Print("Retirer Objet Main gauche");
		joueur.MainGaucheJoueur.RemoveChild(this);
		joueur.ObjetMainGaucheEnMain = false;
		_outilsEstEnMain = false;
	}

	public void RetirerObjetDansMainDejaPresent(JoueurCanard joueur)
	{
		if (joueur.ObjetMainDroiteEnMain)
		{
			//TODO le faire directement dans joueur?
			RetirerObjetDansMainDroite(joueur);
		}
	}
	
	protected static bool JoueurPossedeObjetEnMainDroite(JoueurCanard joueur)
	{
		return joueur.ObjetMainDroiteEnMain;
	}
	
	protected static bool JoueurPossedeObjetEnMainGauche(JoueurCanard joueur)
	{
		return joueur.ObjetMainGaucheEnMain;
	}

	private bool _outilsEstEnMain = false;

	protected bool EstEnMain
	{
		get => _outilsEstEnMain;
		set => _outilsEstEnMain = value;
	}

	/// <summary>
	/// Permet d'effectuer l'action principale associee a un outils.
	/// Par exemple, une pelle dont son action est de creuser.
	/// </summary>
	public abstract void EffectuerActionPrincipale(double delta);
	
	/// <summary>
	/// Permet de determiner dans quelle main, gauche ou droite, un objet s'utilise.
	/// </summary>
	/// <returns>
	/// 1 si l'objet est de main droite, ou 2 si l'objet est de main gauche.
	/// </returns>
	public abstract int EstObjetDeMain();

}
