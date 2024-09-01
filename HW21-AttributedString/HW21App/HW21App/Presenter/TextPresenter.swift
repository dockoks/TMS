import UIKit

final class TextPresenter {
    private var model: TextModel
    private weak var view: TextView?
    private let originalText: NSAttributedString

    init(model: TextModel, view: TextView) {
        self.model = model
        self.view = view
        self.originalText = model.text.copy() as! NSAttributedString
    }

    func applyAttribute(attribute: NSAttributedString.Key, value: Any, shouldToggle: Bool = true) {
        if shouldToggle {
            let currentAttributes = model.text.attributes(at: model.selectedRange.location, effectiveRange: nil)
            if let existingValue = currentAttributes[attribute], (existingValue as AnyObject).isEqual(value) {
                model.text.removeAttribute(attribute, range: model.selectedRange)
            } else {
                model.text.addAttribute(attribute, value: value, range: model.selectedRange)
            }
        } else {
            model.text.addAttribute(attribute, value: value, range: model.selectedRange)
        }
        view?.updateText(model.text)
    }

    func setRange(_ range: NSRange) {
        model.selectedRange = range
    }
    
    func getTextLength() -> Int {
        return model.text.length
    }
    
    func getTextLocation() -> Int {
        return model.selectedRange.location
    }

    func resetText() {
        model.text = NSMutableAttributedString(attributedString: originalText)
        view?.updateText(model.text)
    }
}
