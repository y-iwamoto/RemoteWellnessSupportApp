//
//  FormBaseViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import Foundation

class FormBaseViewModel: ObservableObject {
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}
