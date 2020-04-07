//
//  NSObject+Observation.swift
//  EroojaCommon
//
//  Created by 김태인 on 2020/04/07.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public protocol PropertyBindable {}

public extension PropertyBindable {
    func rprop<Value: Equatable>(_ keyPath: KeyPath<Self, Value>) -> ReadablePropertyPath<Self, Value> {
        return ReadablePropertyPath(self, keyPath: keyPath)
    }

    func prop<Value: Equatable>(_ keyPath: ReferenceWritableKeyPath<Self, Value>) -> PropertyPath<Self, Value> {
        return PropertyPath(self, keyPath: keyPath)
    }

    func prop<Value: Equatable, TgtValue: Equatable>(_ keyPath: ReferenceWritableKeyPath<Self, Value>, filter: @escaping (TgtValue) -> (Value)) -> FilteredPropertyPath<Self, Value, TgtValue> {
        return FilteredPropertyPath(self, keyPath: keyPath, filter: filter)
    }
}

extension NSObject: PropertyBindable {
    private struct AssociatedKeys {
        static var defaultDisposer: UInt8 = 0
    }

    public var defaultDisposer: Disposer {
        get { return getAssociated(self, key: &AssociatedKeys.defaultDisposer, initializer: { () -> Disposer in return Disposer() }) }
        set { setAssociated(self, key: &AssociatedKeys.defaultDisposer, value: newValue) }
    }
}

public struct ReadablePropertyPath<Root, Value: Equatable> {
    public let root: Root
    public let keyPath: KeyPath<Root, Value>

    public init(_ root: Root, keyPath: KeyPath<Root, Value>) {
        self.root = root
        self.keyPath = keyPath
    }
}

public struct PropertyPath<Root, Value: Equatable> {
    public let root: Root
    public let keyPath: ReferenceWritableKeyPath<Root, Value>

    public init(_ root: Root, keyPath: ReferenceWritableKeyPath<Root, Value>) {
        self.root = root
        self.keyPath = keyPath
    }
}

public struct FilteredPropertyPath<Root, Value: Equatable, TgtValue: Equatable> {
    public let root: Root
    public let keyPath: ReferenceWritableKeyPath<Root, Value>
    public let filter: (TgtValue) -> (Value)

    public init(_ root: Root, keyPath: ReferenceWritableKeyPath<Root, Value>, filter: @escaping (TgtValue) -> (Value)) {
        self.root = root
        self.keyPath = keyPath
        self.filter = filter
    }
}

precedencegroup PropertyBindingPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
}

infix operator <<- : PropertyBindingPrecedence
infix operator ->> : PropertyBindingPrecedence
infix operator <-> : PropertyBindingPrecedence
infix operator -/- : PropertyBindingPrecedence

public extension PropertyPath where Root: NSObject {
    func bindOn<Target: NSObject, TgtValue: Equatable>(_ target: PropertyPath<Target, TgtValue>,
                                                       filter: ((Value) -> (TgtValue))? = nil,
                                                       name: String? = nil) {
        self.root.bindOn(self.keyPath, target: target.root, tgtKeyPath: target.keyPath, filter: filter, name: name)
    }

    func bindOn<Target: NSObject, TgtValue: Equatable>(_ target: FilteredPropertyPath<Target, TgtValue, Value>,
                                                       name: String? = nil) {
        self.root.bindOn(self.keyPath, target: target.root, tgtKeyPath: target.keyPath, filter: target.filter, name: name)
    }

    func sync<Target: NSObject, TgtValue: Equatable>(_ target: PropertyPath<Target, TgtValue>,
                                                     srcFilter: ((TgtValue) -> (Value))? = nil,
                                                     tgtFilter: ((Value) -> (TgtValue))? = nil,
                                                     name: String? = nil) {
        self.root.sync(self.keyPath, target: target.root, tgtKeyPath: target.keyPath, srcFilter: srcFilter, tgtFilter: tgtFilter, name: name)
    }

