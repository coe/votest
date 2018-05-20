//
//  ShopCollectionCollectionViewController.swift
//  vo
//
//  Created by COFFEE on 2018/05/19.
//  Copyright © 2018年 tsuyoshi hyuga. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

private let reuseIdentifier = "reuseIdentifier"

struct RakutenResult: Codable {
    let count: Int
    let page: Int
    let first: Int
    let last: Int
    let hits: Int
    let carrier: Int
    let pageCount: Int
    let Items: [Item]

    struct Item: Codable {
        let Item:ItemValue
    }
    struct ItemValue: Codable {

        let itemName: String
        let itemCode: String
        let itemPrice: Int
        let itemCaption: String
        let itemUrl: String
        let shopUrl: String
        let smallImageUrls: [SmallImageUrls]
        let mediumImageUrls: [MediumImageUrls]
        let affiliateUrl: String
        let shopAffiliateUrl: String
        let imageFlag: Int
        let availability: Int
        let taxFlag: Int
        let postageFlag: Int
        let creditCardFlag: Int
        let shopOfTheYearFlag: Int
        let shipOverseasFlag: Int
        let shipOverseasArea: String
        let asurakuFlag: Int
        let asurakuClosingTime: String
        let asurakuArea: String
        let affiliateRate: Float
        let startTime: String
        let endTime: String
        let reviewCount: Int
        let reviewAverage: Float
        let pointRate: Int
        let pointRateStartTime: String
        let pointRateEndTime: String
        let giftFlag: Int
        let shopName: String
        let shopCode: String
        let genreId: String
        let tagIds: [Int]

        
        struct SmallImageUrls: Codable {
            let imageUrl: String
        }
        
        struct MediumImageUrls: Codable {
            let imageUrl: String
        }
    }
}

class ShopCollectionCollectionViewController: UICollectionViewController,NSFetchedResultsControllerDelegate {

    //TODO:ここは外からもらうようにする
//    var managedObjectContext:NSManagedObjectContext!
//    var appDelegate:AppDelegate!

    lazy var fetchedResultsController: NSFetchedResultsController<ShopItem> = {
        var fetchedResultsController:NSFetchedResultsController<ShopItem>!
        let request = NSFetchRequest<ShopItem>(entityName: "ShopItem")
        let lastNameSort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [lastNameSort]
        var appDelegate:AppDelegate! = UIApplication.shared.delegate as! AppDelegate
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        return fetchedResultsController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        let urlstring = "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?applicationId=1088734228559323144&keyword=%E7%A6%8F%E8%A2%8B&sort=%2BitemPrice"
        let url = URL(string: urlstring)
        let appDelegate:AppDelegate! = UIApplication.shared.delegate as! AppDelegate
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let items = try JSONDecoder().decode(RakutenResult.self, from: data!)
                print(items)

                let entityDescription:NSEntityDescription = NSEntityDescription.entity(forEntityName: "ShopItem", in: appDelegate.persistentContainer.viewContext)!


                items.Items.forEach({ (rItem) in
                    let data = ShopItem(entity: entityDescription, insertInto: appDelegate.persistentContainer.viewContext)
                    data.title = rItem.Item.itemName
                    data.imageUrl = rItem.Item.mediumImageUrls.first!.imageUrl
                    
                })
                appDelegate.saveContext()

            } catch {
                fatalError("\(error)")
            }
        }
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let data = fetchedResultsController.object(at: indexPath)

        // Configure the cell
        let url = URL(string: data.imageUrl!)
        cell.imageView.sd_setImage(with: url, completed: nil)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        collectionView?.reloadData()
    }

}
