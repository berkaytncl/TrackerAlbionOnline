//
//  KDEquipments.swift
//  AlbionInfo
//
//  Created by Berkay Tuncel on 13.07.2024.
//

import SwiftUI

struct KDEquipments: View {
    let kdReport: KDReportResponse
    var itemPressed: Action<String> = nil
    
    var body: some View {
        HStack {
            equipmentsSection(equipment: kdReport.killer?.equipment)
                
            Rectangle()
                .frame(width: 1, height: 200)
                
            equipmentsSection(equipment: kdReport.victim.equipment)
        }
    }
    
    private func equipmentsSection(equipment: Equipment?) -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.bag, image: .bagRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.mainHand, image: .weaponLRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.food, image: .foodRounded, imagePressed: { itemPressed?($0) })
            }
            
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.head, image: .helmetRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.armor, image: .armorRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.shoes, image: .shoesRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.mount, image: .mountRounded, imagePressed: { itemPressed?($0) })
            }
            
            VStack(spacing: 0) {
                EquipmentCell(equipmentData: equipment?.cape, image: .capeRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.offHand, image: .weaponRRounded, imagePressed: { itemPressed?($0) })
                EquipmentCell(equipmentData: equipment?.potion, image: .potionRounded, imagePressed: { itemPressed?($0) })
            }
        }
    }
}

#Preview {
    KDEquipments(kdReport: .mock)
}
