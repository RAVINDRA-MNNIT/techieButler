//
//  Extension.swift
//  TechieButler
//
//  Created by Ravindra Arya on 03/05/24.
//

import Foundation
import UIKit

extension UITableViewCell
{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
