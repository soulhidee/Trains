import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // MARK: - Properties
    let url: URL
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
