using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

/// <summary>
/// Interface specifiant les pre-requis pour utiliser la composante d'interaction joueur.
/// </summary>
public interface IInteragirJoueur
{
    bool EstAuSol();
    AnimationPlayer AnimationJoueur { get; }
    Area3D AireInteraction { get; }

}