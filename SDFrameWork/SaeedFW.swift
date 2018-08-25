
import UIKit
import SystemConfiguration

import Format
import RealmSwift

import Reflection


public class SDNetwork {
    
    class func checkNetwork() -> Bool{
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI //
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    
    class func showNoResponse(vw: UIViewController){
        let responseView = UINib(nibName: "NoResponse", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NoResponse
        responseView.fromAppDelegate = false
        responseView.frame = UIScreen.main.bounds
        let response = SDViewController()
        response.view.addSubview(responseView)
        vw.present(response, animated: false, completion: nil)
    }
}


public class SDRealm {
    
    class func write(obj: Object) -> Void{
        let realm = try! Realm()
        try! realm.write {
            realm.add(obj)
        }
    }
    
    class func get(obj: Object.Type, queryString: String) -> [Object]{
        let realm = try! Realm()
        let returnObjs = realm.objects(obj).filter(queryString)
        return returnObjs.map{$0}
    }
    
    class func delete(obj: Object) -> Void{
        let realm = try! Realm()
        try! realm.write {
            realm.delete(obj)
        }
    }
    
}

public class SDCall {
    class func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
}

public class SDLayout {
    class func createBgTransparent(uiImage: UIImageView, named: String) -> UIImageView{
        uiImage.frame = UIScreen.main.bounds
        uiImage.image = UIImage(named: named)
        uiImage.contentMode = .scaleAspectFill
        return uiImage
    }
    
    class func createImageWithOriginAndSize(uiImage: UIImageView, image_name: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIImageView{
        uiImage.image = UIImage(named: image_name)
        uiImage.contentMode = .scaleToFill
        uiImage.frame = CGRect(x: x, y: y, width: w, height: h)
        return uiImage
    }
    
    class func createImageViewWithOriginAndSizeAndBorder(uiImage: UIImageView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIImageView{
        uiImage.frame = CGRect(x: x, y: y, width: w, height: h)
        uiImage.layer.borderColor = UIColor(hex: "d2ab67", alpha: 1).cgColor
        uiImage.layer.borderWidth = 0.3
        uiImage.layer.cornerRadius = 20
        uiImage.clipsToBounds = true
        uiImage.layer.masksToBounds = true
        return uiImage
    }
    
    class func createBtn(uiBtn: UIButton, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, backColor: UIColor) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = backColor
        uiBtn.layer.cornerRadius = 5
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        
        return uiBtn
    }
    
    
    class func createBtn(uiBtn: UIButton, btnTitle: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, hex: UIColor) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setTitle(btnTitle, for: .normal)
        uiBtn.titleLabel?.textAlignment = .center
        uiBtn.titleLabel?.font = SDFont.returnFont(size: 11)
        uiBtn.setTitleColor(hex, for: .normal)
        return uiBtn
    }
    
    class func createBtnWithImage(uiBtn: UIButton, image: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setBackgroundImage(UIImage(named: image), for: .normal)
        return uiBtn
    }
    
    class func createBtnWithImageAndBorder(uiBtn: UIButton, image: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setImage(UIImage(named: image), for: .normal)
        uiBtn.layer.borderColor = UIColor(hex: "d2ab67", alpha: 1).cgColor
        uiBtn.layer.borderWidth = 0.3
        uiBtn.layer.cornerRadius = 23
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        return uiBtn
    }
    
    class func createBtnWithImageWithCustomBorder(uiBtn: UIButton, image: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, cornerRadiusSize: CGFloat, borderWidthSize: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setImage(UIImage(named: image), for: .normal)
        uiBtn.layer.borderColor = Color.get(.btnBorderColor).cgColor
        uiBtn.layer.borderWidth = borderWidthSize
        uiBtn.layer.cornerRadius = cornerRadiusSize
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        return uiBtn
    }
    
    class func createBtnWithCustomBorder(uiBtn: UIButton, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, cornerRadiusSize: CGFloat, borderWidthSize: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        //        uiBtn.setImage(UIImage(named: image), for: .normal)
        uiBtn.layer.borderColor = Color.get(.btnBorderColor).cgColor
        uiBtn.layer.borderWidth = borderWidthSize
        uiBtn.layer.cornerRadius = cornerRadiusSize
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        return uiBtn
    }
    
    class func createLabel(uiLabel: UILabel, hex: UIColor, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, txt: String) -> UILabel{
        uiLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        uiLabel.font = SDFont.returnFont(size: 12)
        uiLabel.clipsToBounds = true
        uiLabel.layer.masksToBounds = true
        uiLabel.textAlignment = .center
        uiLabel.text = txt
        uiLabel.textColor = hex
        return uiLabel
    }
    
