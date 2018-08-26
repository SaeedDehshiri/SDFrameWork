
import UIKit
import SystemConfiguration

import Reflection

public class SDNetwork {
    
    public class func checkNetwork() -> Bool{
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
    
}

public class SDCall {
    public class func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
}

public class SDLayout {
    public class func createBgTransparent(uiImage: UIImageView, named: String) -> UIImageView{
        uiImage.frame = UIScreen.main.bounds
        uiImage.image = UIImage(named: named)
        uiImage.contentMode = .scaleAspectFill
        return uiImage
    }
    
    public class func createImageWithOriginAndSize(uiImage: UIImageView, image_name: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIImageView{
        uiImage.image = UIImage(named: image_name)
        uiImage.contentMode = .scaleToFill
        uiImage.frame = CGRect(x: x, y: y, width: w, height: h)
        return uiImage
    }
    
    public class func createImageViewWithOriginAndSizeAndBorder(uiImage: UIImageView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIImageView{
        uiImage.frame = CGRect(x: x, y: y, width: w, height: h)
        uiImage.layer.borderColor = UIColor(hex: "d2ab67", alpha: 1).cgColor
        uiImage.layer.borderWidth = 0.3
        uiImage.layer.cornerRadius = 20
        uiImage.clipsToBounds = true
        uiImage.layer.masksToBounds = true
        return uiImage
    }
    
    public class func createBtn(uiBtn: UIButton, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, backColor: UIColor) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = backColor
        uiBtn.layer.cornerRadius = 5
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        
        return uiBtn
    }
    
    
    public class func createBtn(uiBtn: UIButton, btnTitle: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, hex: UIColor) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setTitle(btnTitle, for: .normal)
        uiBtn.titleLabel?.textAlignment = .center
        uiBtn.titleLabel?.font = SDFont.returnFont(size: 11)
        uiBtn.setTitleColor(hex, for: .normal)
        return uiBtn
    }
    
    public class func createBtnWithImage(uiBtn: UIButton, image: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setBackgroundImage(UIImage(named: image), for: .normal)
        return uiBtn
    }
    
