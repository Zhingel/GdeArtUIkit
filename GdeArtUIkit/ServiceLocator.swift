//
//  ServiceLocator.swift
//  GdeArtUIkit
//
//  Created by Стас Жингель on 05.12.2021.
//

import Foundation

class ServiceLocator {
    lazy var autorization: AutorizationFireBase = .init()
    func getAuthService() -> Autorization {
        autorization
    }
}