    class func createLabelWithSize(uiLabel: UILabel, hex: UIColor, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, txt: String, size: CGFloat) -> UILabel{
        uiLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        uiLabel.font = SDFont.returnFont(size: size)
        uiLabel.clipsToBounds = true
        uiLabel.layer.masksToBounds = true
        uiLabel.textAlignment = .center
        uiLabel.text = txt
        uiLabel.textColor = hex
        return uiLabel
    }
    
    class func createTextField(uiTextField: UITextField, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, borderHex: UIColor, bgColor: UIColor, placeHolder: String) -> UITextField{
        uiTextField.frame = CGRect(x: x, y: y, width: w, height: h)
        uiTextField.layer.cornerRadius = 20
        uiTextField.layer.masksToBounds = true
        uiTextField.layer.borderColor = borderHex.cgColor
        uiTextField.layer.borderWidth = 0.3
        uiTextField.clipsToBounds = false
        uiTextField.backgroundColor = bgColor
        uiTextField.font = SDFont.returnFont(size: 14)
        uiTextField.placeholder = placeHolder
        uiTextField.textAlignment = .center
        uiTextField.keyboardType = .numberPad
        uiTextField.keyboardAppearance = .dark
        return uiTextField
    }
    
    class func createTextFieldWithKeyboardType(uiTextField: UITextField, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, borderHex: UIColor, bgColor: UIColor, placeHolder: String, keyboard: UIKeyboardType, cornerRadius: CGFloat) -> UITextField{
        uiTextField.frame = CGRect(x: x, y: y, width: w, height: h)
        uiTextField.layer.cornerRadius = cornerRadius
        uiTextField.layer.masksToBounds = true
        uiTextField.layer.borderColor = borderHex.cgColor
        uiTextField.layer.borderWidth = 0.3
        uiTextField.clipsToBounds = false
        uiTextField.backgroundColor = bgColor
        uiTextField.font = SDFont.returnFont(size: 14)
        uiTextField.placeholder = placeHolder
        uiTextField.textAlignment = .right
        uiTextField.keyboardType = keyboard
        uiTextField.keyboardAppearance = .dark
        return uiTextField
    }
    
    class func createTextViewWithKeyboardType(uiTextView: UITextView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, borderHex: String, bgColor: String, keyboard: UIKeyboardType, cornerRadius: CGFloat) -> UITextView{
        uiTextView.frame = CGRect(x: x, y: y, width: w, height: h)
        uiTextView.layer.cornerRadius = cornerRadius
        uiTextView.layer.masksToBounds = true
        uiTextView.layer.borderColor = UIColor(hex: borderHex, alpha: 1.0).cgColor
        uiTextView.layer.borderWidth = 0.3
        uiTextView.clipsToBounds = false
        uiTextView.backgroundColor = UIColor(hex: bgColor, alpha: 1.0)
        uiTextView.font = SDFont.returnFont(size: 14)
        uiTextView.textAlignment = .center
        uiTextView.keyboardType = keyboard
        uiTextView.keyboardAppearance = .dark
        return uiTextView
    }
    
    class func createTextViewForShow(uiTextView: UITextView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, cornerRadius: CGFloat, txt: String) -> UITextView{
        uiTextView.frame = CGRect(x: x, y: y, width: w, height: h)
        uiTextView.layer.cornerRadius = cornerRadius
        //        uiTextView.layer.masksToBounds = true
        uiTextView.layer.borderColor = Color.get(.borderShowTextView).cgColor
        uiTextView.textColor = Color.get(.showTextView)
        uiTextView.layer.borderWidth = 0.3
        //        uiTextView.clipsToBounds = false
        uiTextView.text = txt
        uiTextView.isEditable = false
        uiTextView.backgroundColor = UIColor.clear
        uiTextView.font = SDFont.returnFont(size: 14)
        uiTextView.textAlignment = .center
        return uiTextView
    }
    
    
    class func createSelectedUIView(view: UIView, x: CGFloat, y: CGFloat) -> UIView{
        view.frame = CGRect(x: x, y: y, width: 20.0, height: 20.0)
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.init(hex: "d2ab67")
        view.clipsToBounds = true
        return view
    }
    
    class func createUnSelectedUIView(view: UIView, x: CGFloat, y: CGFloat) -> UIView{
        view.frame = CGRect(x: x, y: y, width: 20.0, height: 20.0)
        view.layer.borderColor = UIColor(hex: "d2ab67", alpha: 1).cgColor
        view.layer.borderWidth = 0.3
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }
    
