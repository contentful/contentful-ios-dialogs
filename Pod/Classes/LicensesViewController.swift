//
//  LicensesViewController.swift
//  Pods-contentful-ios-dialogs
//
//  Created by JP Wright on 05.07.18.
//

import Foundation
import UIKit
import markymark

class LicensesViewController: UIViewController, UITextViewDelegate {

    var textView: UITextView!

    func licenseInfo() -> String {
        let displayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String

        let licenses = """
        # \(displayName)

        Copyright (c) 2018 [Contentful GmbH](https://www.contentful.com)

        Uses icons from the [IcoMoon icon set](http://keyamoon.com/icomoon/), licensed under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/).


        """
        let fileName = try! FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath).filter( { $0.hasSuffix("-acknowledgements.markdown") }).first!
        // Strip extension.
        let pathToAcknowledgements = Bundle.main.path(forResource: fileName, ofType: "")!
        let acknowledgements = try! String(contentsOfFile: pathToAcknowledgements, encoding: .utf8)
        return acknowledgements
    }

    override func loadView() {
        super.loadView()

        textView = UITextView(frame: view.bounds)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
        view.addSubview(textView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Licensing", comment: "")
        view.backgroundColor = .white

        textView.delegate = self
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        textView.attributedText = Markdown.attributedMarkdownText(text: licenseInfo())
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
}

struct Markdown {
    static func attributedMarkdownText(text: String) -> NSAttributedString {
        let markyMark = MarkyMark() { $0.setFlavor(ContentfulFlavor()) }
        let markdownItems = markyMark.parseMarkDown(text)
        let styling = DefaultStyling()
        let config = MarkDownToAttributedStringConverterConfiguration(styling: styling)
        // Configure markymark to leverage the Contentful images API when encountering inline SVGs.

        let converter = MarkDownConverter(configuration: config)
        let attributedText = converter.convert(markdownItems)
        return attributedText
    }
}