    public class func createBtnWithImageAndBorder(uiBtn: UIButton, image: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UIButton{
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
    
    public class func createBtnWithImageWithCustomBorder(uiBtn: UIButton, image: String, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, cornerRadiusSize: CGFloat, borderWidthSize: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        uiBtn.setImage(UIImage(named: image), for: .normal)
        uiBtn.layer.borderWidth = borderWidthSize
        uiBtn.layer.cornerRadius = cornerRadiusSize
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        return uiBtn
    }
    
    public class func createBtnWithCustomBorder(uiBtn: UIButton, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, cornerRadiusSize: CGFloat, borderWidthSize: CGFloat) -> UIButton{
        uiBtn.frame = CGRect(x: x, y: y, width: w, height: h)
        uiBtn.backgroundColor = UIColor.clear
        //        uiBtn.setImage(UIImage(named: image), for: .normal)
        uiBtn.layer.borderWidth = borderWidthSize
        uiBtn.layer.cornerRadius = cornerRadiusSize
        uiBtn.clipsToBounds = true
        uiBtn.layer.masksToBounds = true
        return uiBtn
    }
    
    public class func createLabel(uiLabel: UILabel, hex: UIColor, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, txt: String) -> UILabel{
        uiLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        uiLabel.font = SDFont.returnFont(size: 12)
        uiLabel.clipsToBounds = true
        uiLabel.layer.masksToBounds = true
        uiLabel.textAlignment = .center
        uiLabel.text = txt
        uiLabel.textColor = hex
        return uiLabel
    }
    
    public class func createLabelWithSize(uiLabel: UILabel, hex: UIColor, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, txt: String, size: CGFloat) -> UILabel{
        uiLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        uiLabel.font = SDFont.returnFont(size: size)
        uiLabel.clipsToBounds = true
        uiLabel.layer.masksToBounds = true
        uiLabel.textAlignment = .center
        uiLabel.text = txt
        uiLabel.textColor = hex
        return uiLabel
    }
    
    public class func createTextField(uiTextField: UITextField, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, borderHex: UIColor, bgColor: UIColor, placeHolder: String) -> UITextField{
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
    
    public class func createTextFieldWithKeyboardType(uiTextField: UITextField, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, borderHex: UIColor, bgColor: UIColor, placeHolder: String, keyboard: UIKeyboardType, cornerRadius: CGFloat) -> UITextField{
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
    
    public class func createTextViewWithKeyboardType(uiTextView: UITextView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, borderHex: String, bgColor: String, keyboard: UIKeyboardType, cornerRadius: CGFloat) -> UITextView{
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
    
    public class func createTextViewForShow(uiTextView: UITextView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat, cornerRadius: CGFloat, txt: String) -> UITextView{
        uiTextView.frame = CGRect(x: x, y: y, width: w, height: h)
        uiTextView.layer.cornerRadius = cornerRadius
        uiTextView.layer.borderWidth = 0.3
        uiTextView.text = txt
        uiTextView.isEditable = false
        uiTextView.backgroundColor = UIColor.clear
        uiTextView.font = SDFont.returnFont(size: 14)
        uiTextView.textAlignment = .center
        return uiTextView
    }
    
    
    public class func createSelectedUIView(view: UIView, x: CGFloat, y: CGFloat) -> UIView{
        view.frame = CGRect(x: x, y: y, width: 20.0, height: 20.0)
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.init(hex: "d2ab67")
        view.clipsToBounds = true
        return view
    }
    
    public class func createUnSelectedUIView(view: UIView, x: CGFloat, y: CGFloat) -> UIView{
        view.frame = CGRect(x: x, y: y, width: 20.0, height: 20.0)
        view.layer.borderColor = UIColor(hex: "d2ab67", alpha: 1).cgColor
        view.layer.borderWidth = 0.3
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }
    
    public class func createTabelView(vc: UIViewController, tableView: UITableView, x: CGFloat, y: CGFloat, h: CGFloat, w: CGFloat) -> UITableView{
        
        
        
        if vc is UITableViewDelegate{
            tableView.delegate = vc as? UITableViewDelegate
        }
        
        if vc is UITableViewDataSource{
            tableView.dataSource = vc as? UITableViewDataSource
        }

        tableView.frame = CGRect(x: x, y: y, width: w, height: h)
        return tableView
    }
    
    public class func createTableViewCell(cell: UITableViewCell, newView: UIView, subViews: [UIView], constants: [CGFloat]) -> UITableViewCell{
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

public class SDUserDefault {
    public class func setStringValue(value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    public class func getStringValue(forKey: String) -> String? {
        return UserDefaults.standard.object(forKey: forKey) as? String
    }
    
    public class func setIntValue(value: Int, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    public class func getIntValue(forKey: String) -> Int? {
        return UserDefaults.standard.object(forKey: forKey) as? Int
    }
    
    public class func setBoolValue(bool: Bool, forKey: String) {
        UserDefaults.standard.set(bool, forKey: forKey)
    }
    
    public class func getBoolValue(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
}


public class SDTime {
    public class func returnDateFromMilisecond(_ myDate : String!) -> String{

        let date = Date(timeIntervalSince1970: TimeInterval(Int(myDate)!))

        let calendar = Calendar(identifier: .persian)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        
        return "\(components.year!)/\(components.month!)/\(components.day!)"
    }
    
    public class func returnDateFromTimeInterval(_ myDate : TimeInterval!) -> String{

        let date = Date(timeIntervalSince1970: myDate)
        let calendar = Calendar(identifier: .persian)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        
        return "\(components.year!)/\(components.month!)/\(components.day!)"
    }
}


public class SDAlert {
    public class func createAlertViewMessageAndVCAndTitleDismiss(vc: UIViewController, title: String, message: String, dismissBtnTxt: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: dismissBtnTxt, style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    public class func watingViewWithAlert(vc: UIViewController, title: String, message: String, dismissBtnTxt: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let indicator = UIActivityIndicatorView(frame: alert.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alert.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.startAnimating()
        
        return alert
    }
}

public class SDString{
    
    public class func replaceImageName(text: String) -> String{
        if SDUserDefault.getStringValue(forKey: "SDUserDefault_ColorApp") == "white"{
            return "\(text)-black"
        }else{
            return "\(text)-white"
        }
    }
    
    public class func height(withConstrainedWidth width: CGFloat, font: UIFont, txt: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = txt.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public class func width(withConstrainedHeight height: CGFloat, font: UIFont, txt: String) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = txt.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

public class SDFont{
    public class func returnFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "sample", size: size)
    }
    
    public class func returnFontName(point: Int, size: CGFloat) -> UIFont? {
        
        var fonts: [String] = ["sample-Medium", //0
            "sample-Bold", //1
            "sample-Black", //2
            "sample", //3
            "sample-UltraLight", //4
            "sample-Light"]  //5
        return UIFont(name: fonts[point], size: size)
    }
}



extension UIColor{
    public convenience init(hex: String, alpha: CGFloat = -1){
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

}

struct RCColors {

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
    public static func localized(_ phrase: String, _ replaces: String) -> String {
        return  NSLocalizedString(phrase.replacingOccurrences(of: "%@", with: replaces), tableName: "fa",
                                  bundle: Bundle.main, value: phrase, comment: "")
        
    }
    public static func localized(_ phrase: String) -> String {
        return  NSLocalizedString(phrase, tableName: "fa",
                                  bundle: Bundle.main, value: phrase, comment: "")
    }
}

extension UIView {
    
    
    
    public func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
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
    public func applySketchShadow(
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
    public func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
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
