using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public abstract class ObjetInteractif : AnimatableBody3D
{
    private Area3D _aireInteraction;
    public override void _Ready()
    {
        _aireInteraction = (Area3D) GetNode("AireInteraction");
    }

    /// <summary>
    /// Permet d'effectuer une serie d'instructions liee a l'interaction associee a l'objet interactif.
    /// </summary>
    public abstract void EffectuerInteraction(Object interacteur);
}