using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;


public partial class JoueurCanard : CharacterBody3D, IUsageInventaireJoueur, IInteragirJoueur,
	IMobiliteJoueur, ISaisieEntreeMouvementJoueur, IProprietaireInventaire
{
	private RayCast3D _raycastJoueurSol;
	private AnimationPlayer _animationJoueur;
	private Area3D _aireInteraction;
	private Node3D _axeRotationCamera;
	private AudioStreamPlayer _audioJoueur;
	private Timer _chronometreEsquive;
	private InventaireJoueur _inventaireJoueur;
	public override void _Ready()
	{
		_raycastJoueurSol = (RayCast3D)GetNode("RayEstAuSol");
		_animationJoueur = (AnimationPlayer)GetNode("KayKit_AnimatedCharacter_v13/AnimationPlayer");
		_aireInteraction = (Area3D)GetNode("AireInteraction");
		_axeRotationCamera = (Node3D)GetNode("AxeRotationCamera");
		_audioJoueur = (AudioStreamPlayer)GetNode("AudioStreamPlayer");
		_chronometreEsquive = (Timer)GetNode("ChronometreEsquive");
		_inventaireJoueur = GetNode<InventaireJoueur>("InventaireJoueur");
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

	public void LancerProcedureInteraction()
	{
		_interactionJoueur.EffectuerProcedureInteraction();
	}

	private bool _permissionMouvement = true;
	public bool PeutSeMouvoir()
	{
		return _permissionMouvement;
	}
	
	public void ArreterMouvement()
	{
		_permissionMouvement = false;
	}

	public void RelancerMouvement()
	{
		_permissionMouvement = true;
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

	private bool _objetMainDroiteEnMain = false;
	public bool ObjetMainDroiteEnMain => _objetMainDroiteEnMain;
	private bool _objetMainGaucheEnMain = false;
	public bool ObjetMainGaucheEnMain => _objetMainGaucheEnMain;
	public Inventaire InventaireJoueur => _inventaireJoueur;
	public AnimationPlayer AnimationJoueur => _animationJoueur;
	public Area3D AireInteraction => _aireInteraction;
	public Node3D AxeRotationCamera => _axeRotationCamera;
	public Timer ChronometreEsquive => _chronometreEsquive;
	public AudioStreamPlayer AudioJoueur => _audioJoueur;

	public Vector3 RotationJoueur
	{
		get => this.Rotation;
		set => this.Rotation = value;
	}

	public Vector3 VelociteJoueur
	{
		get => this.Velocity;
		set => this.Velocity = value;
	}

}
