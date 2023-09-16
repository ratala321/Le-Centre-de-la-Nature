using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public struct DonneesObjetInventaire
{
	public DonneesObjetInventaire(string nomObjet, string cheminSceneObjet)
	{
		NomObjet = nomObjet;
		CheminSceneObjet = cheminSceneObjet;
	}

	public string NomObjet { get; }
	public string CheminSceneObjet { get; }
}
