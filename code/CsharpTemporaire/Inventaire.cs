using System.Collections;
using System.Collections.Generic;
using Godot;
using Godot.Collections;
using PremierTest3d.code.CsharpTemporaire.paquetCodeJoueur;

namespace PremierTest3d.code.CsharpTemporaire;

public abstract partial class Inventaire : Control
{
	//duo nomObjet et sceneObjet, exemple :
	//index = 0 -> nomObjet1, index = 1 -> sceneObjet1, index = 2 -> nomObjet2 ...
	[Export] private Array<Variant> _inventaireParDefaut;
	
	private ItemList _listeInventaire;
	private Node _proprietaireInventaire;
	private string _cheminFichierSauvegarde;
	public override void _Ready()
	{
		ProcessMode = ProcessModeEnum.WhenPaused;
		
		_listeInventaire = GetNode<ItemList>("ItemList");
		
		_proprietaireInventaire = GetParent();
		
		string nomFichierSauvegarde = _proprietaireInventaire.Name;
		_cheminFichierSauvegarde = "user://" + nomFichierSauvegarde + ".txt";
	}

	public override void _Notification(int notification)
	{
		if (FermetureJeuEstDemandee(notification))
		{
			List<DonneesObjetInventaire> donneesASauvegarder = ObtenirDonneesContenuInventaire();
			SauvegardeInventaire.SauvegarderDonneesContenuInventaire(donneesASauvegarder, _cheminFichierSauvegarde);
		}
	}

	private static bool FermetureJeuEstDemandee(int notification)
	{
		return notification == NotificationWMCloseRequest;
	}
	
	private List<DonneesObjetInventaire> ObtenirDonneesContenuInventaire()
	{
		List<DonneesObjetInventaire> donnees = new List<DonneesObjetInventaire>();
		
		for (int i = 0; i < _listeInventaire.ItemCount; i++)
		{
			string nomObjet = _listeInventaire.GetItemText(i);
			Variant metaDataObjet = _listeInventaire.GetItemMetadata(i);
			
			donnees.Add(new DonneesObjetInventaire(nomObjet, metaDataObjet));
		}

		return donnees;
	}

	public void AfficherInterface(SceneTree sceneEnCours)
	{
		Show();
		Input.MouseMode = Input.MouseModeEnum.Confined;
		sceneEnCours.Paused = true;
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

	protected void ChargerContenuInventaire()
	{
		ChargementInventaire.ChargerDonneesContenuInventaire(this);
	}
	
	public Inventaire InventaireDestination
	{
		get => this._inventaireDestination;
		set => this._inventaireDestination = value;
	}
	public ItemList ListeInventaire => _listeInventaire;
	public string CheminFichierInventaire => _cheminFichierSauvegarde;
	public Array<Variant> InventaireParDefaut => _inventaireParDefaut;

	/// <summary>
	/// Permet d'effectuer la procedure de selection d'un objet dans un inventaire.
	/// Doit etre connectee au signal ItemClicked d'un ItemList.
	/// </summary>
	public abstract void EffectuerProcedureSelectionObjet(long index, Vector2 atPosition, long mouseButtonIndex);
	
	/// <summary>
	/// Doit etre appelee par tous les inventaires dans _Ready pour charger leur contenu sauvegarde ou par defaut.
	/// N'entre pas en conflit avec des inventaires crees proceduralement.
	/// </summary>
	public abstract void ChargerContenuInventaireSurReady();
}
