using System;
using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

public class MouvementJoueur
{
	private IMobiliteJoueur _joueur;
	public MouvementJoueur(IMobiliteJoueur joueur)
	{
		_joueur = joueur;
	}

	public void EffectuerProcedureApplicationMouvement(double delta, FacteursMouvementJoueur facteursMouvementJoueur)
	{
		EffectuerProcessusApplicationGravite(delta);
		
		if (_joueur.PeutSeMouvoir())
		{
			AppliquerRotationJoueur(facteursMouvementJoueur.IndexFacteursRotation);
		
			AppliquerAnimationMouvement(facteursMouvementJoueur.DirectionJoueur);
		
			AppliquerMouvement
				(delta, facteursMouvementJoueur.DirectionJoueur, facteursMouvementJoueur.VitesseEsquiveJoueur);
		}
	}

	private const short GraviteSolJoueur = -100;
	private const short GraviteSautJoueur = -60;
	private void EffectuerProcessusApplicationGravite(double delta)
	{
		if (JoueurEstEnSaut())
		{
			AppliquerGravite(GraviteSautJoueur, delta);
		}
		else
		{
			AppliquerGravite(GraviteSolJoueur, delta);
		}

		Action<IMobiliteJoueur> moveAndSlide = _joueur.GetMoveAndSlide();
		moveAndSlide(_joueur);
	}

	private void AppliquerRotationJoueur(int indexFacteursRotation)
	{
		if (JoueurEstEnMouvement(indexFacteursRotation))
		{
			Vector3 rotationInitialeCamera = _joueur.AxeRotationCamera.GlobalRotationDegrees;

			float angleRotation = CalculerAngleRotation(indexFacteursRotation);

			//_joueur.RotationJoueur = 
			//	_joueur.RotationJoueur.Rotated(new Vector3(0, 1, 0), angleRotation);
			
			_joueur.RotationJoueur = new Vector3(_joueur.RotationJoueur.X,
				angleRotation,
				_joueur.RotationJoueur.Z);
			
			ConserverRotationInitialeCamera(rotationInitialeCamera);
		}
	}
	
	//TODO animation tree?
	private const string AnimationSaut = "Jump";
	private const string AnimationMarche = "Walk";
	private const string AnimationIdle = "Idle";
	private const int VitesseAnimationInitiale = 1;
	private const float VitesseAnimationSaut = 1.9f;
	private void AppliquerAnimationMouvement(Vector3 directionJoueur)
	{
		if (AnimationSautPeutEtreJouee())
		{
			_joueur.AnimationJoueur.Play(AnimationSaut);
			_joueur.AnimationJoueur.SpeedScale = VitesseAnimationSaut;
		} else if (AnimationMarchePeutEtreJouee(directionJoueur))
		{
			_joueur.AnimationJoueur.SpeedScale = VitesseAnimationInitiale;
			_joueur.AnimationJoueur.Play(AnimationMarche);
		}
		else
		{
			_joueur.AnimationJoueur.SpeedScale = VitesseAnimationInitiale;
			_joueur.AnimationJoueur.Play(AnimationIdle);
		}
		
	}

	private void AppliquerMouvement(double delta, Vector3 directionJoueur, int vitesseEsquiveJoueur)
	{
		AppliquerMouvementVertical(delta, directionJoueur);
		
		AppliquerMouvementHorizontal(delta, directionJoueur, vitesseEsquiveJoueur);
	}

	private bool JoueurEstEnSaut()
	{
		return _joueur.VelociteJoueur.Y > 0;
	}

	private void AppliquerGravite(short constanteGravite, double delta)
	{
		float velociteJoueurY = (float)(_joueur.VelociteJoueur.Y + constanteGravite * delta);
		_joueur.VelociteJoueur = new Vector3(_joueur.VelociteJoueur.X, velociteJoueurY, _joueur.VelociteJoueur.Z);
	}
	
	private const int ValeurIndexAucunMouvement = 4;
	private static bool JoueurEstEnMouvement(int indexFacteursRotation)
	{
		return indexFacteursRotation != ValeurIndexAucunMouvement;
	}

