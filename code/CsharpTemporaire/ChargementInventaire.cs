using System.Collections.Generic;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class ChargementInventaire
{
    public static void ChargerDonneesContenuInventaire(Inventaire inventaire)
    {
        if (InventaireNEstPasCreeProceduralement(inventaire))
        {
            EffectuerProcedureChargementContenuInventaire(inventaire);
        }
    }

    private static bool InventaireNEstPasCreeProceduralement(Inventaire inventaire)
    {
        return inventaire.ListeInventaire.ItemCount == 0;
    }

    private static void EffectuerProcedureChargementContenuInventaire(Inventaire inventaire)
    {
        List<DonneesObjetInventaire> donneesContenuInventaire = LireDonneesContenuInventaire(inventaire);
        
        DistribuerObjetsDansInventaire(inventaire.ListeInventaire, donneesContenuInventaire);
    }

    private static List<DonneesObjetInventaire> LireDonneesContenuInventaire(Inventaire inventaire)
    {
        List<DonneesObjetInventaire> donneesContenuInventaire = new List<DonneesObjetInventaire>();
        
        if (FichierSauvegardeEstExistant(inventaire.CheminFichierInventaire))
        {
            donneesContenuInventaire = LireInventaireSauvegarde(inventaire);
        }
        else if (InventaireParDefautEstExistant(inventaire))
        {
            donneesContenuInventaire = LireInventaireParDefaut(inventaire);
        }

        return donneesContenuInventaire;
    }

    private static bool FichierSauvegardeEstExistant(string cheminFichierSauvegarde)
    {
        return FileAccess.FileExists(cheminFichierSauvegarde);
    }

    private static bool InventaireParDefautEstExistant(Inventaire inventaire)
    {
        return inventaire.InventaireParDefaut != null &&
               InventaireParDefautNEstPasVide(inventaire);
    }

    private static bool InventaireParDefautNEstPasVide(Inventaire inventaire)
    {
        return inventaire.InventaireParDefaut.Count != 0;
    }

    private static List<DonneesObjetInventaire> LireInventaireSauvegarde(Inventaire inventaire)
    {
        FileAccess lecteurFichierSauvegarde =
            FileAccess.Open(inventaire.CheminFichierInventaire, FileAccess.ModeFlags.Read);
        
        List<DonneesObjetInventaire> donneesObjetsSauvegardes = new List<DonneesObjetInventaire>();

        while (LectureFichierEstIncomplete(lecteurFichierSauvegarde))
        {
            DonneesObjetInventaire donneesObjetSauvegarde = LireDonneesObjetSauvegarde(lecteurFichierSauvegarde);
            donneesObjetsSauvegardes.Add(donneesObjetSauvegarde);
        }
        
        lecteurFichierSauvegarde.Close();
        return donneesObjetsSauvegardes;
    }

    private static List<DonneesObjetInventaire> LireInventaireParDefaut(Inventaire inventaire)
    {
        List<DonneesObjetInventaire> donneesObjetsParDefaut = new List<DonneesObjetInventaire>();
        
        for (int i = 0; i < inventaire.InventaireParDefaut.Count; i += 2)
        {
            DonneesObjetInventaire donneesObjetParDefaut = LireDonneesObjetParDefaut(i, inventaire);
            donneesObjetsParDefaut.Add(donneesObjetParDefaut);
        }
        
        return donneesObjetsParDefaut;
    }

    private static void DistribuerObjetsDansInventaire(ItemList listeInventaire, List<DonneesObjetInventaire> donneesObjets)
    {
        foreach (DonneesObjetInventaire donneesObjet in donneesObjets)
        {
            listeInventaire.AddItem(donneesObjet.NomObjet);
            listeInventaire.SetItemMetadata(-1, donneesObjet.MetaDataObjet);
        }
    }

    private static DonneesObjetInventaire LireDonneesObjetSauvegarde(FileAccess lecteurFichier)
    {
        string nomObjet = lecteurFichier.GetVar().AsString();
        Variant metaDataObjet = lecteurFichier.GetVar(true);

        return new DonneesObjetInventaire(nomObjet, metaDataObjet);
    }

    private static bool LectureFichierEstIncomplete(FileAccess lecteurFichier)
    {
        return lecteurFichier.GetPosition() < lecteurFichier.GetLength();
    }

    private static DonneesObjetInventaire LireDonneesObjetParDefaut(int index, Inventaire inventaire)
    {
        string nomObjet = inventaire.InventaireParDefaut[index].AsString();
        Variant metaDataObjet = inventaire.InventaireParDefaut[index + 1];
        
        return new DonneesObjetInventaire(nomObjet, metaDataObjet);
    }
}