    class func createTabelView(vc: UIViewController, tableView: UITableView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UITableView{
        tableView.delegate = vc as! UITableViewDelegate
        tableView.dataSource = vc as! UITableViewDataSource
        tableView.frame = CGRect(x: x, y: y, width: w, height: h)
        return tableView
    }
    
    class func createTableViewCell(cell: UITableViewCell, newView: UIView, subViews: [UIView], constants: [CGFloat]) -> UITableViewCell{
        cell.contentView.addSubview(newView)
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.topAnchor.constraint(equalTo: newView.topAnchor, constant: constants[0]).isActive = true
        cell.contentView.leadingAnchor.constraint(equalTo: newView.leadingAnchor,constant: constants[1]).isActive = true
        cell.contentView.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: constants[2]).isActive = true
        cell.contentView.bottomAnchor.constraint(equalTo: newView.bottomAnchor,constant : constants[3]).isActive = true
        
        for item in subViews{
            newView.addSubview(item)
        }
        
        newView.frame.size.height = subViews[subViews.count - 1].frame.origin.y + subViews[subViews.count - 1].frame.size.height
        return cell
    }
    
    
    
}


class SDPersianEnglish {
    class func changeMobileNumberToEnglish(text: String) -> String{
        let NumberStr: String = text
        let Formatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let mobile = Formatter.number(from: NumberStr)
        if mobile != 0 {
            return "0\(mobile!)"
        }
        return text
    }
    
    class func changeMobileNumberToEnglishCode(text: String) -> String{
        let NumberStr: String = text
        let Formatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let mobile = Formatter.number(from: NumberStr)
        let mobileStr: String = "\(mobile!)"
        if mobileStr.count == 3{
            return "0\(mobile!)"
        }else if mobileStr.count == 2{
            return "00\(mobile!)"
        }else if mobileStr.count == 1{
            return "000\(mobile!)"
        }
        if mobile != 0 {
            return "\(mobile!)"
        }
        return text
    }
    
