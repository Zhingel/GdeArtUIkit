//
//  UpperTabBar.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 08.12.2021.
//

import SwiftUI

struct UpperTabBar: View {
    var userUid: String
    var tasks: [Task]
    // Currenttab...
    @State var currentSelection: Int = 0
    
    var body: some View {
        
        PagerTabView(tint: .black,selection: $currentSelection){
            
            Image(systemName: "house.fill")
                .pageLabel()
            
            Image(systemName: "magnifyingglass")
                .pageLabel()
            
            Image(systemName: "person.fill")
                .pageLabel()
            
            Image(systemName: "gearshape")
                .pageLabel()
            
        } content: {
            
            MyCalls(userUid: userUid, tasks: tasks)
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            Color.green
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            Color.yellow
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            Color.purple
                .pageView(ignoresSafeArea: true, edges: .bottom)
        }
        .padding(.top)
        .ignoresSafeArea(.container, edges: .bottom)

    }
}
