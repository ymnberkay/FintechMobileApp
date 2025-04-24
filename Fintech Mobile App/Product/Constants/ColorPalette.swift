//
//  ColorPalette.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//

import SwiftUI
import UIKit

class ColorPalette {
    // Bose Colors
    static let primary = Color(hex: "#304FFE")    // blue500
    static let accent = Color(hex: "#304FFE")     // blue500 (Primary / Accent color)
    static let secondary = Color(hex: "#FDD835")  // yellow600
    static let error = Color(hex: "#F44336")      // red500
    static let success = Color(hex: "#66BB6B")    // green600
    static let warning = Color(hex: "#FB8A00")    // orange600
    static let info = Color(hex: "#4CAF51")       // green500
    
    
    // Background Colors
    static let bgLight = Color(hex: "#FFFFFF")     // White
    static let bgInverse = Color(hex: "#121212")   // Black
    static let bgAccent = Color(hex: "#304FFE")    // blue500
    static let bgSecondary = Color(hex: "#FDD835") // yellow600
    static let bgError = Color(hex: "#F44336")     // red500
    static let bgSuccess = Color(hex: "#66BB6B")   // green600
    static let bgWarning = Color(hex: "#FB8A00")   // orange600
    static let bgAccentLight = Color(hex: "#A4ABFF")  // blue200
    static let bgSecondaryLight = Color(hex: "#FFF9C4") // yellow100
    static let bgErrorLight = Color(hex: "#FFEBEE") // red50
    static let bgSuccessLight = Color(hex: "#E8F5E9") // green50
    static let bgWarningLight = Color(hex: "#FFF3E0") // orange50
    
    // Text and Icon Colors
    static let contentPrimary = Color(hex: "#121212")     // black (Primary text and icon color)
    static let contentSecondary = Color(hex: "#717171")    // gray600 (Secondary text and icon color)
    static let contentTertiary = Color(hex: "#B8B8B8")     // gray400 (Tertiary text and icon color)
    static let contentDisabled = Color(hex: "#B0B0B0")     // gray500 (Disabled text and icon color)
    static let contentAccent = Color(hex: "#304FFE")       // blue500 (Accent color for text and icons)
    static let contentSecondaryColor = Color(hex: "#2A2A2A") // gray900 (Secondary dark text and icon color)
    
    // Error, Success, and Warning Colors for Text and Icon
    static let contentError = Color(hex: "#D32F2F")        // red700 (Error color for text and icons)
    static let contentSuccess = Color(hex: "#388E3D")      // green700 (Success color for text and icons)
    static let contentWarning = Color(hex: "#F57A01")      // orange700 (Warning color for text and icons)
    
    // On Color (Text on colored background)
    static let contentOnColor = Color(hex: "#FFFFFF")      // white (Text and icons on colored backgrounds)
    static let contentOnInverse = Color(hex: "#121212")    // black (Text and icons on inverse backgrounds)
    
    
    // Border & Divider Colors
    static let border = Color(hex: "#CBCBCB")              // gray200 (Default border color)
    static let borderAccent = Color(hex: "#304FFE")        // blue400 (Accent border color)
    static let borderError = Color(hex: "#D32F2F")         // red500 (Error border color)
    static let borderSuccess = Color(hex: "#388E3D")       // green400 (Success border color)
    static let borderWarning = Color(hex: "#F57A01")       // orange400 (Warning border color)
    
    // Divider Colors
    static let divider = Color(hex: "#D0D0D0")             // gray100 (Default divider color)
    static let dividerAccent = Color(hex: "#304FFE")       // blue100 (Accent divider color)
    static let dividerError = Color(hex: "#FFCDD2")        // red100 (Error divider color)
    static let dividerSuccess = Color(hex: "#A5D6A7")      // green100 (Success divider color)
    static let dividerWarning = Color(hex: "#FFEBEE")      // orange50 (Warning divider color)
    
    
   
    
 
    /// Full Colors
    
