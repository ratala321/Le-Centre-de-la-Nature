using System.Collections.Generic;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class SauvegardeInventaire
{
    public static void SauvegarderDonneesContenuInventaire
        (List<DonneesObjetInventaire> donneesASauvegarder, string cheminFichierSauvegarde)
    {
        FileAccess redacteurFichier = FileAccess.Open(cheminFichierSauvegarde, FileAccess.ModeFlags.Write);

        for (int i = 0; i < donneesASauvegarder.Count; i++)
        {
            SauvegarderDonnee(redacteurFichier, donneesASauvegarder[i]);
        }
        
        redacteurFichier.Close();
    }

    private static void SauvegarderDonnee(FileAccess redacteurFichier, DonneesObjetInventaire donneeASauvegarder)
    {
        redacteurFichier.StoreString(donneeASauvegarder.NomObjet);
        redacteurFichier.StoreString("\n");
        redacteurFichier.StoreString(donneeASauvegarder.CheminSceneObjet);
        redacteurFichier.StoreString("\n");
    }
}