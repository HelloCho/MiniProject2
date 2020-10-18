//
//  ChattingViewController.swift
//  kakaotalk_starter
//
//  Created by home on 2020/10/16.
//  Copyright © 2020 James Kim. All rights reserved.
//

import UIKit

class ChattingViewController: UIViewController {

    @IBOutlet weak var chatTable: UITableView!
    
    @IBOutlet weak var inputChat: UITextView!
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var inputChatConstraintHeight: NSLayoutConstraint!
    
    var chatDatas = [String]()
    var messageInfo: Message? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatTable.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")
        chatTable.register(UINib(nibName: "YourCell", bundle: nil), forCellReuseIdentifier: "yourCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(noti: Notification) {
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height - self.self.view.safeAreaInsets.bottom
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.bottomMargin.constant = height
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        let notiInfo = noti.userInfo!
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.bottomMargin.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func sendChat(_ sender: UIButton) {
        chatDatas.append(inputChat.text)
        inputChat.text = ""
        inputChatConstraintHeight.constant = 40
        // chatTable.reloadData()
        let lastIndexPath = IndexPath(row: chatDatas.count-1, section: 0)
        chatTable.insertRows(at: [lastIndexPath], with: .bottom)
        
        chatTable.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
}

extension ChattingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row % 2 == 0) {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
            myCell.inputTextField.text = chatDatas[indexPath.row]
            myCell.myImage.image = UIImage(named: "snoopy.jpg")
            return myCell
        } else {
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "yourCell", for: indexPath) as! YourCell
            yourCell.inputTextField.text = chatDatas[indexPath.row]
            let chatUserName = messageInfo?.senderImageName ?? ""
            yourCell.yourImage.image = UIImage(named: "\(chatUserName).jpg")
            return yourCell
        }
    }
}

extension ChattingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if inputChat.contentSize.height <= 40 {
            inputChatConstraintHeight.constant = 40
        } else if inputChat.contentSize.height >= 120 {
            inputChatConstraintHeight.constant = 120
        } else {
            inputChatConstraintHeight.constant = inputChat.contentSize.height
        }
    }
}
