//
//  Equipment.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 7.07.2024.
//

import Foundation

struct Equipment: Codable {
    let mainHand: EquipmentData?
    let offHand: EquipmentData?
    let head: EquipmentData?
    let armor: EquipmentData?
    let shoes: EquipmentData?
    let bag: EquipmentData?
    let cape: EquipmentData?
    let mount: EquipmentData?
    let potion: EquipmentData?
    let food: EquipmentData?
    
    enum CodingKeys: String, CodingKey {
        case mainHand = "MainHand"
        case offHand = "OffHand"
        case head = "Head"
        case armor = "Armor"
        case shoes = "Shoes"
        case bag = "Bag"
        case cape = "Cape"
        case mount = "Mount"
        case potion = "Potion"
        case food = "Food"
    }
}

struct EquipmentData: Codable {
    let count: Int
    let quality: Int
    let itemId: String
    
    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case quality = "Quality"
        case itemId = "Type"
    }
}
