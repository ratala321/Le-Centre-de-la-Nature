using Godot;

namespace PremierTest3d.code.CsharpTemporaire;

public struct DonneesObjetInventaire
{
    public DonneesObjetInventaire(string nomObjet, Variant metaDataObjet)
    {
        NomObjet = nomObjet;
        MetaDataObjet = metaDataObjet;
    }

    public string NomObjet { get; }
    public Variant MetaDataObjet { get; }
}