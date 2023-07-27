
import Foundation

class Canvas {
    
    enum Color: UInt {
        case white = 0xffffff
        case red = 0xff6666
        case blue = 0x0088dd
        case green = 0x00dd99
        case purple = 0xddbbdd
        case pink = 0xff9999
        case orange = 0xff9966
        case black = 0x222222
        
        static let lists: [Color] = [
            .white,
            .red,
            .blue,
            .green,
            .purple,
            .pink,
            .orange,
            .black,
        ]
    }
    
    enum TextDecoration {
        case none
        case clearBorder
    }
    
    enum Align {
        case left
        case center
        case right
    }
    
}
