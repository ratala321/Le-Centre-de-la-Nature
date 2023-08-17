using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class SacGraine : RigidBody3D, IPossesseurActionPrincipale
{
    private PackedScene _graineContenue =
        ResourceLoader.Load<PackedScene>("res://scenes/plantesScenes/BleScene.tscn");

    private Area3D _aireDetectionEspacePlante;
    public override void _Ready()
    {
        _aireDetectionEspacePlante = GetNode<Area3D>("AireDetectionEspacePlante");
        
        Timer intervalleDetectionEspacePlante= GetNode<Timer>("IntervalleDetectionEspacesPlantes");
        intervalleDetectionEspacePlante.Timeout += EffectuerProcedurePrevisualisationPlante;
    }

    private void EffectuerProcedurePrevisualisationPlante()
    {
       //TODO 
    }

    public void EffectuerActionPrincipale()
    {
        //TODO
    }
}