    static func ->> <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: PropertyPath<Target, TgtValue>) {
        lhs.bindOn(rhs)
    }

    static func ->> <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: FilteredPropertyPath<Target, TgtValue, Value>) {
        lhs.bindOn(rhs)
    }

    static func <<- <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: PropertyPath<Target, TgtValue>) {
        rhs.bindOn(lhs)
    }

    static func <<- <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: ReadablePropertyPath<Target, TgtValue>) {
        rhs.bindOn(lhs)
    }

    static func <-> <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: PropertyPath<Target, TgtValue>) {
        lhs.sync(rhs)
    }

    static func -/- <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: PropertyPath<Target, TgtValue>) {
        lhs.root.unbind(lhs.keyPath, target: rhs.root, tgtKeyPath: rhs.keyPath)
        rhs.root.unbind(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
    }

    static func -/- <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: FilteredPropertyPath<Target, TgtValue, Value>) {
        lhs.root.unbind(lhs.keyPath, target: rhs.root, tgtKeyPath: rhs.keyPath)
        rhs.root.unbind(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
    }

    static func -/- <Target: NSObject, TgtValue: Equatable> (lhs: PropertyPath<Root, Value>, rhs: ReadablePropertyPath<Target, TgtValue>) {
        lhs.root.unbind(lhs.keyPath, target: rhs.root, tgtKeyPath: rhs.keyPath)
        rhs.root.unbind(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
    }
}

public extension ReadablePropertyPath where Root: NSObject {
    func bindOn<Target: NSObject, TgtValue: Equatable>(_ target: PropertyPath<Target, TgtValue>,
                                                       filter: ((Value) -> (TgtValue))? = nil,
                                                       name: String? = nil) {
        self.root.bindOn(self.keyPath, target: target.root, tgtKeyPath: target.keyPath, filter: filter, name: name)
    }

    func bindOn<Target: NSObject, TgtValue: Equatable>(_ target: FilteredPropertyPath<Target, TgtValue, Value>,
                                                       name: String? = nil) {
        self.root.bindOn(self.keyPath, target: target.root, tgtKeyPath: target.keyPath, filter: target.filter, name: name)
    }

    static func ->> <Target: NSObject, TgtValue: Equatable> (lhs: ReadablePropertyPath<Root, Value>, rhs: PropertyPath<Target, TgtValue>) {
        lhs.bindOn(rhs)
    }

    static func ->> <Target: NSObject, TgtValue: Equatable> (lhs: ReadablePropertyPath<Root, Value>, rhs: FilteredPropertyPath<Target, TgtValue, Value>) {
        lhs.bindOn(rhs)
    }

    static func -/- <Target: NSObject, TgtValue: Equatable> (lhs: ReadablePropertyPath<Root, Value>, rhs: FilteredPropertyPath<Target, TgtValue, Value>) {
        lhs.root.unbind(lhs.keyPath, target: rhs.root, tgtKeyPath: rhs.keyPath)
        rhs.root.unbind(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
    }
}

public extension FilteredPropertyPath where Root: NSObject {
    func sync<Target: NSObject>(_ target: FilteredPropertyPath<Target, TgtValue, Value>, name: String? = nil) {
        self.root.sync(self.keyPath, target: target.root, tgtKeyPath: target.keyPath, srcFilter: self.filter, tgtFilter: target.filter, name: name)
    }

    static func <<- <Target: NSObject> (lhs: FilteredPropertyPath<Root, Value, TgtValue>, rhs: PropertyPath<Target, TgtValue>) {
        rhs.bindOn(lhs)
    }

    static func <-> <Target: NSObject> (lhs: FilteredPropertyPath<Root, Value, TgtValue>, rhs: FilteredPropertyPath<Target, TgtValue, Value>) {
        lhs.sync(rhs)
    }

    static func -/- <Target: NSObject> (lhs: FilteredPropertyPath<Root, Value, TgtValue>, rhs: FilteredPropertyPath<Target, TgtValue, Value>) {
        lhs.root.unbind(lhs.keyPath, target: rhs.root, tgtKeyPath: rhs.keyPath)
        rhs.root.unbind(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
        rhs.root.syncOff(rhs.keyPath, target: lhs.root, tgtKeyPath: lhs.keyPath)
    }
}

var indent: String = ""
func stepInto() { indent.append("\t") }
func stepOut() { indent.removeLast() }
//func ELog.debug(message:_ string: String) { DebugLog(string) }
func debugLog(_ string: String) { }

extension NSObject {
    var objectId: String {
        return "\(type(of: self))(0x\(String(unsafeBitCast(self, to: Int.self), radix: 16, uppercase: false)))"
    }
}

public extension NSObjectProtocol where Self: NSObject {

    // 생성한 KvoDisposer를 직접 해제관리 해야하고 동일한 프로퍼티에 대해서 중복 생성 가능하다.
    func observer<Value: Equatable>(_ keyPath: KeyPath<Self, Value>,
                                    name: String? = nil,
                                    options: NSKeyValueObservingOptions? = nil,
                                    filter: ((Value) -> (Bool))? = nil,
                                    onChange: @escaping (Value) -> Void) -> KvoDisposer {
        return KvoDisposer(self.observe(keyPath, options: (options != nil) ? options!.union([.old, .new]) : [.old, .new]) { [weak self] _, change in
            guard let sself = self else { return }
            stepInto()

            let newValue = sself[keyPath: keyPath]
            let oldValue = change.oldValue
            ELog.debug(message:"\(indent)[NSObjectProtocol] observer ---------------------------------------")
            ELog.debug(message:"\(indent)keyPath: \(String(describing: type(of: sself))).\(NSExpression(forKeyPath: keyPath).keyPath)")
            ELog.debug(message:"\(indent)filter: \(String(describing: filter))")
            ELog.debug(message:"\(indent)name: \(String(describing: name))")
            ELog.debug(message:"\(indent)newValue: \(String(describing: newValue))")
            ELog.debug(message:"\(indent)oldValue: \(String(describing: oldValue))")

            let filtered = (filter != nil) ? filter!(newValue) : true
            ELog.debug(message:"\(indent)filtered: \(String(describing: filtered))")

            if filtered && oldValue != newValue {
                ELog.debug(message:"\(indent)onChange(\(String(describing: newValue)) !!!!!!!!!!!")
                onChange(newValue)
            }

            stepOut()
        }, name: name)
    }

    func binder<Value: Equatable, Target: NSObject, TgtValue: Equatable>(_ keyPath: KeyPath<Self, Value>,
                                                               target: Target,
                                                               tgtKeyPath: ReferenceWritableKeyPath<Target, TgtValue>,
                                                               filter: ((Value) -> (TgtValue))? = nil,
                                                               name: String? = nil) -> KvoDisposer {
        return KvoDisposer(self.observe(keyPath, options: [.initial, .new]) { [weak self, weak target] _, _ in
            guard let sself = self, let starget = target else { return }
            stepInto()

            let srcValue = sself[keyPath: keyPath]
            let tgTgtValue = starget[keyPath: tgtKeyPath]
            ELog.debug(message:"\(indent)[NSObjectProtocol] binder ---------------------------------------")
            ELog.debug(message:"\(indent)keyPath: \(String(describing: type(of: sself))).\(NSExpression(forKeyPath: keyPath).keyPath) ->> \(String(describing: type(of: target))).\(NSExpression(forKeyPath: tgtKeyPath).keyPath)")
            ELog.debug(message:"\(indent)filter: \(String(describing: filter))")
            ELog.debug(message:"\(indent)name: \(String(describing: name))")
            ELog.debug(message:"\(indent)srcValue: \(String(describing: srcValue))")
            ELog.debug(message:"\(indent)tgTgtValue: \(String(describing: tgTgtValue))")

            if (filter == nil) && (srcValue is TgtValue == false) {
                ELog.debug(message:"\(indent)can not bind on target: (\(String(describing: Value.self)) -> \(String(describing: TgtValue.self))) !!!!!!!!!!!")
                return
            }

            let filtered = (filter != nil) ? filter!(srcValue) : (srcValue as! TgtValue)
            ELog.debug(message:"\(indent)filtered: \(String(describing: filtered))")

            if tgTgtValue != filtered {
                ELog.debug(message:"\(indent)binding(\(String(describing: tgTgtValue)) -> \(String(describing: filtered))) !!!!!!!!!!!")
                starget[keyPath: tgtKeyPath] = filtered
            }

            stepOut()
        }, name: name)
    }

    // 동기화 초기값은 target의 값으로 한다.
    func synchronizer<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: ReferenceWritableKeyPath<Self, SrcValue>,
                                                                                  target: Target,
                                                                                  tgtKeyPath: ReferenceWritableKeyPath<Target, TgtValue>,
                                                                                  srcFilter: ((TgtValue) -> (SrcValue))? = nil,
                                                                                  tgtFilter: ((SrcValue) -> (TgtValue))? = nil,
                                                                                  name: String? = nil) -> [KvoDisposer] {
        var disposers: [KvoDisposer] = []
        let binderTargetName = name != nil ? name!+".target" : nil
        let binderSourceName = name != nil ? name!+".source" : nil
        disposers.append(target.binder(tgtKeyPath, target: self, tgtKeyPath: srcKeyPath, filter: srcFilter, name: binderTargetName))
        disposers.append(self.binder(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath, filter: tgtFilter, name: binderSourceName))
        return disposers
    }

    // 이름을 지정하지 않을 경우 기본이름으로 지정해서 편하게 중복 생성을 방지하고 defaultDisposer를 이용해 해제관리하게 해준다.
    func trace<Target: NSObject, Value: Equatable>(_ target: Target,
                                                   keyPath: KeyPath<Target, Value>,
                                                   name: String? = nil,
                                                   options: NSKeyValueObservingOptions? = nil,
                                                   filter: ((Value) -> (Bool))? = nil,
                                                   onChange: @escaping (Value) -> Void) {
        let observerName = name ?? self.traceName(target, tgtKeyPath: keyPath)
        target.observer(keyPath, name: observerName, options: options, filter: filter, onChange: onChange).addOn(self.defaultDisposer)
    }

    func rtrace<Target: NSObject, Value: Equatable>(_ target: ReadablePropertyPath<Target, Value>,
                                                    name: String? = nil,
                                                    options: NSKeyValueObservingOptions? = nil,
                                                    filter: ((Value) -> (Bool))? = nil,
                                                    onChange: @escaping (Value) -> Void) {
        self.trace(target.root, keyPath: target.keyPath, name: name, options: options, filter: filter, onChange: onChange)
    }

    func trace<Target: NSObject, Value: Equatable>(_ target: PropertyPath<Target, Value>,
                                                   name: String? = nil,
                                                   options: NSKeyValueObservingOptions? = nil,
                                                   filter: ((Value) -> (Bool))? = nil,
                                                   onChange: @escaping (Value) -> Void) {
        self.trace(target.root, keyPath: target.keyPath, name: name, options: options, filter: filter, onChange: onChange)
    }

    func bindTo<Value: Equatable, Source: NSObject, SrcValue: Equatable>(_ keyPath: ReferenceWritableKeyPath<Self, Value>,
                                                                         source: Source,
                                                                         srcKeyPath: KeyPath<Source, SrcValue>,
                                                                         filter: ((SrcValue) -> (Value))? = nil,
                                                                         name: String? = nil) {
        let binderName = name ?? source.binderName(srcKeyPath, target: self, tgtKeyPath: keyPath)
        source.binder(srcKeyPath, target: self, tgtKeyPath: keyPath, filter: filter, name: binderName).addOn(self.defaultDisposer)
    }

    func bindOn<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: KeyPath<Self, SrcValue>,
                                                                            target: Target,
                                                                            tgtKeyPath: ReferenceWritableKeyPath<Target, TgtValue>,
                                                                            filter: ((SrcValue) -> (TgtValue))? = nil,
                                                                            name: String? = nil) {
        let binderName = name ?? self.binderName(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath)
        self.binder(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath, filter: filter, name: binderName).addOn(target.defaultDisposer)
    }

    func sync<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: ReferenceWritableKeyPath<Self, SrcValue>,
                                                                          target: Target,
                                                                          tgtKeyPath: ReferenceWritableKeyPath<Target, TgtValue>,
                                                                          srcFilter: ((TgtValue) -> (SrcValue))? = nil,
                                                                          tgtFilter: ((SrcValue) -> (TgtValue))? = nil,
                                                                          name: String? = nil) {
        self.synchronizer(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath, srcFilter: srcFilter, tgtFilter: tgtFilter,
                          name: name ?? self.synchronizerName(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath)).addOn(self.defaultDisposer)
    }

    func cancelTrace<Target: NSObject, Value: Equatable>(_ target: PropertyPath<Target, Value>) {
        target.root.defaultDisposer.removeWithName(self.traceName(target.root, tgtKeyPath: target.keyPath))
    }

    func unbind<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: KeyPath<Self, SrcValue>,
                                                                            target: Target,
                                                                            tgtKeyPath: KeyPath<Target, TgtValue>) {
        target.defaultDisposer.removeWithName(self.binderName(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath))
    }

    func syncOff<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: KeyPath<Self, SrcValue>,
                                                                            target: Target,
                                                                            tgtKeyPath: KeyPath<Target, TgtValue>) {
        self.defaultDisposer.removeWithName(self.synchronizerName(srcKeyPath, target: target, tgtKeyPath: tgtKeyPath))
    }

    private func traceName<Target: NSObject, TgtValue: Equatable>(_ target: Target,
                                                                  tgtKeyPath: KeyPath<Target, TgtValue>) -> String {
        return "\(target.objectId).\(NSExpression(forKeyPath: tgtKeyPath).keyPath).tracer"
    }

    private func binderName<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: KeyPath<Self, SrcValue>,
                                                                                        target: Target,
                                                                                        tgtKeyPath: KeyPath<Target, TgtValue>) -> String {
        return "\(self.objectId).\(NSExpression(forKeyPath: srcKeyPath).keyPath).to.\(target.objectId).\(NSExpression(forKeyPath: tgtKeyPath).keyPath).binder"
    }

    private func synchronizerName<SrcValue: Equatable, Target: NSObject, TgtValue: Equatable>(_ srcKeyPath: KeyPath<Self, SrcValue>,
                                                                                              target: Target,
                                                                                              tgtKeyPath: KeyPath<Target, TgtValue>) -> String {
        return "\(self.objectId).\(NSExpression(forKeyPath: srcKeyPath).keyPath).to.\(target.objectId).\(NSExpression(forKeyPath: tgtKeyPath).keyPath).synchronizer"
    }
}

