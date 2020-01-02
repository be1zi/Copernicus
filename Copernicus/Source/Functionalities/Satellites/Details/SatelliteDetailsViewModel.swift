//
//  SatelliteDetailsViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct SatelliteDetailsViewModel {
    
    //
    // MARK: - Properties
    //
    
    private let satellite: SatelliteModel
    public var title: String? {
        get {
            return satellite.properties?.name
        }
    }
    
    //
    // MARK: - Init
    //
    
    init(satellite: SatelliteModel) {
        self.satellite = satellite
    }
}
