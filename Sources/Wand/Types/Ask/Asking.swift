//  Copyright © 2020-2022 El Machine 🤖
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Alex Kozin
//

public protocol Asking: Wanded {

    //TODO: static func |<C, T: Asking> (context: C?, ask: Ask<T>) -> Wand
    static func ask<T>(_ ask: Ask<T>, by wand: Wand)

}

///   context | { T in
///
///   }
@discardableResult
public func |<C, T: Asking> (context: C?, handler: @escaping (T)->() ) -> Wand {
    context | Ask.every(handler: handler)
}


///  Ask for:
///  - `every`
///  - `one`
///  - `while`
///
///   context | .one { T in
///
///   }
@discardableResult
public func |<C, T: Asking> (context: C?, ask: Ask<T>) -> Wand {
    let wand = Wand.attach(to: context)
    T.ask(ask, by: wand)

    return wand
}

@discardableResult
public func |<T: Asking> (wand: Wand, ask: Ask<T>) -> Wand {

    T.ask(ask, by: wand)
    return wand
}
