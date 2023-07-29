using System.Runtime.CompilerServices;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;


public class JoueurCanard : CharacterBody3D
{
    private RayCast3D _raycastJoueurSol;
    private AnimationPlayer _animationJoueur;
    private Area3D _aireInteraction;
    public override void _Ready()
    {
        _raycastJoueurSol = (RayCast3D) GetNode("RayEstAuSol");
        _animationJoueur = (AnimationPlayer) GetNode("KayKit_AnimatedCharacter_v13/AnimationPlayer");
        _aireInteraction = (Area3D) GetNode("AireInteraction");
    }

    private readonly InteractionJoueur _interactionJoueur;
    public JoueurCanard()
    {
        _interactionJoueur = new InteractionJoueur(this);
    }

    public override void _PhysicsProcess(double delta)
    {
        _interactionJoueur.EffectuerInteractionJoueur();
    }

    private const byte VitesseAmimationInitiale = 1;
    public void ReinitialiserVitesseAnimation()
    {
        _animationJoueur.SpeedScale = VitesseAmimationInitiale;
    }

    internal RayCast3D RaycastJoueurSol => _raycastJoueurSol;
    internal AnimationPlayer AnimationJoueur => _animationJoueur;

    internal Area3D AireInteraction => _aireInteraction;
}