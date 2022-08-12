//
//  EventListElement.swift
//  ParkRunnings WatchKit Extension
//
//  Created by Charlie on 5/5/2022.
//

import SwiftUI
import UIKit
import WatchKit

struct EventListElement: View {
    
    @EnvironmentObject var meta: MetaController
    @EnvironmentObject var event: EventController
    @EnvironmentObject var location: LocationController
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.openURL) private var openURL
    
    @FetchRequest var events: FetchedResults<Event>

    init(search: String) {
        
        _events = FetchRequest<Event>(
            sortDescriptors: [NSSortDescriptor(key: "distance", ascending: true), NSSortDescriptor(key: "name", ascending: true)],
            predicate: search.isEmpty ? nil : NSPredicate(format: "name CONTAINS %@", search),
            animation: .default
        )
        
    }
    
    var body: some View {
        
        List(content: {
            
            TitleElement(title: "Events", subtitle: location.enabled ? nil : "Enable location services on your iPhone for nearby event sorting")
            
            ForEach(events, content: { each in
                EventLocationElement(name: each.name, country: each.country, meters: Int(each.distance))
                    .simultaneousGesture(TapGesture().onEnded({
                        meta.update_home(event: each)
                        presentation.wrappedValue.dismiss()
                    }))
            })
            
        })
        .listStyle(.carousel)
        
    }
    
}

struct EventListElement_Previews: PreviewProvider {
    static var previews: some View {
        EventListElement(search: "Shit")
    }
}
