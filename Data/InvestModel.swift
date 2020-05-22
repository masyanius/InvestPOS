 //
//  InvestModel.swift
//  Invest
//
//  Created by Max Mikhalskiy on 06.12.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//
 import Foundation

 
 // MARK: - InvestModel
 struct InvestModel: Codable {
     let lineCharts: LineCharts
     let barCharts: BarCharts
     let pieCharts: PieCharts
     let registry: Registry
 }

 // MARK: - BarCharts
 struct BarCharts: Codable {
     let regionVED: [RegionVED]
 }

 // MARK: - RegionVED
 struct RegionVED: Codable {
     let year: String
     let value: [Double]
 }

 // MARK: - LineCharts
 struct LineCharts: Codable {
     let main, region: [[Double]]
     let structureByCountry: [StructureByCountry]
 }

 // MARK: - StructureByCountry
 struct StructureByCountry: Codable {
     let years: [String]
     let regionValue: [Double]
     let value: [[Double]]
 }

 // MARK: - PieCharts
 struct PieCharts: Codable {
     let districtVED: [DistrictVED]
 }

 // MARK: - DistrictVED
 struct DistrictVED: Codable {
     let year: String
     let value: [[Double]]
     let regionValue: [Double]
 }
 
 // MARK: - Registry
 struct Registry: Codable {
     let investor, project, signingDate, sector: [String]
     let investmentSize, numberOfWorkplaces: [Int]
     let projectImplementationPhase: [String]
 }
 
