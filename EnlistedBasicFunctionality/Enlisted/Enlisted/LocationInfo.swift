//
//  LocationInfo.swift
//  Enlisted
//
//  Created by Monika on 2017-08-30.
//  Copyright © 2017 Monika. All rights reserved.
//

import Foundation

public class LocationInfo {
    
    public var nameeLocations: [String] = []
    public var nameeDescriptions: [String] = []
    public var nameeImage: [String] = []
    
    private func seedInfo() {
        nameeLocations = ["Bondi Beach", "Navagio", "Anse Source d'Argent"]
        nameeDescriptions = ["Bondi Beach is a popular beach and the name of the surrounding suburb in Sydney, New South Wales, Australia. Bondi Beach is located 7 km (4 mi) east of the ...","Navagio Beach or Shipwreck Beach, is an exposed cove, sometimes referred to as Smugglers Cove, on the coast of Zakynthos, in the Ionian Islands of Greece.","La Digue is the third largest inhabited island of the Seychelles in terms of population, lying east ... Today, the island's main industry is tourism, and it is known for its beaches, especially Anse Source d'Argent and Grand Anse. La Digue went ..."]
        //represents generic image assets.
        nameeImage = ["Beach", "Beach1", "Beach2"]
    }
    
    private func apiInfo() {
        seedInfo()
    }
    
    public func SeedLocationInfo(selectInitType: Bool){
        if selectInitType {
            seedInfo()
        }
        else{
            apiInfo()
        }
        
    }
    
}
