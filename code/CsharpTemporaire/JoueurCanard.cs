using Godot;

namespace PremierTest3d.code.CsharpTemporaire;


public class JoueurCanard : CharacterBody3D, IAccesJoueurDepuisInventaire, IAccesJoueurDepuisInteraction
{
    private RayCast3D _raycastJoueurSol;
    private AnimationPlayer _animationJoueur;
    private Area3D _aireInteraction;
    private InventaireJoueur _inventaireJoueur;
    public override void _Ready()
    {
        _raycastJoueurSol = (RayCast3D) GetNode("RayEstAuSol");
        _animationJoueur = (AnimationPlayer) GetNode("KayKit_AnimatedCharacter_v13/AnimationPlayer");
        _aireInteraction = (Area3D) GetNode("AireInteraction");
        _inventaireJoueur = (InventaireJoueur)GetNode("InventaireJoueur;");
    }

    private readonly InteractionJoueur _interactionJoueur;
    private readonly AffichageInventaireJoueur _affichageInventaireJoueur;
    public JoueurCanard()
    {
        _interactionJoueur = new InteractionJoueur(this);
        _affichageInventaireJoueur = new AffichageInventaireJoueur(this);
    }

    public override void _PhysicsProcess(double delta)
    {
        _affichageInventaireJoueur.EffectuerAffichageInventaireJoueur();
        
        _interactionJoueur.EffectuerInteractionJoueur();
    }

    private const byte VitesseAmimationInitiale = 1;
    public void ReinitialiserVitesseAnimation()
    {
        _animationJoueur.SpeedScale = VitesseAmimationInitiale;
    }
    
    public bool EstAuSol()
    {
        return _raycastJoueurSol.IsColliding();
    }

    public bool PeutSeMouvoir()
    {
        //return _permissionMouvement
        throw new System.NotImplementedException();
    }

    public bool NiveauDuJoueurEstEnPause()
    {
        return GetTree().Paused;
    }
    
    public InventaireJoueur InventaireJoueur => _inventaireJoueur;
    public AnimationPlayer AnimationJoueur => _animationJoueur;
    public Area3D AireInteraction => _aireInteraction;
}