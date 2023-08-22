using Godot;
using Godot.Collections;
using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public partial class SacGraine : Outils
{
	//Load temporaire, destine a fonctionner autrement.
	private PackedScene _graineContenue =
		ResourceLoader.Load<PackedScene>("res://scenes/plantesScenes/BleScene.tscn");

	private Area3D _aireDetectionEspacePlante;
	public override void _Ready()
	{
		_aireDetectionEspacePlante = GetNode<Area3D>("AireDetectionEspacePlante");
		
		Timer intervalleDetectionEspacePlante= GetNode<Timer>("IntervalleDetectionEspacesPlantes");
		intervalleDetectionEspacePlante.Timeout += EffectuerProcedurePrevisualisationPlante;
	}

	public override void _PhysicsProcess(double delta)
	{
		EffectuerActionPrincipale(delta);
	}
	
	public override void EffectuerActionPrincipale(double delta)
	{
		if (Input.IsMouseButtonPressed(MouseButton.Right))
		{
			Array<Area3D> airesDetectees = _aireDetectionEspacePlante.GetOverlappingAreas();
			int resultatRecherche = DetectionEspacePlante.DetecterEspacePlante(airesDetectees);

			if (EspacePlanteEstDetectee(resultatRecherche))
			{
				AjouterPlanteDansEspace(airesDetectees, resultatRecherche);
			}
		}
	}

	private void AjouterPlanteDansEspace(Array<Area3D> airesDetectees, int resultatRecherche)
	{
		if (airesDetectees[resultatRecherche] is EspacePlante espaceDetectee)
		{
			espaceDetectee.AjouterPlanteDansEspace(_graineContenue);
		}
	}

	private void EffectuerProcedurePrevisualisationPlante()
	{
		Array<Area3D> airesDetectees = _aireDetectionEspacePlante.GetOverlappingAreas();
		int resultatRecherche = DetectionEspacePlante.DetecterEspacePlante(airesDetectees);

		if (EspacePlanteEstDetectee(resultatRecherche))
		{
			PrevisualiserPlante(airesDetectees[resultatRecherche]);
		}
	}

	private void PrevisualiserPlante(Area3D espacePlantePotentiel)
	{
		if (espacePlantePotentiel is EspacePlante espacePlante)
		{
			espacePlante.PrevisualiserPlante(_graineContenue);
		}
	}

	private bool EspacePlanteEstDetectee(int resultatRecherche)
	{
		return resultatRecherche >= 0;
	}
	
	public override int EstObjetDeMain()
	{
		return ValeurObjetMainGauche;
	}
	
}
