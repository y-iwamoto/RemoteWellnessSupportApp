//
//  PhysicalConditionDataSourceProtocol.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/09.
//

protocol PhysicalConditionDataSourceProtocol {
    func insertPhysicalCondition(physicalCondition: PhysicalCondition) throws
    func updatePhysicalCondition(physicalCondition: PhysicalCondition) throws
}
