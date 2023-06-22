//
//  RequestWithUserIdProtocol.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 22.06.23.
//

import Foundation

protocol RequestWithUserId: Encodable {
  mutating func setUserId(with newValue: String?)
}
