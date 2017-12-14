/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view controller that scans and displays NDEF messages.
*/

let light1 = "https://maker.ifttt.com/trigger/turn_on/with/key/cj64pSbDB8BqGoy9n6QUv2"
let light2 = "https://maker.ifttt.com/trigger/turn_on_2/with/key/cj64pSbDB8BqGoy9n6QUv2"
let light3 = "https://maker.ifttt.com/trigger/turn_on_3/with/key/cj64pSbDB8BqGoy9n6QUv2"

import UIKit
import CoreNFC
import Alamofire

/// - Tag: ndefReading_1
class MessagesTableViewController: UITableViewController, NFCNDEFReaderSessionDelegate {
    // MARK: - Properties

    let reuseIdentifier = "reuseIdentifier"
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?

    // MARK: - Actions
    
    /// - Tag: beginScanning
    @IBAction func beginScanning(_ sender: Any) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Process detected NFCNDEFMessage objects
        detectedMessages.append(contentsOf: messages)
        if let payload = String(data: messages[0].records[0].payload, encoding:.utf8) {
            if payload.contains("Hey tara") {
                print("start")
                Alamofire.request(light1)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check invalidation reason from the returned error. A new session instance is required to read new tags.
        if let readerError = error as? NFCReaderError {
            // Show alert dialog box when the invalidation reason is not because of a read success from the single tag read mode,
            // or user cancelled a multi-tag read mode session from the UI or programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(title: "Session Invalidated", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
