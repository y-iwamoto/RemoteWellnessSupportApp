//
//  BaseViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    func setError(withMessage message: String, error: Error? = nil) {
        isErrorAlert = true
        errorMessage = message
        #if DEBUG
            print("error", error?.localizedDescription ?? "Some error has occurred")
        #endif
    }
}
