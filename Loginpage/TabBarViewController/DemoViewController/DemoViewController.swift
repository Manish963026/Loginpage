import UIKit
import MessageUI
import ContactsUI
import EventKit
import EventKitUI
import QuickLook
class DemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    @IBOutlet weak var settingButton: UIBarButtonItem!
    var previewController: QLPreviewController!
    var fileURLs: [URL] = []
    var imageURL: URL?
    private var tableView: UITableView!
    private var projectList: [String] = ["EMICalculator", "Calculator", "Message", "Mail",
                                         "contact", "Event", "DocumentPicker", "QLPreview"]
    private var eventStore: EKEventStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        eventStore = EKEventStore()
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            // Increase the size of the textLabel
//            cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0) // Adjust the size as needed
//        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = projectList[indexPath.row]
        if UIDevice.current.userInterfaceIdiom == .pad {
                    // Increase the size of the textLabel for iPad
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 26.0) // Adjust the size as needed
                }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let emiViewController = storyboard.instantiateViewController(withIdentifier:
                "EMICalculatorViewController") as? EMICalculatorViewController {
                navigationController?.pushViewController(emiViewController, animated: true)
            }
        }
        if indexPath.row == 1 {
            if let viewController = storyboard?.instantiateViewController(
                withIdentifier: "CalculatorViewController") as? CalculatorViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
        if indexPath.row == 2 {
            if MFMessageComposeViewController.canSendText() == true {
                let recipients: [String] = ["hii"]
                let messageController = MFMessageComposeViewController()
                messageController.messageComposeDelegate  = self
                messageController.recipients = recipients
                messageController.body = ""
                self.present(messageController, animated: true, completion: nil)
                func messageComposeViewController(controller: MFMessageComposeViewController,
                                                  didFinishWithResult result: MessageComposeResult) {
                    controller.dismiss(animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: "You are unenable to sand message", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if indexPath.row == 3 {
            if MFMailComposeViewController.canSendMail() {
                let mailController = MFMailComposeViewController()
                mailController.mailComposeDelegate = self
                mailController.setToRecipients(["recipient@example.com"])
                mailController.setSubject("Your Subject")
                mailController.setMessageBody("Your_message_body", isHTML: false)
                present(mailController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "You are unenable to sand mail", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if indexPath.row == 4 {
            showContactPicker()
        }
        func showContactPicker() {
            let contactPicker = CNContactPickerViewController()
            contactPicker.delegate = self
            navigationController?.present(contactPicker, animated: true, completion: nil)
        }
        if indexPath.row == 5 {
            requestCalendarAccess()
        }
        if indexPath.row == 6 {
            pickDocument()
        }
        if indexPath.row == 7 {
            if let viewController = storyboard?.instantiateViewController(
                withIdentifier: "PreviewFilesViewController") as? PreviewFilesViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBAction func settingPopoverAction(_ sender: Any) {
        popOver()
    }
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURLs[index] as QLPreviewItem
    }
}
extension DemoViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Message composition cancelled")
        case .sent:
            print("Message sent successfully")
        case .failed:
            print("Message sending failed")
        @unknown default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
extension DemoViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        handleMFResult(result.rawValue)
        controller.dismiss(animated: true, completion: nil)
    }
}
private extension DemoViewController {
    func handleMFResult(_ result: Int) {
        switch result {
        case MessageComposeResult.cancelled.rawValue, MFMailComposeResult.cancelled.rawValue:
            print("Composition cancelled")
        case MessageComposeResult.sent.rawValue, MFMailComposeResult.sent.rawValue:
            print("Sent successfully")
        case MessageComposeResult.failed.rawValue, MFMailComposeResult.failed.rawValue:
            print("Sending failed")
        default:
            break
        }
    }
}
extension DemoViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("Selected contact: \(contact.givenName) \(contact.familyName)")
        dismiss(animated: true)
        let alert = UIAlertController(title: "name:\(contact.givenName) \(contact.familyName)", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Contact picking cancelled")
    }

extension DemoViewController: UIDocumentPickerDelegate {
    func pickDocument() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.content"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            print("No document selected")
            return
        }
        print("Selected document URL: \(selectedFileURL)")
       // downloadPDFAndPresentPreview(selectedFileURL)
     //  let previewController = QLPreviewController()
     //   imageURL = URL(fileURLWithPath: selectedFileURL)
                 //  showPreview()
    }

}
extension DemoViewController: EKEventEditViewDelegate {
    func requestCalendarAccess() {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            showEventEditor(eventStore: eventStore)
        case .denied:
            print("Access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
                if granted {
                    self?.showEventEditor(eventStore: eventStore)
                } else {
                    print("Access denied")
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        default:
            print("Case Default")
        }
    }
    func showEventEditor(eventStore: EKEventStore) {
        let event = EKEvent(eventStore: eventStore)
        event.title = ""
        event.startDate = Date()
        event.endDate = Date().addingTimeInterval(60 * 60) // Event duration: 1 hour
        event.notes = ""
        let eventController = EKEventEditViewController()
        eventController.event = event
        eventController.eventStore = eventStore
        eventController.editViewDelegate = self
        present(eventController, animated: true, completion: nil)
    }
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        switch action {
        case .saved:
            print("Event saved successfully")
            if let event = controller.event {
                print("Event Identifier: \(String(describing: event.eventIdentifier))")
            }
        case .cancelled:
            print("Event editing cancelled")
        case .deleted:
            print("Event deleted")
        @unknown default:
            break
        }
        dismiss(animated: true, completion: nil)
    }
}
extension DemoViewController: UIPopoverPresentationControllerDelegate {
    func popOver() {
        guard let contentViewController = storyboard?.instantiateViewController(
            withIdentifier: "TableViewController") as? TableViewController
        else {
            return
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            contentViewController.preferredContentSize = CGSize(width: 700, height: 1000)
        }

        contentViewController.modalPresentationStyle = .popover
        if let popoverController = contentViewController.popoverPresentationController {
            popoverController.delegate = self
            popoverController.sourceView = view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.up
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
            present(contentViewController, animated: true, completion: nil)
        }
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
