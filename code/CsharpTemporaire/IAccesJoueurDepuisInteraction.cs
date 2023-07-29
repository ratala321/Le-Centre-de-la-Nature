using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

/// <summary>
/// Interface limitant l'acces aux methodes pour une composante d'interaction joueur.
/// </summary>
public interface IAccesJoueurDepuisInteraction
{
    bool EstAuSol();
    AnimationPlayer AnimationJoueur { get; }
    Area3D AireInteraction { get; }

}