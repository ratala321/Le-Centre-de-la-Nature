using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire;


public class JoueurCanard : CharacterBody3D, IUsageInventaireJoueur, IInteragirJoueur,
    IMobiliteJoueur, ISaisieEntreeMouvementJoueur
{
    private RayCast3D _raycastJoueurSol;
    private AnimationPlayer _animationJoueur;
    private Area3D _aireInteraction;
    private InventaireJoueur _inventaireJoueur;
    private Node3D _axeRotationCamera;
    private AudioStreamPlayer _audioJoueur;
    private Timer _chronometreEsquive;
    public override void _Ready()
    {
        _raycastJoueurSol = (RayCast3D)GetNode("RayEstAuSol");
        _animationJoueur = (AnimationPlayer)GetNode("KayKit_AnimatedCharacter_v13/AnimationPlayer");
        _aireInteraction = (Area3D)GetNode("AireInteraction");
        _inventaireJoueur = (InventaireJoueur)GetNode("InventaireJoueur;");
        _axeRotationCamera = (Node3D)GetNode("AxeRotationCamera");
        _audioJoueur = (AudioStreamPlayer)GetNode("AudioStreamPlayer");
        _chronometreEsquive = (Timer)GetNode("ChronometreEsquive");
    }

    private readonly InteractionJoueur _interactionJoueur;
    private readonly AffichageInventaireJoueur _affichageInventaireJoueur;
    private readonly MouvementJoueur _mouvementJoueur;
    private readonly EntreeMouvementJoueur _entreeMouvementJoueur;
    public JoueurCanard()
    {
        _interactionJoueur = new InteractionJoueur(this);
        _affichageInventaireJoueur = new AffichageInventaireJoueur(this);
        _mouvementJoueur = new MouvementJoueur(this);
        _entreeMouvementJoueur = new EntreeMouvementJoueur(this);
    }

    public override void _PhysicsProcess(double delta)
    {
        EffectuerProcedureMouvementJoueur(delta);
        
        _affichageInventaireJoueur.EffectuerAffichageInventaireJoueur();
        
        _interactionJoueur.EffectuerInteractionJoueur();
    }

    private void EffectuerProcedureMouvementJoueur(double delta)
    {
        FacteursMouvementJoueur facteursMouvementJoueur = _entreeMouvementJoueur.SaisirEntreeMouvementJoueur();
        _mouvementJoueur.EffectuerProcedureApplicationMouvement(delta, facteursMouvementJoueur);
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

    private bool _permissionMouvement = true;
    public bool PeutSeMouvoir()
    {
        return _permissionMouvement;
    }

    public bool NiveauDuJoueurEstEnPause()
    {
        return GetTree().Paused;
    }

    public Action<IMobiliteJoueur> GetMoveAndSlide()
    {
        Action<IMobiliteJoueur> moveAndSlide = interfaceJoueur =>
        {
            if (interfaceJoueur is JoueurCanard joueur)
            {
                joueur.MoveAndSlide();
            }
        };

        return moveAndSlide;
    }
    
    public InventaireJoueur InventaireJoueur => _inventaireJoueur;
    public AnimationPlayer AnimationJoueur => _animationJoueur;
    public Area3D AireInteraction => _aireInteraction;
    public Node3D AxeRotationCamera => _axeRotationCamera;
    public Timer ChronometreEsquive => _chronometreEsquive;

    public Vector3 RotationJoueur
    {
        get => this.Rotation;
        set => this.Rotation = value;
    }

    public AudioStreamPlayer AudioJoueur => _audioJoueur;
    public Vector3 VelociteJoueur
    {
        get => this.Velocity;
        set => this.Velocity = value;
    }
    
}