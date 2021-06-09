//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import SDWebImage

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Properties

    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.1058823529, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
        return label
    }()
    
    private var messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.textColor = #colorLiteral(red: 0.1058823529, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        textView.backgroundColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 16)
        return textView
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func setupCellView() {
        
        backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(messageTextView)
        
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        profileNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 7).isActive = true
        profileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        messageTextView.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 4).isActive = true
        messageTextView.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
    }
    
    
    // MARK: - Public
    func setCellData(message: Message) {
        profileImageView.sd_setImage(with: message.avatarURL, completed: nil)
        profileNameLabel.text = message.username
        messageTextView.text = message.text
    }
    
}
