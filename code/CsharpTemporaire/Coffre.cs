using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class Coffre : ObjetInteractif
{
    public override void EffectuerInteraction(Object interacteur)
    {
        if (interacteur is IProprietaireInventaire interacteurProprietaire)
        {
            Inventaire inventaireCoffre = (Inventaire)GetNode("InventaireCoffre");
            
            AfficherInterfaces(inventaireCoffre, interacteurProprietaire.Inventaire);

            AjouterReferencesInventaireDestination(inventaireCoffre, interacteurProprietaire.Inventaire);
        }
    }

    private static void AfficherInterfaces(Inventaire inventaireCoffre, Inventaire inventaireInteracteur)
    {
        inventaireCoffre.AfficherInterface();
        inventaireInteracteur.AfficherInterface();
    }

    private static void AjouterReferencesInventaireDestination(Inventaire inventaireCoffre,
        Inventaire inventaireInteracteur)
    {
        inventaireCoffre.InventaireDestination = inventaireInteracteur;
        inventaireInteracteur.InventaireDestination = inventaireCoffre;
    }
        
}