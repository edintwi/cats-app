//
//  AppCoordinator.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import UIKit
import SwiftUI
protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    func start()
    func finish()
}

class AppCoordinator: Coordinator {
   
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeVM = CatListViewModel()
        let homeVC = CatListViewController(viewModel: homeVM)
        
        homeVM.onCatSelected = { [weak self] selectedItem in
            self?.pushCatDetails(for: selectedItem)
        }
        
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
    func finish() {
        print("HomeFlowCoordinator finished.")
    }

    func pushCatDetails(for cat: Cat) {
        let detailsVM = CatDetailsViewModel(cat: cat)
        let detailsVC = CatDetailsViewController(viewModel: detailsVM)
        let catDetailsSwiftUIView = CatDetailsView(viewModel: detailsVM)
        let hostingController = UIHostingController(rootView: catDetailsSwiftUIView)

        navigationController.pushViewController(hostingController, animated: true)
    }
}
