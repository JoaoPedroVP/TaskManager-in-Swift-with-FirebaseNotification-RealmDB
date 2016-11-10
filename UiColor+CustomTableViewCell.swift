

import UIKit

extension UIColor{
    
    class func backgroundColor()->UIColor {
        return UIColor(red: 86.0/255.0 , green: 149.0/255.0 , blue: 211.0/255.0 , alpha: 1.0)
    }
    
    class func frontColor()->UIColor {
        return UIColor(red: 97.0/255.0 , green: 167.0/255.0 , blue: 232.0/255.0 , alpha: 1.0)
    }
    
    class func cellFontColor()->UIColor {
        return UIColor.whiteColor()
    }
    
    class func deleteTarefaColor()->UIColor {
        return UIColor.redColor()
    }
    
    class func updateTarefaColor()->UIColor {
        return UIColor.blueColor()
    }
    
}