    // Blue Colors
    static let blue50 = Color(hex: "#EAEBFF")
    static let blue100 = Color(hex: "#C9CCFF")
    static let blue200 = Color(hex: "#A4ABFF")
    static let blue300 = Color(hex: "#7A89FF")
    static let blue400 = Color(hex: "#576CFF")
    static let blue500 = Color(hex: "#304FFE")
    static let blue600 = Color(hex: "#2B46F2")
    static let blue700 = Color(hex: "#1E3AE5")
    static let blue800 = Color(hex: "#0D2CDA")
    static let blue900 = Color(hex: "#0009CA")
    
    // Yellow Colors
    static let yellow50 = Color(hex: "#FFFDE7")
    static let yellow100 = Color(hex: "#FFF9C4")
    static let yellow200 = Color(hex: "#FFF59D")
    static let yellow300 = Color(hex: "#FEF075")
    static let yellow400 = Color(hex: "#FCEB55")
    static let yellow500 = Color(hex: "#FAE635")
    static let yellow600 = Color(hex: "#FDD835")
    static let yellow700 = Color(hex: "#FBC02D")
    static let yellow800 = Color(hex: "#F9A825")
    static let yellow900 = Color(hex: "#F57F17")
    
    // Red Colors
    static let red50 = Color(hex: "#FFEBEE")
    static let red100 = Color(hex: "#FFCDD2")
    static let red200 = Color(hex: "#EF9A9A")
    static let red300 = Color(hex: "#E57373")
    static let red400 = Color(hex: "#EF5350")
    static let red500 = Color(hex: "#F44336")
    static let red600 = Color(hex: "#E53935")
    static let red700 = Color(hex: "#D32F2F")
    static let red800 = Color(hex: "#C62828")
    static let red900 = Color(hex: "#B71B1C")
    
    // Green Colors
    static let green50 = Color(hex: "#E8F5E9")
    static let green100 = Color(hex: "#C8E6C9")
    static let green200 = Color(hex: "#A5D6A7")
    static let green300 = Color(hex: "#81C784")
    static let green400 = Color(hex: "#66BB6B")
    static let green500 = Color(hex: "#4CAF51")
    static let green600 = Color(hex: "#43A048")
    static let green700 = Color(hex: "#388E3D")
    static let green800 = Color(hex: "#2E7D33")
    static let green900 = Color(hex: "#1B5E21")
    
    // Orange Colors
    static let orange50 = Color(hex: "#FFF3E0")
    static let orange100 = Color(hex: "#FFDFB2")
    static let orange200 = Color(hex: "#FFCB7F")
    static let orange300 = Color(hex: "#FFB64C")
    static let orange400 = Color(hex: "#FFA525")
    static let orange500 = Color(hex: "#FF9600")
    static let orange600 = Color(hex: "#FB8A00")
    static let orange700 = Color(hex: "#F57A01")
    static let orange800 = Color(hex: "#EF6A01")
    static let orange900 = Color(hex: "#983301")
    
    // Gray Colors
    static let gray50 = Color(hex: "#F7F7F7")
    static let gray100 = Color(hex: "#E8E8E8")
    static let gray200 = Color(hex: "#D0D0D0")
    static let gray300 = Color(hex: "#B8B8B8")
    static let gray400 = Color(hex: "#A0A0A0")
    static let gray500 = Color(hex: "#898989")
    static let gray600 = Color(hex: "#717171")
    static let gray700 = Color(hex: "#5A5A5A")
    static let gray800 = Color(hex: "#414141")
    static let gray900 = Color(hex: "#2A2A2A")
    
    // Info Colors
    static let info50 = Color(hex: "#F7F7F7")
    static let info100 = Color(hex: "#E8E8E8")
    static let info200 = Color(hex: "#D0D0D0")
    static let info300 = Color(hex: "#B8B8B8")
    static let info400 = Color(hex: "#A0A0A0")
    static let info500 = Color(hex: "#898989")
    static let info600 = Color(hex: "#717171")
    static let info700 = Color(hex: "#5A5A5A")
    static let info800 = Color(hex: "#414141")
    static let info900 = Color(hex: "#2A2A2A")
    
    // Black and White Colors
    static let white = Color.white
    static let black = Color.black
    
    // Utility to create Color from Hex
    static func colorFromHex(hex: String) -> Color {
        return Color(hex: hex)
    }
}
