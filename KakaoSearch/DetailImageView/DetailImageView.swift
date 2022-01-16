//
//  DetailImageView.swift
//  KakaoSearch
//
//  Created by skillist on 2022/01/15.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

class DetailImageView: UIViewController {
    let disposeBag = DisposeBag()
    
    private var statusView = UIView()
    private var closeButton = UIButton()
    private var titleLabel = UILabel()
    private var shareButton = UIButton()
    private var isFullScreen: Bool = true
    
    private lazy var titleView: UIView = {
        var uiView = UIView()
        [
            closeButton,
            titleLabel,
            shareButton
        ].forEach {
            uiView.addSubview($0)
        }
        
        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        shareButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(closeButton.snp.trailing).offset(8)
            $0.trailing.equalTo(shareButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
        
        return uiView
    }()
    
    private var imageView = UIImageView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailImageViewModel) {
//        viewModel.searchImageResult
        
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        titleLabel.text = viewModel.searchImageResult.displaySitename
        
        imageView.kf.setImage(with: URL(string: viewModel.searchImageResult.imageURL), placeholder: UIImage(systemName: "photo"))
    
        view.rx.tapGesture()
            .asDriver()
            .map { _ -> Bool in
                self.isFullScreen.toggle()
                return self.isFullScreen
            }
            .drive(onNext: { isHidden in
                self.statusView.isHidden = isHidden
                self.titleView.isHidden = isHidden
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        view.backgroundColor = .black
        
        statusView.backgroundColor = .darkGray
        titleView.backgroundColor = .darkGray
        
        closeButton.setTitle("Exit", for: .normal)
        closeButton.setTitleColor(.link, for: .normal)

        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.link, for: .normal)

        imageView.contentMode = .scaleAspectFit
    }
    
    private func layout() {
        [
            imageView,
            statusView,
            titleView
        ].forEach {
            view.addSubview($0)
        }
        
        statusView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
