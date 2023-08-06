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

    public void AfficherInterface()
    {
        Show();
        Input.MouseMode = Input.MouseModeEnum.Confined;
        GetTree().Paused = true;
    }

    public void CacherInterface()
    {
        Hide();
        Input.MouseMode = Input.MouseModeEnum.Captured;
        GetTree().Paused = false;
    }

    private Inventaire _inventaireDestination;

    public void TransfererObjetVersInventaireDestination(int indexObjet)
    {
        CopierObjetVersDestination(_inventaireDestination.ListeInventaire, indexObjet);
        CopierMetaDataVersDestination(_inventaireDestination.ListeInventaire, indexObjet);
        RetirerObjetTransfereInventaire(indexObjet);
    }

    private void CopierObjetVersDestination(ItemList destination, int indexObjet)
    {
        string nomObjet = _listeInventaire.GetItemText(indexObjet);

        destination.AddItem(nomObjet);
    }

    private void CopierMetaDataVersDestination(ItemList destination, int indexObjet)
    {
        Variant metaDataObjet = _listeInventaire.GetItemMetadata(indexObjet);
        int indexObjetDestination = destination.ItemCount - 1;
        
        destination.SetItemMetadata(indexObjetDestination, metaDataObjet);
    }

    private void RetirerObjetTransfereInventaire(int indexObjet)
    {
        _listeInventaire.RemoveItem(indexObjet);
    }
    
    public Inventaire InventaireDestination
    {
        get => this._inventaireDestination;
        set => this._inventaireDestination = value;
    }
    public ItemList ListeInventaire => _listeInventaire;

    /// <summary>
    /// Permet d'effectuer la procedure de selection d'un objet dans un inventaire.
    /// Doit etre connectee au signal ItemClicked d'un ItemList.
    /// </summary>
    public abstract void EffectuerProcedureSelectionObjet(long index, Vector2 atPosition, long mouseButtonIndex);
}