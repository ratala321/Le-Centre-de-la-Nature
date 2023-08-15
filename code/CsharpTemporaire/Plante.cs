using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class Plante : AnimatableBody3D
{
    [Export] private NodePath[] _etapesCroissances;

    private const int DureeCroissanceInitiale = 10;
    private int _dureeCroissance = DureeCroissanceInitiale;
    private int _etapeCroissanceActuelle = 0;

    public void AvancerCroissance(int intervalleTemps)
    {
        _dureeCroissance -= intervalleTemps;

        if (CroissanceEstFinie() && ResteEtapesCroissance())
        {
            CroitrePlanteVisuellement();
            
            _dureeCroissance = DureeCroissanceInitiale;
        }
    }

    private bool CroissanceEstFinie()
    {
        return _dureeCroissance <= 0;
    }

    private bool ResteEtapesCroissance()
    {
        return _etapeCroissanceActuelle < _etapesCroissances.Length - 1;
    }

    private void CroitrePlanteVisuellement()
    {
        CacherEtapeCroissanceFinie();
        
        _etapeCroissanceActuelle += 1;
        
        AfficherEtapeCroissanceSuivante();
    }

    private void CacherEtapeCroissanceFinie()
    {
        Node3D sceneEtapeCroissanceActuelle =
            (Node3D)GetNode(_etapesCroissances[_etapeCroissanceActuelle]);
        
        sceneEtapeCroissanceActuelle.Hide();
    }

    private void AfficherEtapeCroissanceSuivante()
    {
        Node3D sceneEtapeCroissanceActuelle =
            (Node3D)GetNode(_etapesCroissances[_etapeCroissanceActuelle]);
        
        sceneEtapeCroissanceActuelle.Show();
    }

    public void CouperPlante()
    {
        //TODO
    }
    
    private SolFertile _referenceSolFertile;
    public SolFertile ReferenceSolFertile
    {
        set
        {
            _referenceSolFertile = value;
            //TODO AJOUTER REFERENCE
        } 
    }

    private EspacePlante _referenceEspacePlante;
    public EspacePlante ReferenceEspacePlante
    {
        set => _referenceEspacePlante = value;
    }
}