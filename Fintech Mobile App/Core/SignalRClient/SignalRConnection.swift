import Foundation
import SignalRClient

class SignalRConnection: ObservableObject {
    var hubConnection: HubConnection?
    
    init() {
        if let balanceURL = URL(string: "http://localhost:5245/balancehub") {
            self.hubConnection = HubConnectionBuilder(url: balanceURL)
                .withAutoReconnect()
                .withLogging(minLogLevel: .error)
                .withHubConnectionOptions(configureHubConnectionOptions: {options in options.keepAliveInterval = 0.1 })
                .withPermittedTransportTypes(.webSockets)
                .build()
        }
    }
    
    func startConnection() {
        hubConnection?.on(method: "ReceiveBalanceData", callback: { (message: String) in
            print("📩 Received balance update: \(message)")
        })
        
        hubConnection?.start()
    }
    
    
    func stop() {
        hubConnection?.stop()
    }
    
    func sendBalanceRequest() {
        hubConnection?.invoke(method: "SendBalanceData", "Initial request from client") { error in
            if let error = error {
                print("❌ Invoke failed: \(error.localizedDescription)")
            } else {
                print("✅ SendBalanceData invoked")
            }
        }
    }
}

