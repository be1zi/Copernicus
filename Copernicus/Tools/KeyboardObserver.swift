//
//  KeyboardObserver.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 03/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation
import RxSwift

public final class KeyboardObserver {
    
    private let disposeBag = DisposeBag()
    
    public struct KeyboardInfo {
        
        public var frameBegin: CGRect = CGRect.zero
        public var frameEnd: CGRect = CGRect.zero
        
        init(_ notification: Notification) {
            if let endValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                self.frameEnd = endValue.cgRectValue
            }
            
            if let beginValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
                self.frameBegin = beginValue.cgRectValue
            }
        }
    }
    
    public let willChangeFrame = PublishSubject<KeyboardInfo>()
    public let didChangeFrame = PublishSubject<KeyboardInfo>()
    
    public let willShow = PublishSubject<KeyboardInfo>()
    public let didShow = PublishSubject<KeyboardInfo>()
    public let willHide = PublishSubject<KeyboardInfo>()
    public let didHide = PublishSubject<KeyboardInfo>()
    
    public init() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillChangeFrameNotification).map { KeyboardInfo($0) }.bind(to: self.willChangeFrame).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardDidChangeFrameNotification).map { KeyboardInfo($0) }.bind(to: self.didChangeFrame).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map { KeyboardInfo($0) }.bind(to: self.willShow).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardDidShowNotification).map { KeyboardInfo($0) }.bind(to: self.didShow).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).map { KeyboardInfo($0) }.bind(to: self.willHide).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardDidHideNotification).map { KeyboardInfo($0) }.bind(to: self.didHide).disposed(by: disposeBag)
    }
}
