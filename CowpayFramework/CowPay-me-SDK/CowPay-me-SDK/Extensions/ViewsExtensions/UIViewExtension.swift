//
//  UIViewExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import AVKit
import UIKit

extension UIView {
    func xibSetUp(view: inout UIView?, nibName: String) {
        view = loadViewFromNib(nibName: nibName)
        view!.frame = bounds
        view!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view!)
        layoutIfNeeded()
    }

    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        backgroundColor = .clear
        return view
    }

    func round(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func fillSuperView(shouldUseSafeArea: Bool = true, padding: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: shouldUseSafeArea ?
                superview.safeAreaLayoutGuide.leadingAnchor :
                superview.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: shouldUseSafeArea ?
                superview.safeAreaLayoutGuide.trailingAnchor :
                superview.trailingAnchor, constant: -padding.right),

            topAnchor.constraint(equalTo: shouldUseSafeArea ?
                superview.safeAreaLayoutGuide.topAnchor :
                superview.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: shouldUseSafeArea ?
                superview.safeAreaLayoutGuide.bottomAnchor :
                superview.bottomAnchor, constant: -padding.bottom),
        ])
    }

    func fillSuperViewVertically(shouldUseSafeArea: Bool = true, padding: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: shouldUseSafeArea ?
                superview.safeAreaLayoutGuide.topAnchor :
                superview.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: shouldUseSafeArea ?
                superview.safeAreaLayoutGuide.bottomAnchor :
                superview.bottomAnchor, constant: -padding.bottom),
        ])
    }

    func removeAllConstraints() {
        removeConstraints(constraints)
    }

}

@IBDesignable
extension UIView {
    @IBInspectable var isHalfRounded: Bool {
        get {
            return layer.cornerRadius == layer.bounds.size.height / 2
        } set {
            clipsToBounds = true
            layer.cornerRadius = layer.bounds.size.height / 2
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        } set {
            layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable internal var shadow_Color: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        } set {
            layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        } set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowOffsetX: CGFloat {
        get {
            return layer.shadowOffset.width
        } set {
            layer.shadowOffset = CGSize(width: newValue, height: layer.shadowOffset.height)
        }
    }

    @IBInspectable var shadowOffsetY: CGFloat {
        get {
            return layer.shadowOffset.height
        } set {
            layer.shadowOffset = CGSize(width: layer.shadowOffset.width, height: newValue)
        }
    }
}

extension UIView {
    var viewController: UIViewController? {
        let next = self.next
        if next is UIViewController {
            return next as? UIViewController
        } else if next is UIView {
            return (next as? UIView)?.viewController
        } else {
            return nil
        }
    }
}

extension UIView {
    enum Side {
        case top
        case bottom
        case left
        case right
    }

    func addBorder(to side: Side, color: UIColor, borderWidth: CGFloat) {
        let subLayer = CALayer()
        subLayer.borderColor = color.cgColor
        subLayer.borderWidth = borderWidth
        let origin = findOrigin(side: side, borderWidth: borderWidth)
        let size = findSize(side: side, borderWidth: borderWidth)
        subLayer.frame = CGRect(origin: origin, size: size)
        layer.addSublayer(subLayer)
    }

    private func findOrigin(side: Side, borderWidth: CGFloat) -> CGPoint {
        switch side {
        case .right:
            return CGPoint(x: frame.maxX - borderWidth, y: 0)
        case .bottom:
            return CGPoint(x: 0, y: frame.maxY - borderWidth)
        default:
            return .zero
        }
    }

    private func findSize(side: Side, borderWidth: CGFloat) -> CGSize {
        switch side {
        case .left, .right:
            return CGSize(width: borderWidth, height: frame.size.height)
        case .top, .bottom:
            return CGSize(width: frame.size.width, height: borderWidth)
        }
    }
}

extension UIView {
    func deactivateRTL(of view: UIView) {
        // 1. code here do something with view
        for subview in view.subviews {
            subview.semanticContentAttribute = .forceLeftToRight
            deactivateRTL(of: subview)
        }
    }
}

extension UIView {
    func audioDurationInteger(path: String, complition: @escaping (_ duration: Int) -> Void) {
        guard let url = URL(string: path) else { return }
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url, options: nil)
            let audioDuration = CMTimeGetSeconds(asset.duration)
            guard !(audioDuration.isNaN || audioDuration.isInfinite) else {
                complition(.zero)
                return
            }
            DispatchQueue.main.async {
                complition(Int(audioDuration))
            }
        }
    }

    func audioDurationString(path: String, complition: @escaping (_ duration: String) -> Void) {
        guard let url = URL(string: path) else { return }
        var seconds = 0
        var minutes = 0
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url, options: nil)
            let audioDuration = CMTimeGetSeconds(asset.duration)
            guard !(audioDuration.isNaN || audioDuration.isInfinite) else {
                complition("00:00")
                return
            }
            let currentTime = Int(audioDuration)
            minutes = currentTime / 60
            seconds = currentTime - minutes * 60
            DispatchQueue.main.async {
                complition(String(format: "%02d:%02d", minutes, seconds) as String)
            }
        }
    }
}

public extension UIView {
    /// Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    /// Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    /// Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
}

extension UIView {
    class func fromNibContainer<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension AVPlayer {

    var isPlaying: Bool {
        return ((rate != 0) && (error == nil))
    }
}
