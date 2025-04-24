//
//  CreateAccountViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 15.04.2025.
//

import SwiftUI

final class CAViewModel: ObservableObject {
    @Published var phoneNumberText: String = ""
    @Published var countryCode: String = ""
    @Published var password: String = ""
    @Published var showCorrectAllert: Bool = false
    @Published var showBirthDateAllert: Bool = false
    @Published var selectedCountry: Country? = Country(name: "Turkey", code: "+90", imageName: "Country=TR")
    @Published var enterValue: [String] = Array(repeating: "", count: 6)
    @Published var countryValue: Country? = Country(name: "Turkey", code: "+90", imageName: "Country=TR")
    @Published var userInfoID: String = ""
    @Published var message: String = ""
    @Published var success: Bool = false
    @Published var caName: String = ""
    @Published var caUsername: String = ""
    @Published var caDateofBirth: Date = Date()
    @Published var caAddress: String = ""
    @Published var caCity: String = ""
    @Published var caPostCode: String = ""
    @Published var caEmail: String = ""
    @Published var passcode: String = ""
    
    
    func otpCompare(enterValue: [String]) -> Bool {
        if enterValue == ["1","1","1","1","1","1"] {
            return true
        } else {
            return false
        }
    }
    
    func postResidenceData(requestString: String) async {
        let model = CAResidenceRequest(residence: requestString)
        if let response = await NetworkManager.networkManager.post(
            path: .PIResidence,
            model: model,
            type: CAResidenceResponse.self
        ) {
            await MainActor.run {
                self.userInfoID = response.id
                self.message = response.message
                self.success = response.success
                print(response)
            }
            
        } else {
            await MainActor.run {
                self.message = "A error appeared."
                self.success = false
            }
            
        }
    }
    
    func postNameData(id: String, fullName: String, userName: String, dateofBirth: String) async {
        let model = CANameRequest(id: id, fullName: fullName, userName: userName, dateOfBirth: dateofBirth)
        if let response = await NetworkManager.networkManager.post(
            path: .PIName,
            model: model,
            type: CAStepResponse.self) {
            self.message = response.message
            self.success = response.success
        } else {
            self.message = "A error appeared."
            self.success = false
        }
    }
    
    func postAddressData(id: String, addressLine: String, city: String, postCode: String) async {
        let model = CAAddressRequest(id: id, addressLine: addressLine, city: city, postCode: postCode)
        if let response = await NetworkManager.networkManager.post(
            path: .PIAdress,
            model: model,
            type: CAStepResponse.self)  {
            self.message = response.message
            self.success = response.success
        } else {
            self.message = "A error appeared."
            self.success = false
        }
    }
    
    func postEmailData(id: String, email: String) async {
        let model = CAEmailRequest(id: id, email: email)
        if let response = await NetworkManager.networkManager.post(
            path: .PIEmail,
            model: model,
            type: CAStepResponse.self) {
            self.message = response.message
            self.success = response.success
        } else {
            self.message = "A error appeared."
            self.success = false
        }
    }
    
    func postPasscodeData(id: String, passcode: String, isCompleted: Bool) async {
        let model = CAPasscodeRequest(id: id, passcode: passcode, isCompleted: isCompleted)
        if let response = await NetworkManager.networkManager.post(
            path: .PIPasscode,
            model: model,
            type: CAStepResponse.self) {
            self.message = response.message
            self.success = response.success
        } else {
            self.message = "A error appeared."
            self.success = false
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
