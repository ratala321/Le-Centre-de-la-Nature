using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class Epee : Outils
{
    private const string NomEpee = "Epee";
    
    public override void EffectuerProcedureSelectionDepuisInventaire()
    {
        GD.Print("PROCEDURE EPEE");
    }

    public override int estObjetDeMain()
    {
        GD.Print("temporaire");
        return VALEUR_OBJET_MAIN_DROITE;
    }
}