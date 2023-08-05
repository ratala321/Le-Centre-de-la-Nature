using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public class Coffre : ObjetInteractif
{
    public override void EffectuerInteraction(Object interacteur)
    {
        if (interacteur is IProprietaireInventaire interacteurProprietaire)
        {
            //TODO interaction
        }
    }
}