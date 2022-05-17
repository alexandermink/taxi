//
//  VIPERModuleViewOutput.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 03.02.2022.
//

protocol ViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

extension ViewOutput {
    func viewWillAppear() {  }
    func viewDidAppear() {  }
    func viewWillDisappear() {  }
    func viewDidDisappear() {  }
}
