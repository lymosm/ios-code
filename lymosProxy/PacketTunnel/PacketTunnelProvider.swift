import NetworkExtension
import os.log

class PacketTunnelProvider: NEPacketTunnelProvider {
    private var observer: NSObjectProtocol?
    private let logger = OSLog(subsystem: "com.your.app.packet-tunnel", category: "Shadowsocks")

    override func startTunnel(options: [String: NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        os_log("Starting Shadowsocks tunnel", log: logger)
        
        // 1. 从配置中读取 Shadowsocks 参数
        guard let protocolConfiguration = self.protocolConfiguration as? NETunnelProviderProtocol,
              let config = protocolConfiguration.providerConfiguration else {
            completionHandler(NSError(domain: "ConfigError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid configuration"]))
            return
        }
        
        // 2. 验证必要参数
        guard let server = config["server"] as? String,
              let serverPort = config["server_port"] as? Int,
              let password = config["password"] as? String,
              let method = config["method"] as? String else {
            completionHandler(NSError(domain: "ConfigError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Missing required parameters"]))
            return
        }
        
        // 3. 设置本地代理（关键步骤）
        let proxySettings = NEProxySettings()
        proxySettings.autoProxyConfigurationEnabled = true
        proxySettings.proxyAutoConfigurationJavaScript = """
            function FindProxyForURL(url, host) {
                return "SOCKS5 127.0.0.1:1080";
            }
        """
        
        // 4. 配置网络路由
        let ipv4Settings = NEIPv4Settings(
            addresses: ["192.169.89.1"],
            subnetMasks: ["255.255.255.0"]
        )
        ipv4Settings.includedRoutes = [NEIPv4Route.default()]
        ipv4Settings.excludedRoutes = [
            NEIPv4Route(destinationAddress: "10.0.0.0", subnetMask: "255.0.0.0"),
            NEIPv4Route(destinationAddress: "172.16.0.0", subnetMask: "255.240.0.0"),
            NEIPv4Route(destinationAddress: "192.168.0.0", subnetMask: "255.255.0.0")
        ]
        
        // 5. 应用网络设置
        let tunnelNetworkSettings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: server)
        tunnelNetworkSettings.proxySettings = proxySettings
        tunnelNetworkSettings.ipv4Settings = ipv4Settings
        tunnelNetworkSettings.mtu = 1500
        
        // 6. 启动隧道
        self.setTunnelNetworkSettings(tunnelNetworkSettings) { error in
            if let error = error {
                os_log("Failed to set tunnel settings: %{public}@", log: self.logger, type: .error, error.localizedDescription)
                completionHandler(error)
                return
            }
            
            // 7. 启动本地 Shadowsocks 代理（需自行实现）
            self.startLocalShadowsocksProxy(
                server: server,
                port: serverPort,
                password: password,
                method: method
            ) { success in
                if success {
                    os_log("Tunnel started successfully", log: self.logger)
                    completionHandler(nil)
                } else {
                    completionHandler(NSError(domain: "ProxyError", code: 3, userInfo: nil))
                }
            }
        }
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        os_log("Stopping tunnel with reason: %d", log: logger, reason.rawValue)
        // 清理资源
        observer = nil
        completionHandler()
    }
    
    // MARK: - 本地 Shadowsocks 代理实现
    private func startLocalShadowsocksProxy(
        server: String,
        port: Int,
        password: String,
        method: String,
        completion: @escaping (Bool) -> Void
    ) {
        DispatchQueue.global().async {
            // 这里需要实现：
            // 1. 启动本地 SOCKS5 代理（端口如 1080）
            // 2. 将流量转发到 Shadowsocks 服务器
            // 3. 处理加密/解密
            
            // 伪代码示例：
            /*
            let ssLocal = ShadowsocksLocal()
            ssLocal.start(
                listenPort: 1080,
                server: server,
                serverPort: port,
                password: password,
                method: method
            )
            */
            
            DispatchQueue.main.async {
                completion(true) // 或根据实际结果返回
            }
        }
    }
}
