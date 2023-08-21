using Godot;
using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public partial class Epee : Outils
{
	private const string NomEpee = "Epee";

	public override int EstObjetDeMain()
	{
		return ValeurObjetMainDroite;
	}

	public override void EffectuerActionPrincipale(double delta)
	{
		//TODO
	}
	
}
