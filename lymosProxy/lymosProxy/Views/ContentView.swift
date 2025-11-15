import SwiftUI
import NetworkExtension

struct ContentView: View {
    @State private var server = ServerConfig.defaultConfig
    @State private var isConnected = false
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Shadowsocks Proxy")
                .font(.title)
            
            Form {
                TextField("Server", text: $server.server)
                TextField("Port", value: $server.port, formatter: NumberFormatter())
                SecureField("Password", text: $server.password)
                TextField("Method", text: $server.method)
            }
            .padding()
            
            Button(action: toggleConnection) {
                if isLoading {
                    ProgressView()
                } else {
                    Text(isConnected ? "Disconnect" : "Connect")
                        .frame(width: 120)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(isConnected ? .red : .blue)
            
            Spacer()
        }
        .padding()
    }
    
    func toggleConnection() {
        isLoading = true
        if isConnected {
            disconnectVPN()
        } else {
            connectVPN()
        }
    }
    
    func connectVPN() {
        let manager = NETunnelProviderManager()
        let proto = NETunnelProviderProtocol()
        
        proto.providerBundleIdentifier = "com.yourdomain.ShadowsocksApp.PacketTunnel"
        proto.serverAddress = server.server
        proto.providerConfiguration = [
            "server": server.server,
            "server_port": server.port,
            "password": server.password,
            "method": server.method
        ]
        
        manager.protocolConfiguration = proto
        manager.localizedDescription = "Shadowsocks"
        
        manager.saveToPreferences { error in
            if let error = error {
                print("Save error: \(error)")
                return
            }
            
            manager.loadFromPreferences { error in
                if let error = error {
                    print("Load error: \(error)")
                    return
                }
                
                do {
                    try manager.connection.startVPNTunnel()
                    self.isConnected = true
                } catch {
                    print("Start error: \(error)")
                }
                self.isLoading = false
            }
        }
    }
    
    func disconnectVPN() {
        NETunnelProviderManager.loadAllFromPreferences { managers, error in
            if let managers = managers, let manager = managers.first {
                manager.connection.stopVPNTunnel()
                self.isConnected = false
            }
            self.isLoading = false
        }
    }
}
