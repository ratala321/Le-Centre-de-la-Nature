using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

/// <summary>
/// Interface specifiant les pre-requis pour utiliser la composante de saisie d'entree pour mouvement joueur.
/// </summary>
public interface ISaisieEntreeMouvementJoueur
{
    bool PeutSeMouvoir();
    Node3D AxeRotationCamera { get; }
    Timer ChronometreEsquive { get; }
}