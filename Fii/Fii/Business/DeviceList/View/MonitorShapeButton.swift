//
//  MonitorShapeButton.swift
//  Fii
//
//  Created by yetao on 2019/4/9.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

//let PathKey = "path"
//let PositionKey = "position"
//func PathDic(_ path: Any, _ position: Any) {
//    [
//        "path" : path,
//        "position" : position
//    ]
//}
//let OffSet = 2.5
//
//class ZAShapeButton {
//    private var pathArray: [AnyHashable] = []
//}
//
//
enum ButtonType : Int {
    /**
     *  圆形五个按钮 上下左右 中心
     */
    case round = 0
    /**
     *  单个圆形按钮  只响应 SelectButtonPosition_Center
     */
    case roundSingle
    /**
     *  圆角按钮 只响应 SelectButtonPosition_Center
     */
    case rect
    /**
     *  竖加减  只响应 SelectButtonPosition_Buttom  SelectButtonPosition_Top，
     */
    case vPlusAndMin
    /**
     *  横加减   只响应 SelectButtonPosition_Right  SelectButtonPosition_Left，
     */
    case hPlusAndMin
}

enum ButtonClickType : Int {
    //手势抬起响应
    case touchUpInside = 0
    //长按0.5s响应
    case longPress
}

enum SelectButtonPosition : Int {
    case top = 1
    static let right: SelectButtonPosition = SelectButtonPosition(rawValue: 1 << 1)!
    static let buttom: SelectButtonPosition = SelectButtonPosition(rawValue: 1 << 2)!
    static let left: SelectButtonPosition = SelectButtonPosition(rawValue: 1 << 3)!
    static let center: SelectButtonPosition = SelectButtonPosition(rawValue: 1 << 4)!
}

class MonitorShapeButton: UIImageView {
    //    NSArray *pathArray;
    var layerArray: [AnyHashable] = []
    var touchAction: Selector?
    var longPressAction: Selector?
    var handel: Any?
    var responseState: UIGestureRecognizer.State?
    var buttonType: ButtonType?
    var titleLabel: UILabel!
    var longPressTimer: Timer?
    var longPressGestureRecognizer: UILongPressGestureRecognizer!
//    //长按手势未执行
    var longPressNotComplete = false
//    /**
//     *  获取选中位置
//     */
//    var selectButtonPosition: SelectButtonPosition?
//    /**
//     *  初始化button
//     *
//     *  @param frame <#frame description#>
//     *  @param type  button 类型
//     *
//     *  @return <#return value description#>
//     */
//    init(frame: CGRect, buttonType type: ButtonType) {
//
//    }
//
//    func addTarget(_ target: Any?, action: Selector, forResponseState state: ButtonClickType) {
//    }
//    /**
//     *  设置响应位置，
//     *
//     *  @param position 可以传多个参数
//     */
//    func setResponsePosition(_ position: SelectButtonPosition) {
//    }
//
//    func setTitle(_ title: String?) {
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }


