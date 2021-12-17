//
//  ViewModel.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 19.11.2021.
//

import Foundation
import SwiftUI
class FeedViewModel: ObservableObject {
    @Published var tasks = [Task]()
    @Published var comments = [Comment]()
    
    init() {
        let fetchingData = ServiceLocator().fetchData()
        fetchingData.fetchPostsData { task in
            self.tasks.append(task)
        }
        print("init ViewModel")
    }
}






