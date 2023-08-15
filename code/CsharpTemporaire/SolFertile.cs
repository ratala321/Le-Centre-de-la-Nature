using System.Transactions;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class SolFertile : ObjetInteractif
{
    
    public override void _Ready()
    {
        base._Ready();
        //TODO Connexion
    }

    public override void EffectuerInteraction(object interacteur)
    {
        //TODO
        GD.Print("Interaction avec sol fertile");
    }
}