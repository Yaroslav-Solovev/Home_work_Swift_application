import Foundation

final class ThemeSaver{
    static func putData(){
        let theme = Theme.currentTheme.type 
        UserDefaults.standard.set(theme.rawValue, forKey: "theme")
    }

    static func getData(){
        let theme = UserDefaults.standart.string(forKey: "theme")
        let themeType = AllAppTheme(rawValue: theme ?? "white")
        switch themeType{
            case .white: Theme.currentTheme = Whitetheme()
            case .blue: Theme.currentTheme = Bluetheme()
            case .green: Theme.currentTheme = Greentheme()
            default: Theme.currenttheme = WhiteTheme()
        }
    }
}