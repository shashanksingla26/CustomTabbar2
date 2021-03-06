//
//  Tabbar2.swift
//  CustomTabbar
//
//  Created by shashank on 05/03/21.
//

import SwiftUI

struct Tabbar: View {
    @Binding var selected :String
    @State var mid: CGFloat = 0
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack(spacing: 0) {
                    TabbarButton(image: "house", selected: $selected, mid: $mid)
                    TabbarButton(image: "bookmark", selected: $selected, mid: $mid)
                    TabbarButton(image: "message", selected: $selected, mid: $mid)
                    TabbarButton(image: "person", selected: $selected, mid: $mid)
                   
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                Spacer()
            }
           
            
//            .overlay(
//                Circle()
//                    .fill(Color.white)
//                    .frame(width: 6, height: 6)
//                    .offset(x: mid - 18, y: -5)
//                , alignment: .bottomLeading
//            )
            
        }
        .frame(height: 50 + safeArea.bottom)
        .background(
            Color.white
                .clipShape(Tabcureve(mid: mid))
        )
        .background(
            Circle()
                .fill(Color.white)
                .frame(width: 50, height: 50)
                .offset(x: mid - 25, y: -20)
            , alignment: .topLeading
        )
        
    }
}

var safeArea = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero

struct Tabbar2_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct Tabcureve: Shape {
    var mid: CGFloat
    var animatableData: CGFloat {
        get {
            return mid
        }
        set {
            self.mid = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
            path.move(to: CGPoint(x: mid - 50, y: 0))
            
            
            let to = CGPoint(x: mid, y: 40)
            let control1 = CGPoint(x: mid - 20, y: 0)
            let control2 = CGPoint(x: mid - 40, y: 40)

            let to1 = CGPoint(x: mid + 50, y: 0)
            
            let control3 = CGPoint(x: mid + 40, y: 40)
            let control4 = CGPoint(x: mid + 20, y: 0)

            path.addCurve(to: to, control1: control1, control2: control2)
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}



struct TabbarButton: View {
    var image: String
    @Binding var selected :String
    @Binding var mid: CGFloat
    var body: some View {
        GeometryReader { proxy -> AnyView in
            let mid = proxy.frame(in: .global).midX
            if selected == image, self.mid != mid {
                DispatchQueue.main.async {
                    withAnimation {
                        self.mid = mid
                    }
                }
            }
            return AnyView(
                ZStack {
                    Button(action: {
                        withAnimation {
                            self.selected = image
                        }
                    }, label: {
                        Image(systemName: image + "\(selected == image ? ".fill": "")")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("forgroundColor"))
                            .frame(width: 30, height: 30)
                            .offset(y: selected == image ? -20: 0)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
    }
}
