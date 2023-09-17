using System;
using Godot;
using Godot.Collections;

namespace PremierTest3d.code.CsharpTemporaire;

public partial class EspacePlante : Area3D
{
	private bool _contientUnePrevisualisation = false;
	
	public override void _Ready()
	{
		this.AreaExited += RetirerPrevisualisationApresSortieJoueur;
	}
	
	public void AjouterPlanteDansEspace(PackedScene scenePlante)
	{
		if (NeContientPasUnePlante())
		{
			try
			{
				Plante instance = (Plante)scenePlante.Instantiate();
				EffectuerProcessusAjoutPlante(instance);
			}
			catch (InvalidCastException e)
			{
				Console.WriteLine("erreur cast EspacePlante.cs" + e);
			}
		}
	}

	private bool NeContientPasUnePlante()
	{
		return !ContientUnePlante();
	}

	[Export] private SolFertile _referenceSolFertile;
	private void EffectuerProcessusAjoutPlante(Plante plante)
	{
		AjusterEmplacementPlante(plante);

		plante.ReferenceSolFertile = _referenceSolFertile;
		
		AddChild(plante);
	}

	private void AjusterEmplacementPlante(Node3D plante)
	{
		AjusterEmplacementPrevisualisation(plante);
	}

	private bool ContientUnePlante()
	{
		Array<Node> enfantsScene = GetChildren();
		int i = 0;
		while (i < enfantsScene.Count && EnfantNEstPasUnePlante(enfantsScene[i]))
		{
			i++;
		}

		return i < enfantsScene.Count;
	}

	private bool EnfantNEstPasUnePlante(Node enfant)
	{
		return !EnfantEstUnePlante(enfant);
	}
	
	private bool EnfantEstUnePlante(Node enfant)
	{
		return enfant is Plante && enfant != _planteEnPrevisualisation;
	}

	public void PrevisualiserPlante(PackedScene scenePlante)
	{
		if (!_contientUnePrevisualisation)
		{
			Node3D instancePlante = (Node3D)scenePlante.Instantiate();
			EffectuerProcessusPrevisualisation(instancePlante);
		}
	}

	private Node _planteEnPrevisualisation;
	private void EffectuerProcessusPrevisualisation(Node3D plante)
	{
		SauvegarderReferencePrevisualisation(plante);
		
		AjusterEmplacementPrevisualisation(plante);
		
		AfficherPrevisualisation(plante);
		
		AjouterPrevisualisationDansScene(plante);
	}

	private void SauvegarderReferencePrevisualisation(Node3D plante)
	{
		_planteEnPrevisualisation = plante;
	}

	private void AjusterEmplacementPrevisualisation(Node3D plante)
	{
		Marker3D emplacementPrevisualisation = (Marker3D)GetNode("PositionPlante");
		plante.Position = emplacementPrevisualisation.Position;

	}

	private const string EtapeCroissanceInitiale = "Initial";
	private const string PrevisualisationPlante = "Previsualisation";
	
	private void AfficherPrevisualisation(Node3D plante)
	{
		Node3D etapeCroissanceInitiale = (Node3D)plante.GetNode(EtapeCroissanceInitiale);
		etapeCroissanceInitiale.Hide();
		
		Node3D previsualisationPlante = (Node3D)plante.GetNode(PrevisualisationPlante);
		previsualisationPlante.Show();
	}

	private void AjouterPrevisualisationDansScene(Node3D plante)
	{
		AddChild(plante);
		_contientUnePrevisualisation = true;
	}

	private void RetirerPrevisualisationApresSortieJoueur(Area3D aireSortie)
	{
		if (PeutRetirerPrevisualisation(aireSortie))
		{
			_planteEnPrevisualisation.Free();
			_planteEnPrevisualisation = null;
			_contientUnePrevisualisation = false;
		}
	}

	private const string AirePermettantPrevisualisation = "AireDetectionEspacePlante";
	private bool PeutRetirerPrevisualisation(Area3D aireSortie)
	{
		return _contientUnePrevisualisation &&
			   aireSortie.Name.Equals(AirePermettantPrevisualisation);
	}

}
