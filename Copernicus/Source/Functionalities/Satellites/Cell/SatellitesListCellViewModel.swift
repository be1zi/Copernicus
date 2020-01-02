//
//  SatellitesListCellViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct SatellitesListCellViewModel {
    
    
    //
    // MARK: - Init
    //
    
    public var name: String?
    
    public init(satellite: SatelliteModel) {
        self.name = satellite.properties?.name
    }
}
