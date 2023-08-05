using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

/// <summary>
/// Interface specifiant les pre-requis pour utiliser la composante de mouvement joueur.
/// </summary>
public interface IMobiliteJoueur
{
    bool EstAuSol();
    bool PeutSeMouvoir();
    AnimationPlayer AnimationJoueur { get; }
    Area3D AireInteraction { get; }
    Node3D AxeRotationCamera { get; }
    Vector3 RotationJoueur { get; set; }
    AudioStreamPlayer AudioJoueur { get; }
    Vector3 VelociteJoueur { get; set; }
    Action<IMobiliteJoueur> GetMoveAndSlide();
}