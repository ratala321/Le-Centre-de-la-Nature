using Godot;
using Godot.Collections;

namespace PremierTest3d.code.CsharpTemporaire;

public class DetectionEspacePlante
{
    
    /// <returns>Retourne l'index de l'espace plante detecte, autrement retourne -1.</returns>
    public static int DetecterEspacePlante(Array<Area3D> airesDetectees)
    {
        int i = 0;
        while (i < airesDetectees.Count && AireNEstPasEspacePlante(airesDetectees[i]))
        {
            i++;
        }

        if (AucuneAireEstEspacePlante(airesDetectees.Count, i))
        {
            i = -1;
        }

        return i;
    }

    private static bool AireNEstPasEspacePlante(Area3D espacePotentiel)
    {
        return !AireEstEspacePlante(espacePotentiel);
    }
    private static bool AireEstEspacePlante(Area3D espacePotentiel)
    {
        return espacePotentiel is EspacePlante;
    }

    private static bool AucuneAireEstEspacePlante(int nombreAires, int indexEnCours)
    {
        return indexEnCours >= nombreAires;
    }

}