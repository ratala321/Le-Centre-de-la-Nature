using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public readonly struct FacteursMouvementJoueur
{
    public FacteursMouvementJoueur(int indexFacteursRotation, int vitesseEsquiveJoueur,
        Vector3 vecteurDirectionJoueur)
    {
        IndexFacteursRotation = indexFacteursRotation;
        VitesseEsquiveJoueur = vitesseEsquiveJoueur;
        DirectionJoueur = vecteurDirectionJoueur;
    }

    /// <summary>
    /// Utilise pour la rotation du joueur et de la camera.
    /// </summary>
    public int IndexFacteursRotation { get; } 

    public int VitesseEsquiveJoueur { get; }

    /// <summary>
    /// Utilise pour le deplacement du joueur dans une direction.
    /// </summary>
    public Vector3 DirectionJoueur { get; }
}