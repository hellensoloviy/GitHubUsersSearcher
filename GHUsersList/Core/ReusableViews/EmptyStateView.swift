//
//  EmptyStateView.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 09.04.2023.
//

import Foundation
import UIKit

class EmptyStateView: UIView {
    enum State: String {
        case empty = " "
        case pleaseStart = "Please type to start searching :)"
        case noResults = "Opps! Looks like no results \nfor your search request. \nPlease try another one ^_^"
        case error  = "Something broke T_T \nWe are very sorry and will fix it as soon as possible"
        
        init(with status: SearchStatus) {
            switch status {
                case .initial, .resultsFound: self = .empty
                case .noResult: self = .noResults
                case .error: self = .error
                case .notStarted: self = .pleaseStart
            }
        }
    }
    
    private var state = State.empty {
        didSet {
            DispatchQueue.main.async {
                self.descriptionLabel.text = self.state.rawValue
            }
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    private let nibName = "EmptyStateView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        setupView(with: .pleaseStart)
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setup(with new: SearchStatus) {
        setupView(with: State(with: new))
    }
    
    // MARK: - 
    private func setupView(with newState: State) {
        guard self.state != newState else { return }
        self.state = newState
    }
    
}
