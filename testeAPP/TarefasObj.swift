//
//  tarefas.swift
//  testeAPP
//
//  Created by João Pedro Vieira Pereira on 10/11/16.
//  Copyright © 2016 SistemaInfo. All rights reserved.
//

import Foundation
import RealmSwift

class TarefasObj: Object {
    dynamic var name: String = ""
    dynamic var competed: Bool = false
}