    class func changePersianNumToEnglish(text: String) -> String{
        let NumberStr: String = text
        let Formatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let mobile = Formatter.number(from: NumberStr)
        if mobile != 0 {
            return "\(mobile!)"
        }
        return text
    }
    
    
    
    
}


class SDUserDefault {
    class func setStringValue(value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    class func getStringValue(forKey: String) -> String? {
        return UserDefaults.standard.object(forKey: forKey) as? String
    }
    
    class func setIntValue(value: Int, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    class func getIntValue(forKey: String) -> Int? {
        return UserDefaults.standard.object(forKey: forKey) as? Int
    }
    
    class func setBoolValue(bool: Bool, forKey: String) {
        UserDefaults.standard.set(bool, forKey: forKey)
    }
    
    class func getBoolValue(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
}


class SDTime {
    class func returnDateFromMilisecond(_ myDate : String!) -> String{
        
        //        let milisecond = Int(myDate);
        //        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond!)/1000);
        //        let dateFormatter = DateFormatter();
        //        dateFormatter.dateFormat = "dd-mm-yyyy";
        //        let calendar = Calendar(identifier: .persian)
        //        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: dateVar)
        //        return "\(components.year!)/\(components.month!)/\(components.day!)"
        
        
        //        let unixTimestamp = 1480134638.0
        let date = Date(timeIntervalSince1970: TimeInterval(Int(myDate)!))
        
        
        //        let date = Date(timeIntervalSince1970: unixtimeInterval)
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "fa_IR") //Set timezone that you want
        //        dateFormatter.locale = NSLocale.init(localeIdentifier: "ir") as Locale!
        //        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
        
        let calendar = Calendar(identifier: .persian)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        //        let strDate = dateFormatter.string(from: date)
        return "\(components.year!)/\(components.month!)/\(components.day!)"
    }
    
    class func returnDateFromTimeInterval(_ myDate : TimeInterval!) -> String{
        
        //        let milisecond = Int(myDate);
        //        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond!)/1000);
        //        let dateFormatter = DateFormatter();
        //        dateFormatter.dateFormat = "dd-mm-yyyy";
        //        let calendar = Calendar(identifier: .persian)
        //        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: dateVar)
        //        return "\(components.year!)/\(components.month!)/\(components.day!)"
        
        
        //        let unixTimestamp = 1480134638.0
        let date = Date(timeIntervalSince1970: myDate)
        
        
        //        let date = Date(timeIntervalSince1970: unixtimeInterval)
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "fa_IR") //Set timezone that you want
        //        dateFormatter.locale = NSLocale.init(localeIdentifier: "ir") as Locale!
        //        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
        
        let calendar = Calendar(identifier: .persian)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        //        let strDate = dateFormatter.string(from: date)
        return "\(components.year!)/\(components.month!)/\(components.day!)"
    }
}


class SDAlert {
    class func createAlertViewMessageAndVCAndTitleDismiss(vc: UIViewController, title: String, message: String, dismissBtnTxt: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: dismissBtnTxt, style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func watingViewWithAlert(vc: UIViewController, title: String, message: String, dismissBtnTxt: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let indicator = UIActivityIndicatorView(frame: alert.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alert.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.startAnimating()
        
        return alert
    }
}

class SDString{
    class func changeNumWithSemicolon(num: String) -> String{
        let formatTest = Int(num)?.format(Decimals.three)
        let retStr: String = "\(formatTest!)".replacingOccurrences(of: ".000", with: "")
        return retStr
    }
    
    class func replacePresianSearchWithText(text: String!) -> String!{
        let str : String! = (text.replacingOccurrences(of: "ي", with: "ی")).replacingOccurrences(of: "گ", with: "گ")
        return str
    }
    
    class func replaceImageName(text: String) -> String{
        if SDUserDefault.getStringValue(forKey: "SDUserDefault_ColorApp") == "white"{
            return "\(text)-black"
        }else{
            return "\(text)-white"
        }
    }
    
    class func height(withConstrainedWidth width: CGFloat, font: UIFont, txt: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = txt.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    class func width(withConstrainedHeight height: CGFloat, font: UIFont, txt: String) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = txt.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

class SDFont{
    class func returnFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "IRANSans(FaNum)", size: size)
    }
    
    class func returnFontName(point: Int, size: CGFloat) -> UIFont? {
        
        var fonts: [String] = ["IRANSansMobileFaNum-Medium", //0
            "IRANSansMobileFaNum-Bold", //1
            "IRANSansMobileFaNum-Black", //2
            "IRANSansMobileFaNum", //3
            "IRANSansMobileFaNum-UltraLight", //4
            "IRANSansMobileFaNum-Light"]  //5
        return UIFont(name: fonts[point], size: size)
    }
}



extension UIColor{
    convenience init(hex: String, alpha: CGFloat = -1){
        let hexSt = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hexSt).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hexSt.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        if(alpha == -1){
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        } else {
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
        }
    }
}

enum RCColorName {
    case mainColor
    case btnTitleColor
    case btnBorderColor
    case labelColor
    case textFieldbgColor
    case textFieldborderColor
    case codebgTextField
    case codePlaceHolderTextField
    case showTextView
    case borderShowTextView
    case greenBalanceLabel
    case seprateColor
    case backBtnColor
    case loginBtnColor
    case labelBtnColor
    case seprate2Color
    case loginRefreshCodeBg
    case statusBarBgColor
    case discountBack
    case offerDitails
    case offerTimeDitails
    case baseAppColor
    case upView
}

struct RCColors {
    let mainColor: Int = 0x000000
    let btnTitleColor: Int = 0x000000
    let btnBorderColor: Int = 0x000000
    let labelColor: Int = 0x000000
    let textFieldbgColor: Int = 0xffffff
    let textFieldborderColor: Int = 0x000000
    let codebgTextField: Int = 0xE5C0C0
    let codePlaceHolderTextField: Int = 0x860000
    let showTextView: Int = 0x000000
    let borderShowTextView: Int = 0x000000
    let greenBalanceLabel: Int = 0x417505
    let seprateColor: Int = 0xF5F4F2
    let backBtnColor: Int = 0x545250
    let loginBtnColor: Int = 0xF8A63B
    let labelBtnColor: Int = 0xffffff
    let seprate2Color: Int = 0x4A4A4A
    let loginRefreshCodeBg: Int = 0xFFF2E0
    let statusBarBgColor: Int = 0xF8A63B
    let discountBack: Int = 0xEC6161
    let offerDitails: Int = 0xEC6161
    let offerTimeDitails: Int = 0x4F2020
    let baseAppColor: Int = 0xF8A63B
    let upView: Int = 0x545250
}

@objc class Color: NSObject {
    
    //static let
    static let hex: RCColors = RCColors()
    static func get(_ name: RCColorName, alpha: CGFloat = 1) -> UIColor {
        let nameString: String = String.init(describing: name)
        let colorValue: Int!
        colorValue = try! Reflection.get(nameString, from: hex) as! Int
        
        return UIColor(red: CGFloat((colorValue & 0xff0000) >> 16) / 255.0,
                       green: CGFloat((colorValue & 0xff00) >> 8) / 255.0,
                       blue: CGFloat(colorValue & 0xff) / 255.0,
                       alpha: alpha)
    }
}



extension String {
    static func localized(_ phrase: String, _ replaces: String) -> String {
        return  NSLocalizedString(phrase.replacingOccurrences(of: "%@", with: replaces), tableName: "fa",
                                  bundle: Bundle.main, value: phrase, comment: "")
        
    }
    static func localized(_ phrase: String) -> String {
        return  NSLocalizedString(phrase, tableName: "fa",
                                  bundle: Bundle.main, value: phrase, comment: "")
    }
}

extension UIView {
    
    
    
    func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                   paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UILabel {
    
    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
