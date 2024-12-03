//
//  FavoritesDataService.swift
//  FootballTokens
//
//  Created by Michael on 12/3/24.
//

import Foundation
import CoreData

class FavoritesDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "FavoritesContainer"
    private let entityName: String = "FavoritesEntity"
    
    @Published var savedEntities: [FavoritesEntity] = []
    
    init() {
        container  = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getFavorites()
        }
    }
    
    // MARK: PUBLIC SECTIONS
    
    func updateFavorites(coin: CoinModel) {
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
            delete(entity: entity)
        } else {
            add(coin: coin)
        }
        applyChanges()
    }
    
    func isFavorite(coinID: String) -> Bool {
        return savedEntities.contains(where: { $0.coinID == coinID })
    }
    
    
    // MARK: PRIVATE SECTIONS
    
     func getFavorites() {
        let request = NSFetchRequest<FavoritesEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Favorite Entities. \(error)")
        }
    }
    
    private func add(coin: CoinModel) {
        let entity = FavoritesEntity(context: container.viewContext)
        entity.coinID = coin.id
        applyChanges()
    }
    
    private func update(entity: FavoritesEntity) {
        applyChanges()
    }
    
    private func delete(entity: FavoritesEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        DispatchQueue.main.async {
            self.save()
            self.getFavorites()
        }
    }
}