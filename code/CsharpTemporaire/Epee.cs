using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class Epee : Outils
{
    private const string NomEpee = "Epee";
    
    public override void EffectuerProcedureSelectionDepuisInventaire()
    {
        GD.Print("PROCEDURE EPEE");
    }

    public override int EstObjetDeMain()
    {
        GD.Print("temporaire");
        return ValeurObjetMainDroite;
    }
}