//    //  Converted to Swift 4 by Swiftify v4.2.28451 - https://objectivec2swift.com/
//    init(frame: CGRect, buttonType type: ButtonType) {
//        super.init(frame: frame)
//        buttonType = type
//        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
//        titleLabel.backgroundColor = UIColor.clear
//        titleLabel.textColor = UIColor(red: 159 / 255.0, green: 159 / 255.0, blue: 167 / 255.0, alpha: 1)
//        titleLabel.font = UIFont.systemFont(ofSize: 15)
//        titleLabel.textAlignment = .center
//        addSubview(titleLabel)
//
//        isUserInteractionEnabled = true
//
//        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(_:)))
//        longPressGestureRecognizer.minimumPressDuration = 0.05
//        addGestureRecognizer(longPressGestureRecognizer)
//
//        switch type {
//        case ButtonTypeRect:
//            image = UIImage(named: "virtual_control_rect")
//        case ButtonTypeRoundSingle:
//            image = UIImage(named: "virtual_control_round_single")
//        case ButtonTypeRound:
//            image = UIImage(named: "virtual_control_round")
//        case ButtonTypeHPlusAndMin:
//            image = UIImage(named: "virtual_control_h")
//        case ButtonTypeVPlusAndMin:
//            image = UIImage(named: "virtual_control_v")
//        default:
//            break
//        }
//    }
//
//    func setImage(_ image: UIImage?) {
//        super.setImage(image)
//        frame = CGRect(x: frame.minX, y: frame.minY, width: self.image.size.width, height: self.image.size.height)
//        titleLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
//
//    }
//
//    func setResponsePosition(_ position: SelectButtonPosition) {
//        if !pathArray {
//            pathArray = [AnyHashable]()
//        } else {
//            pathArray.removeAll()
//        }
//
//        if buttonType == ButtonTypeHPlusAndMin {
//            if position & SelectButtonPositionLeft != 0 {
//                pathArray.append(rectShap(withPosition: SelectButtonPositionLeft))
//            }
//
//            if position & SelectButtonPositionRight != 0 {
//                pathArray.append(rectShap(withPosition: SelectButtonPositionRight))
//            }
//        }
//
//        if buttonType == ButtonTypeVPlusAndMin {
//            if position & SelectButtonPositionTop != 0 {
//                pathArray.append(rectShap(withPosition: SelectButtonPositionTop))
//            }
//            if position & SelectButtonPositionButtom != 0 {
//                pathArray.append(rectShap(withPosition: SelectButtonPositionButtom))
//            }
//        }
//
//        if buttonType == ButtonTypeRound {
//            if position & SelectButtonPositionTop != 0 {
//                pathArray.append(roundShap(withPosition: SelectButtonPositionTop))
//            }
//            if position & SelectButtonPositionLeft != 0 {
//                pathArray.append(roundShap(withPosition: SelectButtonPositionLeft))
//            }
//            if position & SelectButtonPositionRight != 0 {
//                pathArray.append(roundShap(withPosition: SelectButtonPositionRight))
//            }
//            if position & SelectButtonPositionButtom != 0 {
//                pathArray.append(roundShap(withPosition: SelectButtonPositionButtom))
//            }
//            if position & SelectButtonPositionCenter != 0 {
//                pathArray.append(roundShap(withPosition: SelectButtonPositionCenter))
//            }
//        }
//    }
//
//
//    func pathArray() -> [AnyHashable]? {
//        if !pathArray {
//            pathArray = [AnyHashable]()
//            switch buttonType {
//            case ButtonTypeHPlusAndMin:
//                pathArray.append(rectShap(withPosition: SelectButtonPositionLeft))
//                pathArray.append(rectShap(withPosition: SelectButtonPositionRight))
//            case ButtonTypeVPlusAndMin:
//                pathArray.append(rectShap(withPosition: SelectButtonPositionTop))
//                pathArray.append(rectShap(withPosition: SelectButtonPositionButtom))
//            case ButtonTypeRound:
//                pathArray.append(roundShap(withPosition: SelectButtonPositionLeft))
//                pathArray.append(roundShap(withPosition: SelectButtonPositionRight))
//                pathArray.append(roundShap(withPosition: SelectButtonPositionTop))
//                pathArray.append(roundShap(withPosition: SelectButtonPositionButtom))
//                pathArray.append(roundShap(withPosition: SelectButtonPositionCenter))
//            case ButtonTypeRoundSingle:
//                pathArray.append(roundShap())
//            case ButtonTypeRect:
//                pathArray.append(rectShap())
//            default:
//                break
//            }
//        }
//        return pathArray
//
//    }
//
//    func addTarget(_ target: Any?, action: Selector, forResponseState state: ButtonClickType) {
//        handel = target
//        switch state {
//        case ButtonClickTypeLongPress:
//            longPressAction = action
//        case ButtonClickTypeTouchUpInside:
//            touchAction = action
//        default:
//            break
//        }
//    }
    
    init(frame: CGRect, buttonType type: ButtonType) {
        super.init(frame: frame)
        buttonType = type
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        titleLabel!.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor(red: 159 / 255.0, green: 159 / 255.0, blue: 167 / 255.0, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        isUserInteractionEnabled = true
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.05
        addGestureRecognizer(longPressGestureRecognizer)
        switch type {
        case .rect:
            image = UIImage(named: "virtual_control_rect")
        case .roundSingle:
            image = UIImage(named: "virtual_control_round_single")
        case .round:
            image = UIImage(named: "virtual_control_round")
        case .hPlusAndMin:
            image = UIImage(named: "virtual_control_h")
        case .vPlusAndMin:
            image = UIImage(named: "virtual_control_v")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func longPressGesture(_ longGesture: UILongPressGestureRecognizer?) {
        
    }

    
}
    



    
    
    
    
