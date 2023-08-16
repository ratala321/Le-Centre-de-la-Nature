using System.Collections.Generic;
using System.Transactions;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class SolFertile : ObjetInteractif
{
    [Export] private List<NodePath> _plantesAjouteesEditeurDepart;
    
    public override void _Ready()
    {
        base._Ready();
        
        Timer chronoIntervalleCroissance = (Timer)GetNode("IntervalleAvancementCroissance");
        chronoIntervalleCroissance.Timeout += AvancerCroissancePlantes;
        
        AjouterPlantesProvenantEditeur();
    }

    private void AjouterPlantesProvenantEditeur()
    {
        foreach (NodePath cheminPlante in _plantesAjouteesEditeurDepart)
        {
            Plante instancePlante = (Plante)GetNode(cheminPlante);
            _plantesContenues.Add(instancePlante);
        }
    }

    private const int TempsAvancement = 1;
    private void AvancerCroissancePlantes()
    {
        foreach (Plante planteContenue in _plantesContenues)
        {
            planteContenue.AvancerCroissance(TempsAvancement);
        }
    }

    public override void EffectuerInteraction(object interacteur)
    {
        //TODO
        GD.Print("Interaction avec sol fertile");
    }

    private List<Plante> _plantesContenues = new List<Plante>();
    public void AjouterPlanteContenue(Plante plante)
    {
        _plantesContenues.Add(plante);
    }
}