	private const float InterpolationRotationJoueur = 0.25f;
	private float CalculerAngleRotation(int indexFacteursRotation)
	{
		return Mathf.LerpAngle(_joueur.RotationJoueur.Y,
			CalculerFacteurRotation(indexFacteursRotation),
			InterpolationRotationJoueur);
	}
	
	private static readonly double[] FacteursRotation =
	{
		-3 * Math.PI / 4, // rotation diagonale arriere droite
		Math.PI, // rotation arriere
		3 * Math.PI / 4, // rotation arriere gauche
		(-Math.PI) / 2, // rotation droite
		0,
		Math.PI / 2, // rotation gauche
		(-Math.PI) / 4, // rotation diagonale avant droite
		2 * Math.PI, // rotation avant
		Math.PI / 4, // rotation diagonale avant gauche
	};

	private float CalculerFacteurRotation(int indexFacteursRotation)
	{
		float facteurRotation = (float)FacteursRotation[indexFacteursRotation];

		facteurRotation = AjustementFacteurRotationSelonDirectionCamera(facteurRotation);
		
		return facteurRotation;
	}

	private float AjustementFacteurRotationSelonDirectionCamera(float facteurRotation)
	{
		return facteurRotation + _joueur.AxeRotationCamera.GlobalRotation.Y;
	}

	private void ConserverRotationInitialeCamera(Vector3 rotationInitialeCamera)
	{
		_joueur.AxeRotationCamera.GlobalRotationDegrees = rotationInitialeCamera;
	}

	private void AppliquerMouvementVertical(double delta, Vector3 directionJoueur)
	{
		if (JoueurAvaitSaisiBouttonSaut(directionJoueur) && _joueur.EstAuSol())
		{
			AppliquerSaut(delta);
		}
	}
	
	private static bool JoueurAvaitSaisiBouttonSaut(Vector3 directionJoueur)
	{
		return directionJoueur.Y != 0;
	}

	private const int HauteurMaximaleSaut = 4250;
	private const int TempsHauteurMaximalSaut = 7;
	private const int ImpulsionSautJoueur = 2 * HauteurMaximaleSaut / TempsHauteurMaximalSaut;
	private static readonly AudioStream SonSaut = (AudioStream)ResourceLoader.Load("res://sons/jump_8bits.mp3");
	private void AppliquerSaut(double delta)
	{
		_joueur.VelociteJoueur =
			new Vector3(_joueur.VelociteJoueur.X, (float)(ImpulsionSautJoueur * delta), _joueur.VelociteJoueur.Z);

		_joueur.AudioJoueur.Stream = SonSaut;
		_joueur.AudioJoueur.Play();
	}

	private void AppliquerMouvementHorizontal(double delta, Vector3 directionJoueur, int vitesseEsquiveJoueur)
	{
		Vector3 velocite = new Vector3(
			CalculerVelociteEnX(delta, directionJoueur, vitesseEsquiveJoueur),
			_joueur.VelociteJoueur.Y,
			CalculerVelociteEnZ(delta, directionJoueur, vitesseEsquiveJoueur)
		);
			
		_joueur.VelociteJoueur = velocite;
		
		Action<IMobiliteJoueur> moveAndSlide = _joueur.GetMoveAndSlide();
		moveAndSlide(_joueur);
	}

	[Export] private static readonly int VitesseJoueurBase = 450;
	private static float CalculerVelociteEnX(double delta, Vector3 directionJoueur, int vitesseEsquiveJoueur)
	{
		return (float)(directionJoueur.X * VitesseJoueurBase * delta * vitesseEsquiveJoueur);
	}
	
	private static float CalculerVelociteEnZ(double delta, Vector3 directionJoueur, int vitesseEsquiveJoueur)
	{
		return (float)(directionJoueur.Z * VitesseJoueurBase * delta * vitesseEsquiveJoueur);
	}

	private bool AnimationSautPeutEtreJouee()
	{
		return !_joueur.EstAuSol() && _joueur.AnimationJoueur.HasAnimation(AnimationSaut);
	}

	private bool AnimationMarchePeutEtreJouee(Vector3 directionJoueur)
	{
		return !directionJoueur.Equals(Vector3.Zero) &&
			   _joueur.AnimationJoueur.HasAnimation(AnimationMarche);
	}
}
