//
//  ChatDatasource.swift
//  iOSTest
//
//  Created by Tendaishe Gwini on 6/8/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class ChatDatasource: NSObject, UITableViewDataSource {
    
    //MARK: - Properties
    
    var messages: [Message] = []
    
    //MARK: - Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.setCellData(message: messages[indexPath.row])
        return cell
    }

}
