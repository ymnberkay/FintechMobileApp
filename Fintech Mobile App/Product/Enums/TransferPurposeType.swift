//
//  TransferPurposeType.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.08.2025.
//

enum TransferPurposeType: String, CaseIterable {
    case personal = "personal"
    case business = "business"
    case payment = "payment"
    
    var purpose: TransferPurpose {
        switch self {
        case .personal:
            return TransferPurpose(
                id: "personal",
                title: "Personal",
                subtitle: "Pay your friends and family",
                iconName: "person.fill",
                iconBackgroundColor: .blue
            )
        case .business:
            return TransferPurpose(
                id: "business",
                title: "Business",
                subtitle: "Pay your employee",
                iconName: "briefcase.fill",
                iconBackgroundColor: .orange
            )
        case .payment:
            return TransferPurpose(
                id: "payment",
                title: "Payment",
                subtitle: "For payment utility bills",
                iconName: "creditcard.fill",
                iconBackgroundColor: .pink
            )
        }
    }
}

enum ReceiveTransferPurposeType: String, CaseIterable {
    case personal = "personal"
    case business = "business"
    
    var purpose: TransferPurpose {
        switch self {
        case .personal:
            return TransferPurpose(
                id: "personal",
                title: "Personal",
                subtitle: "Pay your friends and family",
                iconName: "person.fill",
                iconBackgroundColor: .blue
            )
        case .business:
            return TransferPurpose(
                id: "business",
                title: "Business",
                subtitle: "Pay your employee",
                iconName: "briefcase.fill",
                iconBackgroundColor: .orange
            )
        }
    }
}
