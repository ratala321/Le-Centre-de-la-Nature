using Godot;

namespace PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

public class EntreeMouvementJoueur
{
    private readonly ISaisieEntreeMouvementJoueur _joueur;
    public EntreeMouvementJoueur(ISaisieEntreeMouvementJoueur joueur)
    {
        _joueur = joueur;
    }

    public FacteursMouvementJoueur SaisirEntreeMouvementJoueur()
    {
        FacteursMouvementJoueur facteursMouvementJoueur = new FacteursMouvementJoueur();
        
        if (_joueur.PeutSeMouvoir())
        {
            facteursMouvementJoueur = EffectuerProcedureSaisieEntree();
        }

        return facteursMouvementJoueur;

    }

    private FacteursMouvementJoueur EffectuerProcedureSaisieEntree()
    {
        Vector3 directionJoueurBrut = SaisirEntreeDirection();
        
        int indexFacteursRotation = CalculerIndexFacteursRotation(directionJoueurBrut);
        
        int vitesseEsquiveJoueur = SaisirEntreeEsquive();
        
        Vector3 directionJoueur = EffectuerProcedureAjustementDirectionJoueur(directionJoueurBrut);
        
        return new FacteursMouvementJoueur(indexFacteursRotation, vitesseEsquiveJoueur, directionJoueur);
    }

    private Vector3 SaisirEntreeDirection()
    {
        Vector3 entreeDirectionJoueur = SaisirEntreeDirectionHorizontal();
        
        entreeDirectionJoueur.Y = SaisirEntreeDirectionVertical();
        
        return entreeDirectionJoueur;
    }

    private const int VitesseEsquiveAbsente = 1;
    private const int VitesseEsquiveAppliquee = 50;
    private int SaisirEntreeEsquive()
    {
        int vitesseEsquive = VitesseEsquiveAbsente;

        if (Input.IsActionPressed("esquive") && JoueurPeutEsquiver())
        {
            RelancerChronometreEsquive();
            
            vitesseEsquive = VitesseEsquiveAppliquee;
        }
        
        return vitesseEsquive;
    }

    private Vector3 EffectuerProcedureAjustementDirectionJoueur(Vector3 directionJoueurBrut)
    {
        Vector3 directionJoueurAjuste = AjusterDirectionAvantSelonCamera(directionJoueurBrut);

        directionJoueurAjuste = NormaliserDiagonaleDirection(directionJoueurAjuste);

        return directionJoueurAjuste;
    }

    private int CalculerIndexFacteursRotation(Vector3 directionJoueurBrut)
    {
        // creation d'une valeur d'index unique pour chaque direction de rotation
        // exemple direction droite = Vecteur(-1,0,0) -> resultat = -1 + 3 * 0 + 4 = 3
        return (int)(directionJoueurBrut.X + 3 * directionJoueurBrut.Z + 4);
    }

    private const float DirectionDroite = -1;
    private const float DirectionGauche = 1;
    private const float DirectionAvant = 1;
    private const float DirectionArriere = -1;
    private Vector3 SaisirEntreeDirectionHorizontal()
    {
        Vector3 directionJoueurHorizontal = new Vector3();
        
        if (Input.IsActionPressed("mouvement_avant"))
        {
            directionJoueurHorizontal.Z = DirectionAvant;
        }
        
        if (Input.IsActionPressed("mouvement_arriere"))
        {
            directionJoueurHorizontal.Z = DirectionArriere;
        }

        if (Input.IsActionPressed("mouvement_droite"))
        {
            directionJoueurHorizontal.X = DirectionDroite;
        }
        
        if (Input.IsActionPressed("mouvement_gauche"))
        {
            directionJoueurHorizontal.X = DirectionGauche;
        }

        return directionJoueurHorizontal;
    }

    private float SaisirEntreeDirectionVertical()
    {
        float directionVerticaleJoueur = 0;

        if (Input.IsActionPressed("saut"))
        {
            directionVerticaleJoueur = 1;
        }
        
        return directionVerticaleJoueur;
    }

    private bool JoueurPeutEsquiver()
    {
        return _joueur.ChronometreEsquive.IsStopped();
    }

    private const byte IntervalleEsquiveJoueur = 3;
    private void RelancerChronometreEsquive()
    {
        _joueur.ChronometreEsquive.Start(IntervalleEsquiveJoueur);
    }

    private Vector3 AjusterDirectionAvantSelonCamera(Vector3 directionJoueurBrut)
    {
        Vector3 directionAvant = CalculerDirectionAvant();

        return directionJoueurBrut.Rotated(new Vector3(0, 1, 0), directionAvant.Y);
    }

    private Vector3 CalculerDirectionAvant()
    {
        return _joueur.AxeRotationCamera.GlobalRotation;
    }

    private Vector3 NormaliserDiagonaleDirection(Vector3 directionJoueur)
    {
        if (NormalisationEstNecessaire(directionJoueur))
        {
            directionJoueur = directionJoueur.Normalized();
        }

        return directionJoueur;
    }

    private static bool NormalisationEstNecessaire(Vector3 vecteurNonNormalise)
    {
        return vecteurNonNormalise != Vector3.Zero;
    }
    
}