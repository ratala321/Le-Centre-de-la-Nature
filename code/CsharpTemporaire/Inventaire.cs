using Godot;
using Godot.Collections;

namespace PremierTest3d.code.CsharpTemporaire;

public abstract class Inventaire : Control
{
    [Export] private readonly Array<GodotObject> _inventaireParDefaut;
    
    private ItemList _listeInventaire;
    private Node _proprietaireInventaire;
    private string _cheminFichierSauvegarde;
    public override void _Ready()
    {
        ProcessMode = ProcessModeEnum.WhenPaused;
        
        _listeInventaire = (ItemList) GetNode("ItemList");
        
        _proprietaireInventaire = GetParent();
        
        string nomFichierSauvegarde = _proprietaireInventaire.Name;
        _cheminFichierSauvegarde = "user://" + nomFichierSauvegarde + ".txt";
    }

    public override void _Notification(int notification)
    {
        if (FermetureJeuEstDemandee(notification))
        {
            //obtenir contenu inventaire
            //sauvegarder contenu
        }
    }

    private static bool FermetureJeuEstDemandee(int notification)
    {
        return notification == NotificationWMCloseRequest;
    }

    public void montrerInterface()
    {
        Show();
        Input.MouseMode = Input.MouseModeEnum.Confined;
        GetTree().Paused = true;
    }

    public void cacherInterface()
    {
        Hide();
        Input.MouseMode = Input.MouseModeEnum.Captured;
        GetTree().Paused = false;
    }

    /// <summary>
    /// Permet d'effectuer la procedure de selection d'un objet dans un inventaire.
    /// </summary>
    public abstract void EffectuerProcedureSelectionObjet();
}