public extension NSKeyValueObservation {
    func disposable(name: String? = nil) -> Disposable {
        return KvoDisposer(self, name: name)
    }

    func addOn(_ toDisposer: Disposer, name: String) {
        self.disposable(name: name).addOn(toDisposer)
    }
}

public extension Array where Element == NSKeyValueObservation {
    func disposables(name: String? = nil) -> [Disposable] {
        var disposables = [Disposable]()
        self.enumerated().forEach { index, observation in
            disposables.append(KvoDisposer(observation, name: name ?? name!+"_\(index)"))
        }
        return disposables
    }

    func addOn(_ toDisposer: Disposer, name: String) {
        self.disposables(name: name).forEach { $0.addOn(toDisposer) }
    }
}

public extension Array where Element: Disposable {
    func addOn(_ toDisposer: Disposer) {
        self.forEach { $0.addOn(toDisposer) }
    }
}

public struct DisposableBlock: Disposable {
    let block: () -> Void
    let blockName: String?

    init(_ disposeBlock: @escaping () -> Void, name: String? = nil) {
        self.block = disposeBlock
        self.blockName = name
    }

    public var name: String? { return self.blockName }
    public func dispose() {
        self.block()
    }
}

public struct KvoDisposer: Disposable {
    let observation: NSKeyValueObservation
    let observerName: String?

