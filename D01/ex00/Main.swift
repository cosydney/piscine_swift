import Foundation

var arrayValue : [Value] = Value.allValue
var arrayColor : [Color] = Color.allColor

for value in arrayValue {
    print (value, "is", value.rawValue)
}

for color in arrayColor {
    print (color, "is", color.rawValue)
}
