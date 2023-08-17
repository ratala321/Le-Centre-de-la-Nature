using Godot;
using Godot.Collections;

namespace PremierTest3d.code.CsharpTemporaire;

public class SacGraine : RigidBody3D, IPossesseurActionPrincipale
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
    
    public void EffectuerActionPrincipale(double delta)
    {
        if (Input.IsMouseButtonPressed(MouseButton.Left))
        {
            Array<Area3D> airesDetectees = _aireDetectionEspacePlante.GetOverlappingAreas();
            int resultatRecherche = DetecterEspacePlante(airesDetectees);

            if (EspacePlanteEstDetectee(resultatRecherche))
            {
                AjouterPlanteDansEspace(airesDetectees, resultatRecherche);
            }
        }
    }

    /// <returns>Retourne l'index de l'espace plante detecte, autrement retourne -1.</returns>
    private int DetecterEspacePlante(Array<Area3D> airesDetectees)
    {
        int i = 0;
        while (i < airesDetectees.Count && AireNEstPasEspacePlante(airesDetectees[i]))
        {
            i++;
        }

        if (i >= airesDetectees.Count)
        {
            i = -1;
        }

        return i;
    }

    private bool AireNEstPasEspacePlante(Area3D espacePotentiel)
    {
        return !AireEstEspacePlante(espacePotentiel);
    }
    private bool AireEstEspacePlante(Area3D espacePotentiel)
    {
        return espacePotentiel is EspacePlante;
    }
    
    private bool EspacePlanteEstDetectee(int resultatRecherche)
    {
        return resultatRecherche >= 0;
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
        //TODO 
    }

}