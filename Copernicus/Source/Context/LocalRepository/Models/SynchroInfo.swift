//
//  SynchroInfo.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 25/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class SynchroInfo: Object {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: String = ""
    @objc dynamic var date: Date?
    
    //
    // MARK: - Init
    //
    
    public init(_ id: String, date: Date) {
        self.id = id
        self.date = date
    }
    
    public required init() {
        super.init()
    }
    
    //
    // MARK: - Methods
    //
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
