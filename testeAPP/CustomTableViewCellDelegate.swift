//
//  CustomTableViewCellDelegate.swift
//  testeAPP
//
//  Created by João Pedro Vieira Pereira on 09/11/16.
//  Copyright © 2016 SistemaInfo. All rights reserved.
//

import Foundation


protocol CustomTableViewCellDelegate {
    func tarefaItemDeletado(tarefa: String)
    func tarefaItemUpdate(tarefa: String)
}