import Flutter
import UIKit
import MercariQRScanner

public class SwiftDynamicQrcodeScannnerPlugin: NSObject, FlutterPlugin {
    
    let rootVC = (UIApplication.shared.delegate?.window??.rootViewController)!
    var scanV: QRScannerView?
    var scanResult: FlutterResult?
    
    public override init() {
        super.init()
        scanV = QRScannerView.init(frame: UIScreen.main.bounds)
        scanV?.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        scanV?.backgroundColor = UIColor.orange;
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "dynamic_qrcode_scannner", binaryMessenger: registrar.messenger())
        let instance = SwiftDynamicQrcodeScannnerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        if (call.method == "scanQrCode"){
            scanQrCode(call, result: result)
        }else{
            result("iOS " + UIDevice.current.systemVersion)
        }
    }
    func scanQrCode(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        rootVC.view.addSubview(scanV ?? QRScannerView.init())
        scanResult = result
        scanV?.startRunning()
    }
}


// MARK: - QRScannerViewDelegate
extension SwiftDynamicQrcodeScannnerPlugin: QRScannerViewDelegate {
    public func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        scanResult?(error.localizedDescription)
    }

    public func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        scanResult?(code)
    }
//    public func qrScannerView(_ qrScannerView: QRScannerView, didChangeTorchActive isOn: Bool) {
//
//    }
}
