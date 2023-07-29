using Godot;
using Godot.Collections;

namespace PremierTest3d.code.CsharpTemporaire;

public class InteractionJoueur
{
    private readonly JoueurCanard _joueur;
    public InteractionJoueur(JoueurCanard joueur)
    {
        _joueur = joueur;
    }

    public void InteragirAvecObjetInteractif()
    {
        Array<Node3D> objetsEnCollision = _joueur.AireInteraction.GetOverlappingBodies();
        int i = 0;
        bool objetInteractifTrouve = false;
        while (RechercheObjetInteractifEstEnCours(i, objetsEnCollision.Count, objetInteractifTrouve))
        {
            if (EstObjetInteractif(objetsEnCollision[i]))
            {
                objetInteractifTrouve = true;
                LancerInteractionAvecObjetInteractif((ObjetInteractif) objetsEnCollision[i]);
            }
        }
    }

    private static bool RechercheObjetInteractifEstEnCours
        (int compteur, int nombreObjetsInteractifsPotentiels, bool objetInteractifTrouve)
    {
        return compteur < nombreObjetsInteractifsPotentiels && !objetInteractifTrouve;
    }

    private static bool EstObjetInteractif(Node3D objetEnCollision)
    {
        return objetEnCollision is ObjetInteractif;
    }

    private static void LancerInteractionAvecObjetInteractif(ObjetInteractif objet)
    {
        objet.EffectuerInteraction();
    }

    public void EffectuerInteractionJoueur()
    {
        if (JoueurPeutInteragir(_joueur))
        {
            JouerAnimationInteraction(_joueur);
        }
    }

    private static bool JoueurPeutInteragir(JoueurCanard joueur)
    {
        return JoueurEstAuSol(joueur) && Input.IsActionPressed("interaction_joueur");
    }

    private const float VitesseAnimationInteraction = 1.5f;
    private const string NomAnimationInteraction = "Interact";
    private static void JouerAnimationInteraction(JoueurCanard joueur)
    {
        joueur.AnimationJoueur.SpeedScale = VitesseAnimationInteraction;
        joueur.AnimationJoueur.Play(NomAnimationInteraction);
    }

    private static bool JoueurEstAuSol(JoueurCanard joueur)
    {
        return joueur.RaycastJoueurSol.IsColliding();
    }
}