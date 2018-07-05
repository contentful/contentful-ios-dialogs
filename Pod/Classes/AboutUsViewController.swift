//
//  AboutUsViewController.swift
//  Pods-contentful-ios-dialogs
//
//  Created by JP Wright on 05.07.18.
//

import Foundation
import UIKit
import SafariServices

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    static let cellIdentifier = String(describing: AboutUsViewController.self)
    let source: String

    // MARK: UIViewController

    init() {
        source = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(named: "about", in: Bundle(for: AboutUsViewController.self), compatibleWith: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        source = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
        super.init(coder: aDecoder)
        tabBarItem.image = UIImage(named: "about", in: Bundle(for: AboutUsViewController.self), compatibleWith: nil)
    }

    override func loadView() {
        tableView = UITableView(frame: .zero)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: AboutUsViewController.cellIdentifier)

        // Enable table view cells to be sized dynamically based on inner content.
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
    }

    func pushWebViewController(title: String, urlString: String) {
        let url = URL(string: urlString)!
        let vc: SFSafariViewController
        if #available(iOS 11.0, *) {
            let config = SFSafariViewController.Configuration()
            config.barCollapsingEnabled = true
            vc = SFSafariViewController(url: url, configuration: config)
        } else {
            // Fallback on earlier versions
            vc = SFSafariViewController(url: url)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let urlString = "https://www.contentful.com/faq/?utm_source=\(source)&utm_medium=iOS&utm_campaign=faq"
            pushWebViewController(title: "FAQ", urlString: urlString)
        case 1:
            let urlString = "https://support.contentful.com/hc/en-us/requests/new/?utm_source=\(source)&utm_medium=iOS&utm_campaign=feedback"
            pushWebViewController(title: "Contentful support", urlString: urlString)
        case 2:
            let licenses = LicensesViewController()
            navigationController?.pushViewController(licenses, animated: true)
        default:
            fatalError()
        }
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutUsViewController.cellIdentifier)!

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = NSLocalizedString("FAQ", comment: "")
        case 1:
            cell.textLabel?.text = NSLocalizedString("Contact support", comment: "")
        case 2:
            cell.textLabel?.text = NSLocalizedString("Licensing information", comment: "");
        default:
            fatalError()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 150.0))
        view.backgroundColor = .groupTableViewBackground
        let logo = UIImage(named: "logo", in: Bundle(for: AboutUsViewController.self), compatibleWith: nil)!
        let logoImageView = UIImageView(image: logo)
        logoImageView.frame = CGRect(x: (view.frame.width - 70.0) / 2, y: 10.0, width: 70.0, height: 70.0)

        view.addSubview(logoImageView)

        let contentful = UILabel(frame: CGRect(x: 0.0, y: logoImageView.frame.maxY, width: view.frame.width, height: 20.0))
        contentful.font = .boldSystemFont(ofSize: 18.0)
        contentful.text = "Contentful GmbH"
        contentful.textAlignment = .center
        view.addSubview(contentful)
        return view
    }
}
