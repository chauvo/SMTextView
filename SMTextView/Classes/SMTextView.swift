//
//  SMTextView.swift
//  Pods
//
//  Created by Spencer Mandrusiak on 2017-04-24.
//
//

import UIKit

@IBDesignable public class SMTextView: UITextView {

    //MARK: - Variables
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            refreshPlaceholderInput()
        }
    }
    @IBInspectable public var placeholderText: String = "" {
        didSet {
            adjustPlaceholder()
            refreshPlaceholderInput()
        }
    }
    @IBInspectable public var placeholderTextColor: UIColor = .lightGray {
        didSet {
            refreshPlaceholderInput()
        }
    }
    @IBInspectable public var borderColor: UIColor = .red {
        didSet {
            refreshPlaceholderInput()
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            refreshPlaceholderInput()
        }
    }
    @IBInspectable public var topInset: CGFloat = 0 {
        didSet {
            refreshPlaceholderInput()
            updateInsets()
        }
    }
    @IBInspectable public var leftInset: CGFloat = 0 {
        didSet {
            refreshPlaceholderInput()
            updateInsets()
        }
    }
    @IBInspectable public var rightInset: CGFloat = 0 {
        didSet {
            refreshPlaceholderInput()
            updateInsets()
        }
    }
    fileprivate var bottomInset: CGFloat = 24 {
        didSet {
            updateInsets()
        }
    }

    public override var text: String! {
        didSet {
            adjustPlaceholder()
            refreshPlaceholderInput()
        }
    }

    public var isCharacterCountEnabled = true {
        didSet {
            if !isCharacterCountEnabled {
                counterLabel.removeFromSuperview()
                bottomInset = topInset
            }else {
                bottomInset = counterLabel.bounds.height+borderWidth+4
            }
        }
    }
    public var maxCharacterCount = 100 {
        didSet {
            updateCounterLabelMax()
        }
    }

    //MARK: - Additional Views
    fileprivate var placeholderTextView: UITextView!
    public var counterLabel: UILabel!


    //MARK: - Overrides
    override public func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        initPlaceholder()
        initLabel()
    }

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
        initPlaceholder()
        initLabel()
    }

    override public func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        placeholderTextView.isHidden = true
        return true
    }

    override public func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        if placeholderTextView != nil {
            adjustPlaceholder()
        }
        return true
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initPlaceholder()
        initLabel()
    }

    //MARK: Actions
    @objc func placeholderTapped(_ recognizer: UITapGestureRecognizer) {
        _ = self.becomeFirstResponder()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        //        bottomInset = counterLabel.bounds.height+borderWidth+4
    }
}

//MARK: - Custom Initialization
extension SMTextView {
    fileprivate func initPlaceholder() {
        placeholderTextView = UITextView(frame: bounds)
        placeholderTextView.font = font
        placeholderTextView.text = placeholderText
        placeholderTextView.textColor = placeholderTextColor
        placeholderTextView.textAlignment = textAlignment
        placeholderTextView.backgroundColor = .clear
        placeholderTextView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(placeholderTapped)))
        addSubview(placeholderTextView)
    }

    fileprivate func initLabel() {
        if isCharacterCountEnabled {
            counterLabel = UILabel()
            counterLabel.font = counterLabel.font.withSize(10)
            counterLabel.text = "0/\(maxCharacterCount)"
            updateCounterLabel()
            addSubview(counterLabel)
        }
    }
}

//MARK: - Update Methods
extension SMTextView {
    public func updateCounterLabel() {
        setNeedsLayout()
        layoutIfNeeded()

        counterLabel.sizeToFit()

        let x = bounds.maxX-counterLabel.bounds.width-4-borderWidth
        let y = bounds.maxY-counterLabel.bounds.height-2-borderWidth

        counterLabel.frame.origin = CGPoint(x: x, y: y)
    }

    fileprivate func updateCounterLabelMax() {
        counterLabel.text = "0/\(maxCharacterCount)"
        counterLabel.sizeToFit()
    }

    fileprivate func refreshPlaceholderInput() {
        textViewDidChange(self)
        placeholderTextView.font = font
        placeholderTextView.textColor = placeholderTextColor
        placeholderTextView.textAlignment = textAlignment
    }
    fileprivate func updateInsets() {
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        if isScrollEnabled {
            textContainerInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: 0, right: rightInset)
            placeholderTextView.textContainerInset = textContainerInset
        }else {
            textContainerInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            placeholderTextView.textContainerInset = textContainerInset
        }
    }
    fileprivate func adjustPlaceholder() {
        if text != "" {
            placeholderTextView.text = ""
            placeholderTextView.isHidden = true
        }else {
            placeholderTextView.text = placeholderText
            placeholderTextView.isHidden = false
        }
    }
}

//MARK: - UITextViewDelegate
extension SMTextView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if isCharacterCountEnabled {
            return textView.text.count + text.count - range.length <= maxCharacterCount
        }
        return true
    }
    public func textViewDidChange(_ textView: UITextView) {
        if isCharacterCountEnabled {
            let count = textView.text.count
            counterLabel.text = "\(count)/\(maxCharacterCount)"
            updateCounterLabel()
        }
    }
}