    init(_ observation: NSKeyValueObservation, name: String? = nil) {
        self.observation = observation
        self.observerName = name
    }

    public var name: String? { return self.observerName }
    public func dispose() {
        self.observation.invalidate()
    }
}

public protocol Disposable {
    var name: String? { get }
    func dispose()
}

public extension Disposable {
    func addOn(_ disposer: Disposer) {
        disposer.add(self)
    }

    func escape(_ disposer: Disposer) {
        disposer.remove(self)
    }
}

public class Disposer {
    var disposables = [Disposable]()

    deinit {
        ELog.debug(message:"[Disposer] deinit: \(self.disposables))")
        self.removeAll()
    }

    public init() {}

    public func add(_ disposable: Disposable) {
        ELog.debug(message:"[Disposer] add(disposable: \(String(describing: disposable.name)))")
        self.removeWithName(disposable.name)
        self.disposables.append(disposable)
    }

    public func add(disposeBlock: @escaping () -> Void, name: String? = nil) {
        ELog.debug(message:"[Disposer] add(disposeBlock: \(String(describing: name)))")
        self.add(DisposableBlock(disposeBlock, name: name))
    }

    public func remove(_ disposable: Disposable) {
        self.removeWithName(disposable.name)
    }

    public func removeWithName(_ name: String?) {
        if let name = name, let index = self.disposables.firstIndex(where: { $0.name == name }) {
            ELog.debug(message:"[Disposer] removeWithName: \(name))")
            self.disposables[index].dispose()
            self.disposables.remove(at: index)
        }
    }

    public func removeAll() {
        ELog.debug(message:"[Disposer] removeAll")

        self.disposables.forEach {
            ELog.debug(message:"[Disposer] dispose: \(String(describing: $0.name)))")
            if let name = $0.name, name.contains("ColorBit") {
                ELog.debug(message:"------------------------------------------------------------------------)")
            }
            $0.dispose()
        }
        self.disposables.removeAll()
    }

    public func copy() -> Disposer {
        let disposer = Disposer()
        self.disposables.forEach { disposable in
            disposer.add(disposable)
        }
        return disposer
    }
}
