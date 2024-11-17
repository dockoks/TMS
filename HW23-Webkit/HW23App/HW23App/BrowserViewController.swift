import UIKit
import WebKit

protocol BrowserDelegate: AnyObject {
    func loadURL(_ urlString: String)
}

class BrowserViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate, BrowserDelegate {
    let historyService: HistoryService = HistoryServiceImpl()
    let bookmarksService: BookmarksService = BookmarksServiceImpl()
    
    // MARK: UI Elements
    let searchContainerView = UIView()
    let urlTextField = UITextField()
    let webView = WKWebView()
    let controlsContainerView = UIView()
    let progressView = UIProgressView(progressViewStyle: .bar)

    lazy var savePageButton = BrowserButtonToggle(style: .save) { [weak self] in self?.savePage() }
    lazy var reloadButton = BrowserButton(style: .reload) { [weak self] in self?.reloadPage() }
    lazy var backButton = BrowserButton(style: .backward) { [weak self] in self?.goBack() }
    lazy var forwardButton = BrowserButton(style: .forward) { [weak self] in self?.goForward() }
    lazy var bookmarkButton = BrowserButton(style: .bookmarks) { [weak self] in self?.openBookmarks() }
    lazy var historykButton = BrowserButton(style: .history) { [weak self] in self?.openHistory() }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUIComponents()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        refreshSavePageButton()
    }

    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    // MARK: - Setup UI
    private func setupUIComponents() {
        webView.navigationDelegate = self
        
        setupSearchContainer()
        setupControlsContainer()
        setupWebView()
    }
    
    // MARK: - Auto Layout Constraints
    private func setupSearchContainer() {
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(urlTextField)
        searchContainerView.addSubview(savePageButton)
        searchContainerView.addSubview(reloadButton)
        searchContainerView.addSubview(progressView)
        
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.backgroundColor = .secondarySystemBackground
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.borderStyle = .roundedRect
        urlTextField.placeholder = "Enter URL"
        urlTextField.delegate = self
        urlTextField.keyboardType = .URL
        urlTextField.autocapitalizationType = .none
        urlTextField.autocorrectionType = .no
        urlTextField.returnKeyType = .go
        
        progressView.tintColor = .systemIndigo
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchContainerView.bottomAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 8),
            
            urlTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            urlTextField.leadingAnchor.constraint(equalTo: savePageButton.trailingAnchor),
            urlTextField.trailingAnchor.constraint(equalTo: reloadButton.leadingAnchor),
            
            savePageButton.centerYAnchor.constraint(equalTo: urlTextField.centerYAnchor),
            savePageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            reloadButton.centerYAnchor.constraint(equalTo: urlTextField.centerYAnchor),
            reloadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            // Progress View Constraints
            progressView.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: controlsContainerView.topAnchor)
        ])
    }
    
    private func setupControlsContainer() {
        view.addSubview(controlsContainerView)
        controlsContainerView.translatesAutoresizingMaskIntoConstraints = false
        controlsContainerView.backgroundColor = .secondarySystemBackground
        
        let SV = UIStackView(arrangedSubviews: [backButton, forwardButton, bookmarkButton, historykButton])
        SV.axis = .horizontal
        SV.distribution = .equalSpacing
        SV.alignment = .center
        
        controlsContainerView.addSubview(SV)
        SV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            SV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            SV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            SV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            controlsContainerView.topAnchor.constraint(equalTo: SV.topAnchor),
            controlsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlsContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Web Navigation Actions
    private func savePage() {
        guard let urlString = webView.url?.absoluteString else { return }
        if savePageButton.isOn {
            bookmarksService.remove(url: urlString)
        } else {
            bookmarksService.add(url: urlString)
        }
        refreshSavePageButton()
    }
    
    private func goBack() {
        if webView.canGoBack {
            webView.goBack()
            refreshSavePageButton()
        }
    }
    
    private func goForward() {
        if webView.canGoForward {
            webView.goForward()
            refreshSavePageButton()
        }
    }
    
    private func reloadPage() {
        webView.reload()
        refreshSavePageButton()
    }
    
    private func openBookmarks() {
        let bookmarkVC = BookmarksViewController(bookService: bookmarksService)
        bookmarkVC.delegate = self
        navigationController?.pushViewController(bookmarkVC, animated: true)
    }
    
    private func openHistory() {
        let historyVC = HistoryViewController(historyService: historyService)
        historyVC.delegate = self
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let urlString = textField.text {
            loadURL(urlString)
        }
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Load URL
    internal func loadURL(_ urlString: String) {
        var formattedURLString = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        if !formattedURLString.lowercased().hasPrefix("http") {
            formattedURLString = "https://" + formattedURLString
        }
        if let url = URL(string: formattedURLString) {
            let request = URLRequest(url: url)
            webView.load(request)
            refreshSavePageButton()
            historyService.add(url: formattedURLString)
        }
    }
    
    private func refreshSavePageButton() {
        guard let urlString = webView.url?.absoluteString else { return }
        if bookmarksService.contains(url: urlString) {
            savePageButton.isOn = true
        } else {
            savePageButton.isOn = false
        }
    }
    
    // MARK: - Observe WebView Progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            progressView.progress = Float(webView.estimatedProgress)
            
            if webView.estimatedProgress < 1.0 {
                progressView.isHidden = false
            } else {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.progressView.isHidden = true
                }
            }
        }
    }
}
